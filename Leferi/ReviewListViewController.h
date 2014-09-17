//
//  ReviewViewController.h
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 26..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCDYouTubeKit.h"
#import "ReviewViewCell.h"
#import "ReviewViewController.h"
#import "UIViewController+ScrollingNavbar.h"
#import "UIBarButtonItem+Image.h"

@interface ReviewListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *reviewImageArray;
@property (strong, nonatomic) NSArray *reviewAddressArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
