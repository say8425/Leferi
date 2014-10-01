//
//  ViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 7. 9..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
    
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //statusBar make LightStyle
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];

    //UIDevice read;
    RTScreenPhysicalSize *rtScreenPhysicalSize = [RTScreenPhysicalSize new];

    //EAIntro Setting
    EAIntroPage *page1 = [EAIntroPage page];
    EAIntroPage *page2 = [EAIntroPage page];
    EAIntroPage *page3 = [EAIntroPage page];
    EAIntroPage *page4 = [EAIntroPage page];


    if ([rtScreenPhysicalSize screenPhysicalSize] == SCREEN_SIZE_IPHONE_TALL) {
        page1.bgImage = [UIImage imageNamed:@"page1.png"];
        page1.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pageText1.png"]];
        page1.titleIconPositionY = 0;

        page2.bgImage = [UIImage imageNamed:@"page2.png"];
        page2.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pageText2.png"]];
        page2.titleIconPositionY = 0;

        page3.bgImage = [UIImage imageNamed:@"page3.png"];
        page3.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pageText3.png"]];
        page3.titleIconPositionY = 0;

        page4.bgImage = [UIImage imageNamed:@"page4.png"];
        page4.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pageText4.png"]];
        page4.titleIconPositionY = 0;
    } else {
        //iPhone 4S Screen
        page1.bgImage = [UIImage imageNamed:@"page1.png"];
        page1.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pageText1_960.png"]];
        page1.titleIconPositionY = 0;

        page2.bgImage = [UIImage imageNamed:@"page2.png"];
        page2.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pageText2.png"]];
        page2.titleIconPositionY = 0;

        page3.bgImage = [UIImage imageNamed:@"page3.png"];
        page3.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pageText3.png"]];
        page3.titleIconPositionY = 0;

        page4.bgImage = [UIImage imageNamed:@"page4.png"];
        page4.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pageText4.png"]];
        page4.titleIconPositionY = 0;
    }

//    [self.proposeBtn setImage:[UIImage imageNamed:@"pageSkipBtn.png"] forState:UIControlStateNormal];
//    
    EAIntroView *introView = [[EAIntroView alloc]initWithFrame:self.view.bounds
                                                      andPages:@[page1, page2, page3, page4]];

    UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [skipBtn setAlpha:0.0f];
    [skipBtn setEnabled:NO];
    [skipBtn setBackgroundImage:[UIImage imageNamed:@"pageSkipBtn.png"] forState:UIControlStateNormal];
    [skipBtn setFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width/2 - 62,
                                 [[UIScreen mainScreen]bounds].size.height/2 - 86,
                                 124, 124)];
    [skipBtn addTarget:self action:@selector(proposeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [introView setSkipButton:skipBtn];
    [introView setSwipeToExit:NO];
//    introView.skipButton = skipBtn;

//    introView.skipButton = self.proposeBtn;
//    [introView setSkipButton:self.proposeBtn];
//    [introView.skipButton setEnabled:NO];
//    [introView.skipButton setAlpha:0.0f];
//    [introView.skipButton setFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.width - self.proposeBtn.frame.size.width)/2,
//                                              ([[UIScreen mainScreen]bounds].size.height - self.proposeBtn.frame.size.height)/2,
//                                              self.proposeBtn.frame.size.width, self.proposeBtn.frame.size.height)];
//    [introView setShowSkipButtonOnlyOnLastPage:YES];
    //[introView hidePageControl];
    //[introView setDelegate:self];
    [introView showInView:self.view animateDuration:0.3];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)proposeBtn:(id)sender {
    [self performSegueWithIdentifier:@"enterMenu" sender:sender];
}
@end
