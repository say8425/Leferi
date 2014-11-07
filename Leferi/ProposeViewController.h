//
//  ProposeViewController.h
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 4..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "GAITrackedViewController.h"
#import "ETCLibrary.h"
#import "UIBarButtonItem+Image.h"
#import "UIViewController+ScrollingNavbar.h"

@interface ProposeViewController : GAITrackedViewController

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageConstraintHeight;

@end
