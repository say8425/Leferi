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
    
    //GoogleAnal Screen
    [self setScreenName:@"IntroView"];
    
    //StatusBar Setting
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    NSDictionary *pathPlist = [NSDictionary dictionaryWithContentsOfFile:[ETCLibrary getPath]];
    
    //EAIntro Setting
    self.page1 = [EAIntroPage page];
    self.page2 = [EAIntroPage page];
    self.page3 = [EAIntroPage page];
    self.page4 = [EAIntroPage page];
    
    NSString *pageName;
    NSString *pageTextName;
    
    for (int i = 1; i <= 4; i++) {
        pageName = [NSString stringWithFormat:@"page%d", i];
        pageTextName = [NSString stringWithFormat:@"pageText%d", i];
        
        EAIntroPage *page = (EAIntroPage *)[self valueForKey:pageName];
        
        if (page) {
            page.bgImage = [UIImage imageNamed:[pathPlist objectForKey:pageName]];
            page.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[pathPlist objectForKey:pageTextName]]];
            page.titleIconPositionY = 0;
        }
    }
    
    //Making SkipButton
    UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [skipBtn setBackgroundImage:[UIImage imageNamed:[pathPlist objectForKey:@"pageSkipBtn"]] forState:UIControlStateNormal];
    [skipBtn setFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width/2 - 62,
                                 [[UIScreen mainScreen]bounds].size.height/2 - 86, 124, 124)];
    [skipBtn addTarget:self action:@selector(proposeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //Making IntroView
    EAIntroView *introView = [[EAIntroView alloc]initWithFrame:self.view.bounds andPages:@[self.page1, self.page2, self.page3, self.page4]];
    [introView setPenguinSkip:YES];
    [introView setSkipButton:skipBtn];
    [introView setSwipeToExit:NO];
    [introView setShowSkipButtonOnlyOnLastPage:YES];
    [introView setPageControl:nil];
    
    //Animation Effect Dummy
    UIView *dummyView = [[UIView alloc]init];
    dummyView.backgroundColor = [UIColor whiteColor];
    dummyView.alpha = 1.0;
    [self.view addSubview:dummyView];
    
    [UIView animateWithDuration:1 animations:^{
        dummyView.alpha = 0.0;
    }completion:^(BOOL finished) {
        [dummyView removeFromSuperview];
        [introView showInView:self.view animateDuration:1.42];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)proposeBtn:(id)sender {
    [self performSegueWithIdentifier:@"enterMenu" sender:sender];
}
@end
