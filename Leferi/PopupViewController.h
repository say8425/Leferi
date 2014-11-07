//
//  PopupViewController.h
//  Leferi
//
//  Created by Cheon Park on 2014. 9. 19..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETCLibrary.h"
#import "DissolveUnsegue.h"
#import "GAITrackedViewController.h"

@interface PopupViewController : GAITrackedViewController

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UIButton *homeBtn;
@property (strong, nonatomic) IBOutlet UIButton *introduceBtn;
@property (strong, nonatomic) IBOutlet UIButton *historyBtn;
@property (strong, nonatomic) IBOutlet UIButton *backView;
@property (strong, nonatomic) IBOutlet UIImageView *popViewBack;

@end
