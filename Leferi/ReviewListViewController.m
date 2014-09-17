//
//  ReviewViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 26..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "ReviewListViewController.h"

@interface ReviewListViewController ()

@end

@implementation ReviewListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // StatusBar setting
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    // NaviBar Setting
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleBar.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem customBackButtonWithImage:[UIImage imageNamed:@"backButton.png"] Target:self action:@selector(back:)]];
    
    //TableCell Setting
    self.reviewImageArray = @[@"blogMenu1.png",
                              @"blogMenu2.png",
                              @"blogMenu3.png",
                              @"blogMenu4.png"];
    
    self.reviewAddressArray = @[@"http://seohalim21.blog.me/140195077056",
                                @"http://serviceapi.nmv.naver.com/flash/convertIframeTag.nhn?vid=46F001D0BEA2B7DAC8571D40F0807E2F6632&outKey=V1277a0bba0d0ef67329d9c7c5f97885bfb1d930164907b0feda19c7c5f97885bfb1d&width=720&height=438",
                                @"http://www.cyworld.com/gheyseo/8152782",
                                @"http://blog.naver.com/godbwithuu/220079143390"];
    
    //NavigationBar Fade out
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    } [self.navigationController.navigationBar setTranslucent:NO];
    [self followScrollView:self.tableView withDelay:65];
}


#pragma mark - Table View Setting
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reviewImageArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReviewViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reviewCell" forIndexPath:indexPath];
    
    long row = [indexPath row];
    [cell.reviewCellBtn setImage:[UIImage imageNamed:self.reviewImageArray[row]] forState:UIControlStateNormal];
    return cell;
}

#pragma mark - Segue Setting
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier]isEqualToString:@"showReview"]) {
        ReviewViewController *reviewViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        long row = [indexPath row];
        //reviewViewController.urlString = self.reviewAddressArray[row];
        reviewViewController.reviewURL = [NSURL URLWithString:self.reviewAddressArray[row]];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
