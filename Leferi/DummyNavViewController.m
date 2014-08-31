//
//  DummyNavViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 5..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "DummyNavViewController.h"

@interface DummyNavViewController ()

@end

@implementation DummyNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"naviBarShadow.png"]];
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
