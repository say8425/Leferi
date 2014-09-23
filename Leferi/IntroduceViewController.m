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
        
        EAIntroView *introduceView = [[EAIntroView alloc]initWithFrame:self.view.bounds andPages:@[page1, page2, page3, page4, page5, page6]];
        [introduceView showInView:self.view animateDuration:0.3];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
