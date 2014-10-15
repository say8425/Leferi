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
    self.page1 = [EAIntroPage page];
    self.page2 = [EAIntroPage page];
    self.page3 = [EAIntroPage page];
    self.page4 = [EAIntroPage page];
    
    NSString *pageName;
    NSString *pageTextName;
    
    for (int i = 1; i <= 4; i++) {
        pageName  = [NSString stringWithFormat:@"page%d", i];
        pageTextName = [NSString stringWithFormat:@"pageText%d", i];
        
        EAIntroPage *page = (EAIntroPage *)[self valueForKey:pageName];
        
        if (page) {
            page.bgImage = [UIImage imageNamed:[self.pathDictionary objectForKey:pageName]];
            page.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[self.pathDictionary objectForKey:pageTextName]]];
            page.titleIconPositionY = 0;
        }
    }
    
    EAIntroView *introView = [[EAIntroView alloc]initWithFrame:self.view.bounds andPages:@[self.page1, self.page2, self.page3, self.page4]];
    
    UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [skipBtn setAlpha:0.0f];
    [skipBtn setEnabled:NO];
    [skipBtn setBackgroundImage:[UIImage imageNamed:[self.pathDictionary objectForKey:@"pageSkipBtn"]] forState:UIControlStateNormal];
    [skipBtn setFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width/2 - 62,
                                 [[UIScreen mainScreen]bounds].size.height/2 - 86, 124, 124)];
    [skipBtn addTarget:self action:@selector(proposeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [introView setSkipButton:skipBtn];
    [introView setSwipeToExit:NO];
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
