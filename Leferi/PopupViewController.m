//
//  PopupViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 9. 19..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "PopupViewController.h"

@interface PopupViewController ()

@end

@implementation PopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillAppear:(BOOL)animated {
    [UIView animateWithDuration:1.0
                          delay:0.34
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.homeBtn setAlpha:1.0f];
                         [self.introduceBtn setAlpha:1.0f];
                         [self.historyBtn setAlpha:1.0f];
                     } completion:^(BOOL finished) {
                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)back:(id)sender {
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (IBAction)exitToPopup:(UIStoryboardSegue *)sender {
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
}

- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier {
    DissolveUnsegue *segue = [[DissolveUnsegue alloc] initWithIdentifier:identifier source:fromViewController destination:toViewController];
    return segue;
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
