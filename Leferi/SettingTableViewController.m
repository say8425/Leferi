//
//  SettingTableViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 9. 24..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "SettingTableViewController.h"

@interface SettingTableViewController ()

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  //  [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    // NaviBar Setting
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"settingTitleBar.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem customBackButtonWithImage:[UIImage imageNamed:@"backButton.png"] Target:self action:@selector(back:)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (IBAction)back:(id)sender {
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
