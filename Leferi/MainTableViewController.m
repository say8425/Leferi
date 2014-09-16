//
//  MainTableViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 7. 7..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    
    //NaviBar setting
    self.titleBar = [UIImage imageNamed:@"titleBar.png"];
    [self.navigationController.navigationBar setBackgroundImage:self.titleBar forBarMetrics:UIBarMetricsDefault];
    //[self.navigationController.navigationBar setTranslucent:NO];
    //self.shyNavBarManager.scrollView = self.tableView;


//    //Floating icon setting - Calling swipping메뉴
//    self.floatingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.floatingBtn addTarget:self.revealViewController
//                         action:@selector(revealToggle:)
//               forControlEvents:UIControlEventTouchUpInside];
//    [self.floatingBtn setImage:[UIImage imageNamed:@"menuBtn.png"] forState:normal];
//    [self.floatingBtn setFrame:CGRectMake(CGRectGetMaxX(self.view.frame) * 0.05,
//                                          CGRectGetMaxY(self.view.frame) * 0.85, 50, 50)];
//    [self.view addSubview:self.floatingBtn];
//
//    //Gesture
//    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
//
    //table 타이틀 이미지
    [self.cellImageT setImage:[UIImage imageNamed:@"menu1.png"]];
    //table 어레이 이미지
    self.cellImageM = @[@"menu2.png",
                        @"menu3.png",
                        @"menu4.png",
                        @"menu5.png",
                        @"menu6.png",
                        @"menu7.png"
                        ];

    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];


    //[self.navigationController.navigationBar setTranslucent:NO];
    //[self.navigationController.navigationBar setTintColor:[UIColor clearColor]];

//    self.shyNavBarManager.scrollView = self.tableView;

}

#pragma mark - FloatingBtn Setting

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //floating btn Function
    if ([scrollView isEqual:self.tableView]) {
        self.floatingBtn.transform = CGAffineTransformMakeTranslation(0, scrollView.contentOffset.y);
    }
}

#pragma mark - NavBar Disappear&Appear



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellImageM.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //테이블 셀 세팅, 320x160
    MainTableViewCell *tCell = [tableView dequeueReusableCellWithIdentifier:@"GiftsTableCell" forIndexPath:indexPath];
    [tCell.cellImage setImage:[UIImage imageNamed:self.cellImageM[indexPath.row]]];

    return tCell;
}


//now close it. And we'll don't use it.
- (void)earlyScrollFadeOut {
    //    scrollViewDidScroll
    //    //네이게이션바 사라짐
    //    CGRect frame = self.navigationController.navigationBar.frame;
    //    CGFloat size = frame.size.height - 21; //statusBar disappearing height
    //    CGFloat framePercentageHidden = ((20 - frame.origin.y) / (frame.size.height - 1));
    //    CGFloat scrollOffset = scrollView.contentOffset.y;
    //    CGFloat scrollDiff = scrollOffset - self.previousScrollViewYOffset;
    //    CGFloat scrollHeight = scrollView.frame.size.height;
    //    CGFloat scrollContentSizeHeight = scrollView.contentSize.height + scrollView.contentInset.bottom;
    //
    //
    //    if (scrollOffset <= -scrollView.contentInset.top) {
    //        frame.origin.y = 20;
    //    } else if ((scrollOffset + scrollHeight) >= scrollContentSizeHeight) {
    //        frame.origin.y = - size;
    //    } else {
    //        frame.origin.y = MIN(20, MAX(-size, frame.origin.y - scrollDiff));
    //    }
    //
    //    [self.navigationController.navigationBar setFrame:frame];
    //    [self.navigationController.navigationBar setAlpha:1 - framePercentageHidden];
    //
    //    [self updateBarButtonItems:(1 - framePercentageHidden)];
    //    self.previousScrollViewYOffset = scrollOffset;


    //#pragma mark -
    //#pragma mark SubFunction for hiding NavigationBar when scrollDown
    //
    //- (void)stoppedScrolling {
    //    CGRect frame = self.navigationController.navigationBar.frame;
    //
    //    if (frame.origin.y < 20) {
    //        [self animateNavBarTo:-(frame.size.height - 21)];
    //    }
    //}
    //
    //- (void)updateBarButtonItems:(CGFloat)alpha {
    //    [self.navigationItem.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem* item, NSUInteger i, BOOL *stop) {
    //        item.customView.alpha = alpha;
    //    }];
    //    [self.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem* item, NSUInteger i, BOOL *stop) {
    //        item.customView.alpha = alpha;
    //    }];
    //    self.navigationItem.titleView.alpha = alpha;
    //    self.navigationController.navigationBar.tintColor = [self.navigationController.navigationBar.tintColor colorWithAlphaComponent:alpha];
    //}
    //
    //- (void)animateNavBarTo:(CGFloat)y {
    //    [UIView animateWithDuration:0.2 animations:^{
    //        CGRect frame = self.navigationController.navigationBar.frame;
    //        CGFloat alpha = (frame.origin.y >= y ? 0 : 1);
    //        frame.origin.y = y;
    //        [self.navigationController.navigationBar setFrame:frame];
    //        [self updateBarButtonItems:alpha];
    //    }];
    //}
}


@end