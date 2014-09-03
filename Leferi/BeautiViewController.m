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
    //Navigation Setting
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"proposeTitle.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem customBackButtonWithImage:[UIImage imageNamed:@"backButton.png"] Target:self action:@selector(back:)]];
    
    //Head Image Setting
    [self.headImageView setImage:[UIImage imageNamed:@"headImage@2x.png"]];
    
    
    //Title Bar Hding
    [self.shyNavBarManager setScrollView:self.tableView];
}

#pragma mark - InstaGram Setting
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

///Follow the user.

#pragma makr - Setting of Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return mediaArray.count;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    //return [instaSectionTitle objectAtIndex:section];
//    return mediaArray.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return mediaArray.count;
//    NSString *sectionTitle = [instaSectionTitle objectAtIndex:section];
//    NSArray *sectionInstas = [instaDictionary objectForKey:sectionTitle];
//    return [sectionInstas count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    InstagramMedia *media = mediaArray[section];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 32)];
    
    UIImageView *userImageView; [userImageView setImageWithURL:media.standardResolutionImageURL];   //image for profile photo
    UIButton *userProfile = [self makingRoundButtonWithImage:userImageView.image buttonForX:4 buttonForY:4 buttonForSize:24];
    UILabel *userName = [[UILabel alloc]initWithFrame:CGRectMake(30, 4, 60, 8)];
    UILabel *createDate = [[UILabel alloc]initWithFrame:CGRectMake(30, 64, 60, 68)];
    UIButton *followButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [followButton setImage:[UIImage imageNamed:@"instaFollBtn.png"] forState:UIControlStateNormal];
    [followButton addTarget:self action:[self performSelector:@selector(followUser:withSuccess:failure:) withObject:media.user.username] forControlEvents:UIControlEventTouchUpInside];

    
    [userName setFont:[UIFont systemFontOfSize:12]];
    [userName setText:media.user.username];
    [createDate setFont:[UIFont systemFontOfSize:6]];
    [createDate setText:[self returnCreatedDate:media.createdDate]];
    
    [view addSubview:userProfile];
    [view addSubview:userName];
    [view addSubview:createDate];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BeautiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"instaCell" forIndexPath:indexPath];
    if (mediaArray.count >= indexPath.row + 1) {
        InstagramMedia *media = mediaArray[indexPath.row];
        [cell.imageView setImageWithURL:media.standardResolutionImageURL];
        
        
        [cell.userIconBtn setImageForState:UIControlStateNormal withURL:media.user.profilePictureURL];
        [cell.userNameLb setText:media.user.username];
        [cell.userDateLb setText:[self returnCreatedDate:media.createdDate]];
        [cell.likeNumLb setText:[NSString stringWithFormat:@"%ld", (long)media.likesCount]];
        [cell.commentNumLb setText:[NSString stringWithFormat:@"%ld", (long)media.commentCount]];
        [cell.captionLb setText:media.caption.text];
        //[cell.captionLb setNumberOfLines:0];
        [cell.captionLb setTextAlignment:NSTextAlignmentCenter];
        [cell.captionLb setLineBreakMode:NSLineBreakByWordWrapping];
        //[cell.captionLb sizeToFit];
        NSLog(@"Image is loaded");
    } else {
        [cell.photoImageView setImage:nil];
        NSLog(@"Sorry. Image is nil");
    }
    return cell;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BeautiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"instaCell" forIndexPath:indexPath];
    

    NSString *sectionTitle = [instaSectionTitle objectAtIndex:indexPath.section];
    NSArray *sectionInstas = [instaDictionary objectForKey:sectionTitle];
    NSString *insta = [sectionInstas objectAtIndex:indexPath.row];
    
    
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
