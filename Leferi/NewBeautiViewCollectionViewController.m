//
//  NewBeautiViewCollectionViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 10. 28..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "NewBeautiViewCollectionViewController.h"
#define pinkColor colorWithRed:0.88 green:0.13 blue:0.54 alpha:1.0

@interface NewBeautiViewCollectionViewController ()

@end

@implementation NewBeautiViewCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //StatusBar Setting
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    //Navigation Setting
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"instaTitleBar.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem customBackButtonWithImage:[UIImage imageNamed:@"backButton.png"] Target:self action:@selector(back:)]];
    
    //Cache Loading
    NSDictionary *pathPlist = [NSDictionary dictionaryWithContentsOfFile:[ETCLibrary getPath]];
    NSDictionary *configDict = [NSDictionary dictionaryWithContentsOfFile:[pathPlist objectForKey:@"config"]];
    //loadString = [pathPlist objectForKey:@"instaLoad"];
    //headString = [pathPlist objectForKey:@"instaHead"];
    //tagString = [configDict objectForKey:@"beautiTag"];
    headString = @"instaHeadImage@3x.png";
    loadString = @"instaLoading@3x.png";
    tagString = @"샤넬립스틱";
    
    CSStickyHeaderFlowLayout *layout = (id)self.collectionViewLayout;
    
    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
        layout.parallaxHeaderReferenceSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
        layout.itemSize = CGSizeMake(self.view.frame.size.width, layout.itemSize.height);
    }
//    layout.parallaxHeaderMinimumReferenceSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    //    layout.disableStickyHeaders = NO;
    
    UINib *headerNib = [UINib nibWithNibName:@"instagramHeader" bundle:nil];
    [self.collectionView registerNib:headerNib
          forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader
                 withReuseIdentifier:@"header"];
    
    
    
    [self loadMedia];
    
    //NavigationBar Fade out
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    } [self.navigationController.navigationBar setTranslucent:NO];
    [self followScrollView:self.collectionView withDelay:65];
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    

    
}

///Get media from Tag.c
- (void)getMediaFromTag:(NSString *)tag {
    [mediaArray removeAllObjects];
    [[InstagramEngine sharedEngine] getMediaWithTagName:tag count:15 maxId:self.currentPaginationInfo.nextMaxId withSuccess:^(NSArray *media, InstagramPaginationInfo *paginationInfo) {
        self.currentPaginationInfo = paginationInfo;
        [mediaArray addObjectsFromArray:media];
        [self.collectionView reloadData];
        
        
    } failure:^(NSError *error) {
        NSLog(@"Search Media Failed");
    }];
}

///Load popular media. If token fail then loaded it.
- (void)loadPopularMedia {
    [[InstagramEngine sharedEngine] getPopularMediaWithSuccess:^(NSArray *media, InstagramPaginationInfo *paginationInfo) {
        [mediaArray removeAllObjects];
        [mediaArray addObjectsFromArray:media];
        [self.collectionView reloadData];
        NSLog(@"pop");
    } failure:^(NSError *error) {
        NSLog(@"Load Popular Media Failed");
    }];
}


- (void)loadMedia {
    mediaArray = [NSMutableArray new];
    InstagramEngine *sharedEngine = [InstagramEngine sharedEngine];
    
    if (sharedEngine.accessToken) {
        [self getMediaFromTag:tagString];
        login = YES;
        NSLog(@"Success");
    } else {
        //        [self loadPopularMedia];
        [self getMediaFromTag:@"샤넬립스틱"];
        NSLog(@"token:%@",sharedEngine.accessToken);
        NSLog(@"Token getting is FAIL");
        login = NO;
    }
}

///Created Date is returned to use in Header Section
- (NSString *)returnCreatedDate:(NSDate *)createdDate {
    NSString *newStringDate;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //[dateFormat setDateFormat:@"yyyy. MM. dd h:mm a"];
    [dateFormat setDateFormat:@"yyyy. MM. dd"];
    newStringDate = [dateFormat stringFromDate:[NSDate new]];
    
    return newStringDate;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return mediaArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        InstagramMedia *media = mediaArray[indexPath.section];
        BeautiCollectionViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                          withReuseIdentifier:@"InstaUserSectionHeader"
                                                                                 forIndexPath:indexPath];
        [cell.userProfileBtn setClipsToBounds:YES];
        [cell.userProfileBtn.layer setCornerRadius:cell.userProfileBtn.bounds.size.width / 2.0];
        [cell.userProfileBtn setImageForState:UIControlStateNormal withURL:media.user.profilePictureURL];
        [cell.userName setText:media.user.username];
        [cell.createdDate setText:[self returnCreatedDate:media.createdDate]];
        return cell;
    } else if ([kind isEqualToString:CSStickyHeaderParallaxHeader]) {
        HeadCollectionViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                          withReuseIdentifier:@"header"
                                                                                 forIndexPath:indexPath];
        [cell.headImage setImage:[UIImage imageNamed:headString]];
        return cell;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    InstagramMedia *media = mediaArray[indexPath.section];
    BeautiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"instaCell" forIndexPath:indexPath];
    
    if (mediaArray.count >= indexPath.row + 1) {    //indexPath.row + 1
        NSLog(@"index:%ld", (long)indexPath.section);
//        [cell.userProfileBtn setClipsToBounds:YES];
//        [cell.userProfileBtn.layer setCornerRadius:cell.userProfileBtn.bounds.size.width / 2.0];
//        [cell.userProfileBtn setImageForState:UIControlStateNormal withURL:media.user.profilePictureURL];
//        [cell.userName setText:media.user.username];
//        [cell.createdDate setText:[self returnCreatedDate:media.createdDate]];
        //[cell.followBrn addTarget:self action:@selector(followUser) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.instaImageView setImage:[UIImage imageNamed:loadString]];
        [cell.instaImageView setImageWithURL:media.standardResolutionImageURL];
        [cell.likeBtn setTitle:[NSString stringWithFormat:@" %ld", (long)media.likesCount] forState:UIControlStateNormal];
        [self userCaption:cell withCaption:media.caption.text];
        [self userComment:cell withMedia:media];
        NSLog(@"comment:%@", cell.comment);
    } else {
        [cell.instaImageView setImage:nil];
        NSLog(@"Sorry. Image is nil");
    }
    return cell;
    
}
- (void)userCaption:(BeautiCollectionViewCell *)cell withCaption:(NSString *)caption{
    if (caption == nil) {
        //        [cell.caption setHidden:YES];
        [cell.caption setText:@""];
        //[cell.caption sizeToFit];
        return;
    }
    NSError *error = nil;
    NSRegularExpression *mentRegex = [NSRegularExpression regularExpressionWithPattern:@"@\\S+" options:NSRegularExpressionCaseInsensitive error:&error];
    NSRegularExpression *hashRegex = [NSRegularExpression regularExpressionWithPattern:@"#\\S+" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSAssert(error == nil, @"Regular expression was not valid");
    
    UIFont *mentFont = [UIFont fontWithName:@"NanumGothicOTFLight" size:15];
    UIFont *hashFont = [UIFont fontWithName:@"NanumGothicOTFLight" size:15];
    
    NSMutableAttributedString *styledCaptionString = [[NSMutableAttributedString alloc]initWithString:caption];
    NSMutableParagraphStyle *paraString = [[NSParagraphStyle defaultParagraphStyle]mutableCopy];
    [paraString setParagraphSpacing:15.0f];
    [paraString setAlignment:NSTextAlignmentCenter];
    
    ///String Style
    [styledCaptionString addAttributes:@{NSParagraphStyleAttributeName:paraString}
                                 range:[caption rangeOfString:caption]];
    
    ///@Configure
    [mentRegex enumerateMatchesInString:caption
                                options:0
                                  range:NSMakeRange(0, [caption length])
                             usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                 NSString *linkContent = [NSString stringWithFormat:@"app-custom-scheme://hashtag?tag=%@",
                                                          [caption substringWithRange:result.range], nil];
                                 [styledCaptionString addAttributes:@{//NSLinkAttributeName:[NSURL URLWithString:linkContent],
                                                                      NSFontAttributeName:mentFont,
                                                                      NSForegroundColorAttributeName:[UIColor pinkColor]}
                                                              range:result.range];
                             }
     ];
    
    ///#Configure
    [hashRegex enumerateMatchesInString:caption
                                options:0
                                  range:NSMakeRange(0, [caption length])
                             usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                 NSString *linkContent = [NSString stringWithFormat:@"app-custom-scheme://hashtag?tag=%@",
                                                          [caption substringWithRange:result.range], nil];
                                 [styledCaptionString addAttributes:@{//NSLinkAttributeName:[NSURL URLWithString:linkContent],
                                                                      NSFontAttributeName:hashFont,
                                                                      NSForegroundColorAttributeName:[UIColor pinkColor]}
                                                              range:result.range];
                             }
     ]; [cell.caption setAttributedText:styledCaptionString];
        [cell.caption sizeToFit];
    //    [cell.caption setNumberOfLines:0];
}


///Setting Comment in Instagram
- (void)userComment:(BeautiCollectionViewCell *)cell withMedia:(InstagramMedia *)media{
    NSError *error = nil;
    NSRegularExpression *hashRegex = [NSRegularExpression regularExpressionWithPattern:@"#\\S+" options:NSRegularExpressionCaseInsensitive error:&error];
    NSRegularExpression *mentRegex = [NSRegularExpression regularExpressionWithPattern:@"@\\S+" options:NSRegularExpressionCaseInsensitive error:&error];
    NSAssert(error == nil, @"Regular expression was not valid");
    
    [[InstagramEngine sharedEngine] getCommentsOnMedia:media.Id withSuccess:^(NSArray *comments) {
        //if comments is nil, then return
        if (comments.count == 0) {
            
            //            [cell.comment removeFromSuperview];
            //            [cell.comment setHidden:YES];
            [cell.comment setText:@""];
            //[cell.caption sizeToFit];
            return;
        }
        NSString *commentString;
        NSMutableArray *resultArray = [[NSMutableArray alloc]initWithCapacity:50];
        UIFont *mentFont = [UIFont fontWithName:@"NanumGothicOTFLight" size:14];
        UIFont *hashFont = [UIFont fontWithName:@"NanumGothicOTFLight" size:14];
        
        for (InstagramComment *comment in comments) {
            commentString = [NSString stringWithFormat:@"%@ %@\n", comment.user.username, comment.text];
            
            NSMutableAttributedString *styledCommentString = [[NSMutableAttributedString alloc]initWithString:commentString];
            NSMutableParagraphStyle *paraString = [[NSParagraphStyle defaultParagraphStyle]mutableCopy];
            [paraString setParagraphSpacing:15.0f];
            [paraString setAlignment:NSTextAlignmentCenter];
            
            ///Commenting User Name
            [styledCommentString setAttributes:@{NSForegroundColorAttributeName:[UIColor pinkColor],
                                                 NSFontAttributeName:[UIFont fontWithName:@"NanumGothicOTFBold" size:14]}
                                         range:[commentString rangeOfString:comment.user.username]];
            [styledCommentString addAttributes:@{NSParagraphStyleAttributeName:paraString}
                                         range:[commentString rangeOfString:commentString]];
            
            ///@Configure
            [mentRegex enumerateMatchesInString:commentString
                                        options:0
                                          range:NSMakeRange(0, [commentString length])
                                     usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                         NSString *linkContent = [NSString stringWithFormat:@"app-custom-scheme://hashtag?tag=%@",
                                                                  [commentString substringWithRange:result.range], nil];
                                         [styledCommentString addAttributes:@{//NSLinkAttributeName:[NSURL URLWithString:linkContent],
                                                                              NSFontAttributeName:mentFont,
                                                                              NSForegroundColorAttributeName:[UIColor pinkColor]}
                                                                      range:result.range];
                                     }
             ];
            
            ///#Configure
            [hashRegex enumerateMatchesInString:commentString
                                        options:0
                                          range:NSMakeRange(0, [commentString length])
                                     usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                         NSString *linkContent = [NSString stringWithFormat:@"app-custom-scheme://hashtag?tag=%@",
                                                                  [commentString substringWithRange:result.range], nil];
                                         [styledCommentString addAttributes:@{//NSLinkAttributeName:[NSURL URLWithString:linkContent],
                                                                              NSFontAttributeName:hashFont,
                                                                              NSForegroundColorAttributeName:[UIColor pinkColor]}
                                                                      range:result.range];
                                     }
             ];
            [resultArray addObject:styledCommentString];
        }
        NSMutableAttributedString *resultString = [[NSMutableAttributedString alloc]init];
        
        for (int i = 0; i < resultArray.count; ++i) {
            [resultString appendAttributedString:[resultArray objectAtIndex:i]];
        }
        //resultString
        //        NSLog(@"result:%@",resultString);
        [cell.comment setAttributedText:resultString];
                [cell.comment sizeToFit];
        //        [cell.comment setNumberOfLines:0];
        
    } failure:^(NSError *error) {
        NSLog(@"Could not load comments");
    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //return [(NSString*)[arrayOfStats objectAtIndex:indexPath.row] sizeWithAttributes:NULL];
    return CGSizeMake(320, 600);
}

- (IBAction)back:(id)sender {
    //Cache Loading
    [[UIApplication sharedApplication] setStatusBarStyle:[ETCLibrary getStatusBarFontColor]];
    [self performSegueWithIdentifier:@"backMenuFromBeauti" sender:self];
    //    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
