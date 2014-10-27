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
    
    //statusBar make LightStyle
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];

    EAIntroPage *page1 = [EAIntroPage page];
    EAIntroPage *page2 = [EAIntroPage page];
    EAIntroPage *page3 = [EAIntroPage page];
    EAIntroPage *page4 = [EAIntroPage page];
    EAIntroPage *page5 = [EAIntroPage page];
    EAIntroPage *page6 = [EAIntroPage page];
    

    if ([[ETCLibrary getScreenPhysicalSize] isEqual:@"Classic/"]) {
        page1.bgImage = [UIImage imageNamed:@"introduceBack1.png"];
        page1.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText1.png"]];
        page1.titleIconPositionY = 0;
        
        page2.bgImage = [UIImage imageNamed:@"introduceBack2.png"];
        page2.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText2.png"]];
        page2.titleIconPositionY = 0;
        
        page3.bgImage = [UIImage imageNamed:@"introduceBack3.png"];
        page3.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText3.png"]];
        page3.titleIconPositionY = 0;
        
        page4.bgImage = [UIImage imageNamed:@"introduceBack4.png"];
        page4.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText4.png"]];
        page4.titleIconPositionY = 0;

        page5.bgImage = [UIImage imageNamed:@"introduceBack5.png"];
        page5.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText5.png"]];
        page5.titleIconPositionY = 0;
        
        page6.bgImage = [UIImage imageNamed:@"introduceBack6.png"];
        page6.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText6.png"]];
        page6.titleIconPositionY = 0;
    } else {
        //iPhone 4S Screen
        page1.bgImage = [UIImage imageNamed:@"introduceBack1.png"];
        page1.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText1.png"]];
        page1.titleIconPositionY = 0;
        
        page2.bgImage = [UIImage imageNamed:@"introduceBack2.png"];
        page2.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText2.png"]];
        page2.titleIconPositionY = 0;
        
        page3.bgImage = [UIImage imageNamed:@"introduceBack3.png"];
        page3.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText3.png"]];
        page3.titleIconPositionY = 0;
        
        page4.bgImage = [UIImage imageNamed:@"introduceBack4.png"];
        page4.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText4.png"]];
        page4.titleIconPositionY = 0;
        
        page5.bgImage = [UIImage imageNamed:@"introduceBack5.png"];
        page5.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText5.png"]];
        page5.titleIconPositionY = 0;
        
        page6.bgImage = [UIImage imageNamed:@"introduceBack6.png"];
        page6.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText6.png"]];
        page6.titleIconPositionY = 0;
    }

    //Setting Button of text's attributted
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:@"소개 그만보기"];
    [attributeString addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:1]
                            range:(NSRange) {0, [attributeString length]}];

    //Setting Button of text
    UILabel *titleSkipBtn = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 20)];
    [titleSkipBtn setFont:[UIFont systemFontOfSize:14]];
    [titleSkipBtn setTextColor:[UIColor whiteColor]];
    [titleSkipBtn setAttributedText:[attributeString copy]];
    
    //Setting Button
    UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [skipBtn addSubview:titleSkipBtn];
    [skipBtn setAlpha:0.0f];
    [skipBtn setFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width/2 + 74,
                                 [[UIScreen mainScreen]bounds].size.height/2 - 277,
                                 150, 20)];
    [skipBtn addTarget:self action:@selector(skipBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //Setting IntroView
    EAIntroView *introView = [[EAIntroView alloc]initWithFrame:self.introduceView.bounds
                                                      andPages:@[page1, page2, page3, page4, page5, page6]];
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
