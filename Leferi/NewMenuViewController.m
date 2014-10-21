//
//  NewMenuViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 9. 15..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "NewMenuViewController.h"

@implementation NewMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // StatusBar Setting
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // StatusBar FrameBar Setting
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 22)];
    statusBarView.backgroundColor  =  [UIColor blackColor];
    [self.view addSubview:statusBarView];
    
    //Cache Loading
    NSDictionary *pathPlist = [NSDictionary dictionaryWithContentsOfFile:[ETCLibrary getPath]];
    
    // MenuBtn Setting
    [self.titleImageView setImage:[UIImage imageNamed:[pathPlist objectForKey:@"letter1"]]];
    [self.letterImageView setImage:[UIImage imageNamed:[pathPlist objectForKey:@"letter2"]]];
    [self.menuBtn1 setImage:[UIImage imageNamed:[pathPlist objectForKey:@"story1"]] forState:UIControlStateNormal];
    [self.menuBtn2 setImage:[UIImage imageNamed:[pathPlist objectForKey:@"story2"]] forState:UIControlStateNormal];
    [self.menuBtn3 setImage:[UIImage imageNamed:[pathPlist objectForKey:@"story3"]] forState:UIControlStateNormal];
    [self.menuBtn4 setImage:[UIImage imageNamed:[pathPlist objectForKey:@"story4"]] forState:UIControlStateNormal];
    
}


- (IBAction)btn2YouTube:(id)sender {
    NSString *Lancome = @"vFgD5-X7_zQ";
    //NSString *PSY = @"9bZkp7q19f0";
    
    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:Lancome];
    [videoPlayerViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
}

- (IBAction)exitToMainMenu:(UIStoryboardSegue *)sender {

}



- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier {
    // Instantiate a new CustomUnwindSegue
    DissolveUnsegue *segue = [[DissolveUnsegue alloc] initWithIdentifier:identifier source:fromViewController destination:toViewController];
    // Set the target point for the animation to the center of the button in this VC
    //    segue.targetPoint = self.segueButton.center;
    return segue;
}

@end
 