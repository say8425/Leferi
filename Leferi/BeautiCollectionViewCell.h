//
//  BeautiCollectionViewCell.h
//  Leferi
//
//  Created by Cheon Park on 2014. 10. 28..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeautiCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIButton *userProfileBtn;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *createdDate;
@property (strong, nonatomic) IBOutlet UIButton *followBtn;

@property (strong, nonatomic) IBOutlet UIImageView *instaImageView;
@property (strong, nonatomic) IBOutlet UIButton *likeBtn;
@property (strong, nonatomic) IBOutlet UILabel *caption;
@property (strong, nonatomic) IBOutlet UILabel *comment;

@end
