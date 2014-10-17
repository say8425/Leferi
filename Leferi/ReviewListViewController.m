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

    //StatusBar Setting
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    //NaviBar Setting
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"reviewTitleBar.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem customBackButtonWithImage:[UIImage imageNamed:@"backButton.png"] Target:self action:@selector(back:)]];
    
    //Cache Loading
    NSDictionary *pathPlist = [NSDictionary dictionaryWithContentsOfFile:[ETCLibrary getPath]];
    NSDictionary *urlDict = [NSDictionary dictionaryWithContentsOfFile:[pathPlist objectForKey:@"config"]];
    
    //TableCell Setting
    self.reviewImageArray = @[[pathPlist objectForKey:@"blogMenu1"],
                              [pathPlist objectForKey:@"blogMenu2"],
                              [pathPlist objectForKey:@"blogMenu3"],
                              [pathPlist objectForKey:@"blogMenu4"]];
    
    self.reviewAddressArray = @[[urlDict objectForKey:@"blogURL1"],
                                [urlDict objectForKey:@"blogURL2"],
                                [urlDict objectForKey:@"blogURL3"],
                                [urlDict objectForKey:@"blogURL4"]];
    
    //NavigationBar Fade out
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    } [self.navigationController.navigationBar setTranslucent:NO];
    [self followScrollView:self.tableView];
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

#pragma mark - NavigationBar Fade out - sub Function
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showNavBarAnimated:NO];
    //[self stopFollowingScrollView];
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
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    // This enables the user to scroll down the navbar by tapping the status bar.
    [self showNavbar];
    
    return YES;
}

@end
