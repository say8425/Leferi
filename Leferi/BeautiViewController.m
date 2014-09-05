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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"proposeTitle.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem customBackButtonWithImage:[UIImage imageNamed:@"backButton.png"] Target:self action:@selector(back:)]];
    
    //Head Image Setting
    [self.headImageView setImage:[UIImage imageNamed:@"headImage@2x.png"]];
    
    //Title Bar Hding
    [self.shyNavBarManager setScrollView:self.tableView];
    
    //Instagram Load
    [self loadMedia];
}

#pragma mark - InstaGram Setting Func

///Basic parameter and Method init
- (void)loadMedia {
    tagString = [NSString new];
    mediaArray = [NSMutableArray new];
    InstagramEngine *sharedEngine = [InstagramEngine sharedEngine];
    
    if (sharedEngine.accessToken) {
        [self getMediaFromTag:tagString];
        NSLog(@"Success");
    } else {
        [self loadPopularMedia];
        NSLog(@"Token getting is FAIL");
    }
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

///Follow the user
- (void)followUser {
    [[InstagramEngine sharedEngine]followUser:self.media.user.Id withSuccess:^(NSDictionary *response) {
        NSLog(@"Follow success");
    }failure:^(NSError *error){
        NSLog(@"Failed to follow");
    }];
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
        [cell.caption setNumberOfLines:0];
        [cell.caption setTextAlignment:NSTextAlignmentCenter];
        [cell.caption setLineBreakMode:NSLineBreakByWordWrapping];
        //[cell.caption sizeToFit];
        NSLog(@"mediaArray : %lu, mediaOrder : %ld", (unsigned long)mediaArray.count, (long)mediaOrder);
    } else {
        [cell.instaImageView setImage:nil];
        NSLog(@"Sorry. Image is nil");
    } return cell;
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
- (void)profileButtonDidTap:(UIButton*)tappedButton {
    NSLog(@"roundButtonDidTap Method Called");
}

- (IBAction)back:(id)sender {
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
