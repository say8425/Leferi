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
    //Navigaxtion Setting
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

#pragma makr - Setting of Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return mediaArray.count;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return self.media.user.username;
//    //return mediaArray.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return mediaArray.count;
//    NSString *sectionTitle = [instaSectionTitle objectAtIndex:section];
//    NSArray *sectionInstas = [instaDictionary objectForKey:sectionTitle];
//    return [sectionInstas count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    self.media = mediaArray[section];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 300)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *userImageView; [userImageView setImageWithURL:self.media.user.profilePictureURL];   //image for profile photo
    UIButton *userProfile = [self makingRoundButtonWithImage:userImageView.image buttonForX:4 buttonForY:4 buttonForSize:48];
    UILabel *userName = [[UILabel alloc]initWithFrame:CGRectMake(64, 4, 142, 32)];
    UILabel *createDate = [[UILabel alloc]initWithFrame:CGRectMake(64, 24, 142, 32)];
    UIButton *followButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [followButton setFrame:CGRectMake(200, 14, 40, 10)];
    [followButton setImage:[UIImage imageNamed:@"instaFollBtn.png"] forState:UIControlStateNormal];
    [followButton addTarget:self action:@selector(followUser) forControlEvents:UIControlEventTouchUpInside];
    
    [userName setFont:[UIFont systemFontOfSize:24]];
    [userName setText:self.media.user.username];
    [createDate setFont:[UIFont systemFontOfSize:12]];
    [createDate setText:[self returnCreatedDate:self.media.createdDate]];
    
    [view addSubview:userProfile];
    [view addSubview:userName];
    [view addSubview:createDate];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BeautiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"instaCell" forIndexPath:indexPath];
    if (mediaArray.count >= indexPath.row + 1) {
        self.media = mediaArray[indexPath.row];
        [cell.imageView setImageWithURL:self.media.standardResolutionImageURL];
        [cell.likeCount setText:[NSString stringWithFormat:@"%ld", (long)self.media.likesCount]];
        [cell.caption setText:self.media.caption.text];
        [cell.caption setNumberOfLines:0];
        [cell.caption setTextAlignment:NSTextAlignmentCenter];
        [cell.caption setLineBreakMode:NSLineBreakByWordWrapping];
        //[cell.captionLb sizeToFit];
        NSLog(@"Image is loaded");
    } else {
        [cell.imageView setImage:nil];
        NSLog(@"Sorry. Image is nil");
    }
    return cell;
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
