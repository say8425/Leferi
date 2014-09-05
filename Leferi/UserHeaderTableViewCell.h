//
//  UserHeaderTableViewCell.h
//  Leferi
//
//  Created by Cheon Park on 2014. 9. 5..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserHeaderTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *userProfileBtn;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *createdDate;
@property (strong, nonatomic) IBOutlet UIButton *followBtn;

@end
