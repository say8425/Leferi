//
//  BeautiTableViewCell.h
//  Leferi
//
//  Created by Cheon Park on 2014. 9. 2..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeautiTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *instaImageView;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UILabel *comment;

@end
