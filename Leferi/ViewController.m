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
    EAIntroPageNP *page1 = [EAIntroPageNP page];
    EAIntroPageNP *page2 = [EAIntroPageNP page];
    EAIntroPageNP *page3 = [EAIntroPageNP page];
    EAIntroPageNP *page4 = [EAIntroPageNP page];


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
        NSLog(@"tall");
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
        NSLog(@"short");

    }

    [self.proposeBtn setImage:[UIImage imageNamed:@"pageSkipBtn.png"] forState:UIControlStateNormal];
    
    EAIntroViewNP *introView = [[EAIntroViewNP alloc]initWithFrame:self.introView.bounds
                                                      andPages:@[page1, page2, page3, page4]];

    [introView setSkipButton:self.proposeBtn];
    [introView.skipButton setEnabled:NO];
    [introView.skipButton setAlpha:0.0f];
//    [introView.skipButton setFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.width - self.proposeBtn.frame.size.width)/2,
//                                              ([[UIScreen mainScreen]bounds].size.height - self.proposeBtn.frame.size.height)/2,
//                                              self.proposeBtn.frame.size.width, self.proposeBtn.frame.size.height)];
    [introView setShowSkipButtonOnlyOnLastPage:YES];
    [introView hidePageControl];
    [introView setDelegate:self];
    [introView showInView:self.introView animateDuration:0.3];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)proposeBtn:(id)sender {

}

@end
