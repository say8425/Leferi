//
//  MainTableViewController.h
//  Leferi
//
//  Created by Cheon Park on 2014. 7. 7..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

// WARNING! This code is dummy.
// We don't use it anymore.

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "MainTableViewCell.h"
#import "TLYShyNavBarManager.h"
//#import "UIViewController+ScrollingNavbar.h"

@interface MainTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *cellImageT;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) UIImage *titleBar;
@property (strong, nonatomic) UIButton *floatingBtn;
@property (strong, nonatomic) NSArray *cellImageM;
@property (assign, nonatomic) CGFloat previousScrollViewYOffset;

//- (void)stoppedScrolling;
//- (void)updateBarButtonItems:(CGFloat)alpha;
//- (void)animateNavBarTo:(CGFloat)y;

@end
