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
    
    //GoogleAnal Screen
    [self setScreenName:@"MenuView"];
    
    //Cache Loading
    NSDictionary *pathPlist = [NSDictionary dictionaryWithContentsOfFile:[ETCLibrary getPath]];
    NSDictionary *configDict = [NSDictionary dictionaryWithContentsOfFile:[pathPlist objectForKey:@"config"]];

    // StatusBar Setting
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:[ETCLibrary getStatusBarFontColor]];
    
    // StatusBar FrameBar Setting
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 22)];
    statusBarView.backgroundColor  =  [UIColor colorWithHexString:[configDict objectForKey:@"statusBarHEX"]];
    NSLog(@"color:%@", [configDict objectForKey:@"statusBarHEX"]);
    [self.view addSubview:statusBarView];
    
    // MenuBtn Setting
    [self.titleImageView setImage:[UIImage imageWithContentsOfFile:[pathPlist objectForKey:@"letter1"]]];
    [self.letterImageView setImage:[UIImage imageWithContentsOfFile:[pathPlist objectForKey:@"letter2"]]];
    [self.menuBtn1 setImage:[UIImage imageWithContentsOfFile:[pathPlist objectForKey:@"story1"]] forState:UIControlStateNormal];
    [self.menuBtn2 setImage:[UIImage imageWithContentsOfFile:[pathPlist objectForKey:@"story2"]] forState:UIControlStateNormal];
    [self.menuBtn3 setImage:[UIImage imageWithContentsOfFile:[pathPlist objectForKey:@"story3"]] forState:UIControlStateNormal];
    [self.menuBtn4 setImage:[UIImage imageWithContentsOfFile:[pathPlist objectForKey:@"story4"]] forState:UIControlStateNormal];
    
    instaTag = [configDict objectForKeyedSubscript:@"beautiTag"];
    instaWeb = [configDict objectForKeyedSubscript:@"beautiWeb"];
}

- (IBAction)exitToMainMenu:(UIStoryboardSegue *)sender {
    [[UIApplication sharedApplication] setStatusBarStyle:[ETCLibrary getStatusBarFontColor]];
}

- (IBAction)InstagramOpen:(id)sender {
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-56520642-1"];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"touch" action:@"instaTouch" label:nil value:nil]build]];
    
    NSString *instaTagString = [NSString stringWithFormat:@"instagram://tag?name=%@", instaTag];
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:instaTagString]]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:instaTagString]];
    } else {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://instagram.com/%@", instaWeb]]];
    }
    
}

- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier {
    // Instantiate a new CustomUnwindSegue
    DissolveUnsegue *segue = [[DissolveUnsegue alloc] initWithIdentifier:identifier source:fromViewController destination:toViewController];
    // Set the target point for the animation to the center of the button in this VC
    //    segue.targetPoint = self.segueButton.center;
    return segue;
}

@end
 