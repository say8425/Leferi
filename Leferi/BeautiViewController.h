//
//  BeautiViewController.h
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 27..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeautiTableViewCell.h"
#import "UserHeaderTableViewCell.h"
#import "UIBarButtonItem+Image.h"
#import "InstagramKit.h"
#import "InstagramUser.h"
#import "InstagramMedia.h"
#import "UIKit+AFNetworking.h"
#import "UIViewController+ScrollingNavbar.h"

@interface BeautiViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSString *tagString;
    NSMutableArray *mediaArray;
    NSMutableArray *commentArray;
    NSInteger mediaOrder;
    BOOL login;
}

@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) InstagramMedia * media;
@property (strong, nonatomic) InstagramPaginationInfo *currentPaginationInfo;

- (void)reloadMedia;

@end
