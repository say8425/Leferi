//
//  ReviewViewController.h
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 26..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewViewCell.h"
#import "ReviewViewController.h"
#import "TLYShyNavBarManager.h"
#import "UIBarButtonItem+Image.h"

@interface ReviewListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSArray *reviewImageArray;
    NSArray *reviewAddressArray;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
