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

    //UIDevice read
    RTScreenPhysicalSize *rtScreenPhysicalSize = [RTScreenPhysicalSize new];

    EAIntroPage *page1 = [EAIntroPage page];
    EAIntroPage *page2 = [EAIntroPage page];
    EAIntroPage *page3 = [EAIntroPage page];
    EAIntroPage *page4 = [EAIntroPage page];
    EAIntroPage *page5 = [EAIntroPage page];
    EAIntroPage *page6 = [EAIntroPage page];

    if ([rtScreenPhysicalSize screenPhysicalSize] == SCREEN_SIZE_IPHONE_TALL) {
        page1.bgImage = [UIImage imageNamed:@"introduceBack1.png"];
        page1.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText1.png"]];
        page1.titleIconPositionY = 0;
        
        page2.bgImage = [UIImage imageNamed:@"introduceBack1.png"];
        page2.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText1.png"]];
        page2.titleIconPositionY = 0;
        
        page3.bgImage = [UIImage imageNamed:@"introduceBack1.png"];
        page3.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText1.png"]];
        page3.titleIconPositionY = 0;
        
        page4.bgImage = [UIImage imageNamed:@"introduceBack1.png"];
        page4.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText1.png"]];
        page4.titleIconPositionY = 0;

        page5.bgImage = [UIImage imageNamed:@"introduceBack1.png"];
        page5.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText1.png"]];
        page5.titleIconPositionY = 0;
        
        page6.bgImage = [UIImage imageNamed:@"introduceBack1.png"];
        page6.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText1.png"]];
        page6.titleIconPositionY = 0;
    } else {
        //iPhone 4S Screen
        page1.bgImage = [UIImage imageNamed:@"introduceBack1.png"];
        page1.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText1.png"]];
        page1.titleIconPositionY = 0;
        
        page2.bgImage = [UIImage imageNamed:@"introduceBack1.png"];
        page2.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText1.png"]];
        page2.titleIconPositionY = 0;
        
        page3.bgImage = [UIImage imageNamed:@"introduceBack1.png"];
        page3.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText1.png"]];
        page3.titleIconPositionY = 0;
        
        page4.bgImage = [UIImage imageNamed:@"paintroduceBack1.png"];
        page4.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText1.png"]];
        page4.titleIconPositionY = 0;
        
        page5.bgImage = [UIImage imageNamed:@"introduceBack1.png"];
        page5.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText1.png"]];
        page5.titleIconPositionY = 0;
        
        page6.bgImage = [UIImage imageNamed:@"introduceBack1.png"];
        page6.titleIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"introduceText1.png"]];
        page6.titleIconPositionY = 0;
        
    }
//    EAIntroView *introView = [[EAIntroView alloc]initWithFrame:self.introduceView.bounds];
    EAIntroView *introView = [[EAIntroView alloc]initWithFrame:self.introduceView.bounds
                                                          andPages:@[page1, page2, page3, page4, page5, page6]];
    
    UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:@"소개 그만보기"];
    [attributeString addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:1]
                            range:(NSRange) {0, [attributeString length]}];
    UILabel *titleSkipBtn = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 20)];
//    [titleSkipBtn setBackgroundColor:[UIColor whiteColor]];
    //[titleSkipBtn setFont:[UIFont fontWithName:@"Chalkboard" size:14]];
    [titleSkipBtn setFont:[UIFont systemFontOfSize:14]];
//    titleSkipBtn.text=@"소개 그만보기";
    [titleSkipBtn setTextColor:[UIColor whiteColor]];
    [titleSkipBtn setAttributedText:[attributeString copy]];
    [skipBtn addSubview:titleSkipBtn];
    [skipBtn setAlpha:0.0f];
    //[skipBtn setTitle:@"소개 그만보기" forState:UIControlStateNormal];
    //[skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    //[skipBtn setBackgroundImage:[UIImage imageNamed:@"pageSkipBtn.png"] forState:UIControlStateNormal];
    [skipBtn setFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width/2 + 74,
                                 [[UIScreen mainScreen]bounds].size.height/2 - 240,
                                 150, 20)];
    [skipBtn addTarget:self action:@selector(skipBtn:) forControlEvents:UIControlEventTouchUpInside];
    [introView setSkipButton:skipBtn];
    [introView setSwipeToExit:NO];
    [introView setShowSkipButtonOnlyOnLastPage:NO];
//    [introView setPages:@[page1, page2, page3, page4, page5, page6]];
//    [introView setDelegate:self];
    [introView showInView:self.introduceView animateDuration:0.3];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)skipBtn:(id)sender {
    [self performSegueWithIdentifier:@"backPopup" sender:sender];
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
