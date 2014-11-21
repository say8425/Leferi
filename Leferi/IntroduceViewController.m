//
//  IntroduceViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 9. 19..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "IntroduceViewController.h"

@interface IntroduceViewController ()

@end

@implementation IntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //GoogleAnal Screen
    [self setScreenName:@"IntroduceView"];
    
    //statusBar make LightStyle
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    NSDictionary *pathPlist = [NSDictionary dictionaryWithContentsOfFile:[ETCLibrary getPath]];
    
    //EAIntro Setting
    self.introduce1 = [EAIntroPage page];
    self.introduce2 = [EAIntroPage page];
    self.introduce3 = [EAIntroPage page];
    self.introduce4 = [EAIntroPage page];
    self.introduce5 = [EAIntroPage page];
    self.introduce6 = [EAIntroPage page];
    
    NSString *pageName;
    NSString *pageTextName;
    
    for (int i = 1; i <= 6; i++) {
        pageName = [NSString stringWithFormat:@"introduce%d", i];
        pageTextName = [NSString stringWithFormat:@"introduceText%d", i];
        
        EAIntroPage *page = (EAIntroPage *)[self valueForKey:pageName];
        
        if (page) {
            page.bgImage = [UIImage imageWithContentsOfFile:[pathPlist objectForKey:pageName]];
            page.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:[pathPlist objectForKey:pageTextName]]];
            page.titleIconPositionY = 0;
        }
    }

    //Setting Button of text's attributted
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:@"소개 그만보기"];
    [attributeString addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:1]
                            range:(NSRange) {0, [attributeString length]}];

    //Setting Button of text
    UILabel *titleSkipBtn = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 20)];
    [titleSkipBtn setFont:[UIFont systemFontOfSize:14]];
    [titleSkipBtn setTextColor:[UIColor whiteColor]];
    [titleSkipBtn setAttributedText:[attributeString copy]];
    
    //Setting Button
    UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [skipBtn addSubview:titleSkipBtn];
    [skipBtn setAlpha:0.0f];
    [skipBtn setFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width - 90, 10, 90, 20)];
    [skipBtn addTarget:self action:@selector(skipBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //Setting IntroView
    EAIntroView *introView = [[EAIntroView alloc]initWithFrame:self.introduceView.bounds
                                                      andPages:@[self.introduce1, self.introduce2, self.introduce3, self.introduce4, self.introduce5, self.introduce6]];
    [introView setPageControl:nil];
    [introView setSkipButton:skipBtn];
    [introView setSwipeToExit:NO];
    [introView setShowSkipButtonOnlyOnLastPage:NO];
    [introView showInView:self.introduceView animateDuration:0.3];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)skipBtn:(id)sender {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [self performSegueWithIdentifier:@"backPopFromIntro" sender:self];
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
