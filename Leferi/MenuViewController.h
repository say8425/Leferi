//
//  MenuViewController.h
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 18..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideOutTableViewController.h"
#import "MCPanelViewController.h"
#import "XCDYouTubeKit.h"
#import "UIViewController+Rotation.h"
#import "UIViewController+ScrollingNavbar.h"

@interface MenuViewController : UIViewController {
    MCPanelViewController *slideOutPanelController;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn1;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn2;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn3;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn4;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn5;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn6;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn7;

- (IBAction)slideBtn:(id)sender;
- (IBAction)btn2YouTube:(id)sender;
- (IBAction)btn7Facebook:(id)sender;

@end
