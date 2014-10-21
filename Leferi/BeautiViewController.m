//
//  BeautiViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 27..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#define pinkColor colorWithRed:0.88 green:0.13 blue:0.54 alpha:1.0
#import "BeautiViewController.h"

@interface BeautiViewController ()

//- (UIButton *)makingRoundButtonWithImage:(UIImage *)buttonImage buttonForX:(NSInteger)buttonX buttonForY:(NSInteger)buttonY buttonForSize:(NSInteger)buttonSize;

@end

@implementation BeautiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //font string search
//    for (NSString* family in [UIFont familyNames])
//    {
//        NSLog(@"%@", family);
//        
//        for (NSString* name in [UIFont fontNamesForFamilyName: family])
//        {
//            NSLog(@"  %@", name);
//        }
//    }
    

    //StatusBar Setting
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    //Navigation Setting
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"instaTitleBar.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem customBackButtonWithImage:[UIImage imageNamed:@"backButton.png"] Target:self action:@selector(back:)]];
    
    //Cache Loading
    NSDictionary *pathPlist = [NSDictionary dictionaryWithContentsOfFile:[ETCLibrary getPath]];
    NSDictionary *urlDict = [NSDictionary dictionaryWithContentsOfFile:[pathPlist objectForKey:@"config"]];
    
    //TitleImage & tag Setting
    [self.headImageView setImage:[UIImage imageNamed:[pathPlist objectForKey:@"instaHead"]]];
    self.tagString = [urlDict objectForKey:@"beautiTag"];
    
    NSLog(@"%@",self.tagString);
    //NavigationBar Fade out
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    } [self.navigationController.navigationBar setTranslucent:NO];
    [self followScrollView:self.tableView withDelay:65];
    
//    //Setting Header Height
    [self.tableView setEstimatedRowHeight:600.0];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    //self.tableView.estimatedRowHeight = 500.0;
    //    self.tableView.rowHeight = UITableViewAutomaticDimension;

    
    //Instagram Load
    [self loadMedia];
}

- (void)viewDidLayoutSubviews {
    [self.tableView layoutIfNeeded];
    [self.view layoutIfNeeded];
//    let testSize : CGSize = CGSizeMake(self.tableView.bounds.size.width, CGFloat.max)
//    let tableHeight : CGFloat = self.tableView.sizeThatFits(testSize).height
//    self.tableViewHeightConstraint.constant = tableHeight
//    
//    self.view.layoutIfNeeded()
//    
//    self.containerViewHeightConstraint.constant = tableHeight + 350 // this is the fixed height of the image
//    
//    self.view.layoutIfNeeded()
//    
//    self.tableView.reloadData()

}


#pragma mark - InstaGram Setting Func
///Basic parameter and Method init
- (void)loadMedia {
    mediaArray = [NSMutableArray new];
    InstagramEngine *sharedEngine = [InstagramEngine sharedEngine];
    
    if (sharedEngine.accessToken) {
        [self getMediaFromTag:self.tagString];
        login = YES;
        NSLog(@"Success");
    } else {
//        [self loadPopularMedia];
        [self getMediaFromTag:self.tagString];
        NSLog(@"%@",sharedEngine.accessToken);
        NSLog(@"Token getting is FAIL");
        login = NO;
    }
}

- (void)reloadMedia {
    self.currentPaginationInfo = nil;
    if (mediaArray) {
        [mediaArray removeAllObjects];
    } [self loadMedia];
}

///Get media from Tag.
- (void)getMediaFromTag:(NSString *)tag {
    [mediaArray removeAllObjects];
    [[InstagramEngine sharedEngine] getMediaWithTagName:tag count:20 maxId:self.currentPaginationInfo.nextMaxId withSuccess:^(NSArray *media, InstagramPaginationInfo *paginationInfo) {
        self.currentPaginationInfo = paginationInfo;
        [mediaArray addObjectsFromArray:media];
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        NSLog(@"Search Media Failed");
    }];
}

///Load popular media. If token fail then loaded it.
- (void)loadPopularMedia {
    [[InstagramEngine sharedEngine] getPopularMediaWithSuccess:^(NSArray *media, InstagramPaginationInfo *paginationInfo) {
        [mediaArray removeAllObjects];
        [mediaArray addObjectsFromArray:media];
        [self.tableView reloadData];
        NSLog(@"pop");
    } failure:^(NSError *error) {
        NSLog(@"Load Popular Media Failed");
    }];
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


#pragma mark - Setting of Table Header
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return self.media.user.username;
//    //return mediaArray.count;
//}

///Height of header
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
//    return 0;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return mediaArray.count;
}

///Setting order of media
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //mediaOrder = section;
    self.media = mediaArray[section];
    
    UserHeaderTableViewCell *header = [tableView dequeueReusableCellWithIdentifier:@"InstaUserSectionHeader"];
    
    [header setAlpha:1.0f];
    [header.userProfileBtn setClipsToBounds:YES];
    [header.userProfileBtn.layer setCornerRadius:header.userProfileBtn.bounds.size.width / 2.0];
    [header.userProfileBtn setImageForState:UIControlStateNormal withURL:self.media.user.profilePictureURL];
    [header.userName setText:self.media.user.username];
    [header.createdDate setText:[self returnCreatedDate:self.media.createdDate]];
    [header.followBtn addTarget:self action:@selector(followUser) forControlEvents:UIControlEventTouchUpInside];
    
    return header;
}


#pragma mark - Setting of Table Cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.media = mediaArray[indexPath.section];
    
    BeautiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"instaCell" forIndexPath:indexPath];
    if (mediaArray.count >= indexPath.section + 1) {    //indexPath.row + 1
        NSLog(@"index:%ld", (long)indexPath.section );
        [cell.instaImageView setImage:[UIImage imageNamed:@"instaLoading.png"]];
        [cell.instaImageView setImageWithURL:self.media.standardResolutionImageURL];
        [cell.likeBtn setTitle:[NSString stringWithFormat:@" %ld", (long)self.media.likesCount] forState:UIControlStateNormal];
        [self userCaption:cell withCaption:self.media.caption.text];
        [self userComment:cell];
//        NSLog(@"comment:%@", cell.comment);
        NSLog(@"rowHeight:%f", self.tableView.rowHeight);
    } else {
        [cell.instaImageView setImage:nil];
        NSLog(@"Sorry. Image is nil");
    }
    return cell;
}

///Settging Caption in Instagram
- (void)userCaption:(BeautiTableViewCell *)cell withCaption:(NSString *)caption{
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
//    [cell.caption sizeToFit];
//    [cell.caption setNumberOfLines:0];
}


///Setting Comment in Instagram
- (void)userComment:(BeautiTableViewCell *)cell {
    NSError *error = nil;
    NSRegularExpression *hashRegex = [NSRegularExpression regularExpressionWithPattern:@"#\\S+" options:NSRegularExpressionCaseInsensitive error:&error];
    NSRegularExpression *mentRegex = [NSRegularExpression regularExpressionWithPattern:@"@\\S+" options:NSRegularExpressionCaseInsensitive error:&error];
    NSAssert(error == nil, @"Regular expression was not valid");
    
    [[InstagramEngine sharedEngine] getCommentsOnMedia:self.media.Id withSuccess:^(NSArray *comments) {
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
//        [cell.comment sizeToFit];
//        [cell.comment setNumberOfLines:0];
        
    } failure:^(NSError *error) {
        NSLog(@"Could not load comments");
    }];
}

#pragma mark - Rounding Button
- (UIButton *)makingRoundButtonWithImage:(UIImage *)buttonImage buttonForX:(NSInteger)buttonX buttonForY:(NSInteger)buttonY buttonForSize:(NSInteger)buttonSize {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(profileButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    
    //width and height should be same value
    [button setFrame:CGRectMake(buttonX, buttonY, buttonSize, buttonSize)];
    
    //Clip/Clear the other pieces whichever outside the rounded corner
    [button setClipsToBounds:YES];
    
    //half of the width
    [button.layer setCornerRadius:buttonSize/2.0f];
    [button.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [button.layer setBorderWidth:2.0f];
    
    return button;
}


#pragma makr - Action of Button
///Follow the user
//- (void)followUser:(UIButton *)sender {
//    NSLog(@"followFunc is ON");
//    [[InstagramEngine sharedEngine]followUser:userId withSuccess:^(NSDictionary *response) {
//        NSLog(@"Follow success");
//    }failure:^(NSError *error){
//        NSLog(@"Failed to follow");
//    }];
//    
//}

- (void)followUser {
    if (!login) {
        [self performSegueWithIdentifier:@"instaLoginSegue" sender:nil];
    }
    NSLog(@"UserName:%@", self.media.user.Id);
    [[InstagramEngine sharedEngine]followUser:self.media.user.Id withSuccess:^(NSDictionary *response) {
        NSLog(@"Follow success");
    }failure:^(NSError *error){
        NSLog(@"Failed to follow");
    }];
}

- (void)likeMedia {
    [[InstagramEngine sharedEngine]likeMedia:self.media.Id withSuccess:^{
        NSLog(@"Like sueecess");
    }failure:^(NSError *error){
        NSLog(@"Like is fail");
    }];
}

- (void)profileButtonDidTap:(UIButton*)tappedButton {
    NSLog(@"roundButtonDidTap Method Called");
}

- (IBAction)back:(id)sender {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self performSegueWithIdentifier:@"backMenuFromBeauti" sender:self];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
