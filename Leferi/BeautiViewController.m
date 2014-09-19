//
//  BeautiViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 27..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "BeautiViewController.h"

@interface BeautiViewController ()

- (UIButton *)makingRoundButtonWithImage:(UIImage *)buttonImage buttonForX:(NSInteger)buttonX buttonForY:(NSInteger)buttonY buttonForSize:(NSInteger)buttonSize;

@end

@implementation BeautiViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.sectionHeaderHeight = 64;
    
    //Navigation Setting
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"instaTitleBar.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem customBackButtonWithImage:[UIImage imageNamed:@"backButton.png"] Target:self action:@selector(back:)]];
    
    //TitleImage Setting
    [self.headImageView setImage:[UIImage imageNamed:@"headImage@2x.png"]];
    
    //NavigationBar Fade out
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    } [self.navigationController.navigationBar setTranslucent:NO];
    [self followScrollView:self.tableView withDelay:65];
    
    //Instagram Load
    [self loadMedia];
}

#pragma mark - InstaGram Setting Func
///Basic parameter and Method init
- (void)loadMedia {
    tagString = @"Chanelbeauty";
    mediaArray = [NSMutableArray new];
    InstagramEngine *sharedEngine = [InstagramEngine sharedEngine];
    
    if (sharedEngine.accessToken) {
        [self getMediaFromTag:tagString];
        login = YES;
        NSLog(@"Success");
    } else {
//        [self loadPopularMedia];
        [self getMediaFromTag:tagString];
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
    [[InstagramEngine sharedEngine] getMediaWithTagName:tag count:15 maxId:self.currentPaginationInfo.nextMaxId withSuccess:^(NSArray *media, InstagramPaginationInfo *paginationInfo) {
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
    [dateFormat setDateFormat:@"yyyy. MM. dd h:mm a"];
    newStringDate = [dateFormat stringFromDate:[NSDate new]];
    
    return newStringDate;
}


#pragma mark - Setting of Table Header
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return self.media.user.username;
//    //return mediaArray.count;
//}

///Height of header
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return mediaArray.count;
}

///Setting order of media
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    mediaOrder = section;
    self.media = mediaArray[section];
    
    UserHeaderTableViewCell *header = [tableView dequeueReusableCellWithIdentifier:@"InstaUserSectionHeader"];
    
    //[header.userProfileBtn setFrame:CGRectMake(8, 8, 48, 48)];
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
    //return mediaArray.count;
//    NSString *sectionTitle = [instaSectionTitle objectAtIndex:section];
//    NSArray *sectionInstas = [instaDictionary objectForKey:sectionTitle];
//    return [sectionInstas count];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BeautiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"instaCell" forIndexPath:indexPath];
    if (mediaArray.count >= mediaOrder + 1) {    //indexPath.row + 1
        self.media = mediaArray[mediaOrder];    //indexPath.row

        
        
        
        [cell.instaImageView setImageWithURL:self.media.standardResolutionImageURL];
        [cell.likeCount setText:[NSString stringWithFormat:@"%ld", (long)self.media.likesCount]];
        [cell.caption setText:self.media.caption.text];
//        [self userComment];
    } else {
        [cell.instaImageView setImage:nil];
        NSLog(@"Sorry. Image is nil");
    } return cell;
}

//- (NSString *)userComment {
//    NSString *tempComment;
//    NSString *resultComment;
//    NSError *error;
//    
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"#/S+" options:NSRegularExpressionCaseInsensitive error:&error];
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:tempComment];
//    [regex enumerateMatchesInString:tempComment
//                            options:0
//                              range:NSMakeRange(0, [tempComment length])
//                         usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
//        NSString *hashTag = [tempComment substringWithRange:result.range];
//        NSString *linkgContent = [NSString stringWithFormat:@"app-custom]
//                         }];
//    
//    [[InstagramEngine sharedEngine] getCommentsOnMedia:self.media.Id withSuccess:^(NSArray *comments) {
//        for (InstagramComment *comment in comments) {
//            //[tempcomment stringByAppendingString:comment.user.username];
//            
//            NSLog(@"@%@: %@",comment.user.username, comment.text);
//        }
//    } failure:^(NSError *error) {
//        NSLog(@"Could not load comments");
//    }];
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
////    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"instaCell" forIndexPath:indexPath];
////    if (!self.mediaCell) {
////        
////        self.mediaCell = [self.tableView dequeueReusableCellWithIdentifier:@"instaCell" forIndexPath:indexPath];
////        NSLog(@";lj");
////    }
////    BeautiTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"instaCell" forIndexPath:indexPath];
////    NSLog(@"asdf");
////    if (mediaArray.count >= indexPath.row + 1) {    //indexPath.row + 1
////        self.media = mediaArray[indexPath.row];    //indexPath.row         //Temp_deleted it.
////        [self.cell.instaImageView setImageWithURL:self.media.standardResolutionImageURL];
////        [self.cell.likeCount setText:[NSString stringWithFormat:@"%ld", (long)self.media.likesCount]];
////        [self.cell.caption setText:self.media.caption.text];
////        NSLog(@"mediaArray : %lu, mediaOrder : %ld", (unsigned long)mediaArray.count, (long)mediaOrder);
////    } else {
////        [self.cell.instaImageView setImage:nil];
////        NSLog(@"Sorry. Image is nil");
////    }
//
////    
////    [self.mediaCell layoutIfNeeded];                 //FIT, but can not load with mediaOrder safely.
////    CGFloat newHeight = [self.mediaCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
////    CGFloat newHeight = 250;
//    BeautiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"instaCell"];
//    [cell setNeedsLayout];
//    [cell layoutIfNeeded];
//    CGFloat newHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//    return newHeight;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 750;
//}


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
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
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
