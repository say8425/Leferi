//
//  InfoGuideViewController.h
//  Leferi
//
//  Created by Cheon Park on 2014. 10. 24..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETCLibrary.h"
#import "GAITrackedViewController.h"
#import "UIBarButtonItem+Image.h"
#import "UIViewController+ScrollingNavbar.h"

@interface InfoGuideViewController : GAITrackedViewController

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *InfoGuideBack;

@end
