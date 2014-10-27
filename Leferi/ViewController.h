//
//  ViewController.h
//  Leferi
//
//  Created by Cheon Park on 2014. 7. 9..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EAIntroView.h"
#import "AFNetworking.h"
#import "SMPageControl.h"
#import "UIViewController+Rotation.h"
#import "UIImageView+AFNetworking.h"
#import "ETCLibrary.h"
#import "Config.h"

@interface ViewController : UIViewController <EAIntroDelegate>

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) NSString *testPath;
@property (strong, nonatomic) EAIntroPage *page1;
@property (strong, nonatomic) EAIntroPage *page2;
@property (strong, nonatomic) EAIntroPage *page3;
@property (strong, nonatomic) EAIntroPage *page4;
@property (strong, nonatomic) IBOutlet UIImageView *dummyImage;

@end
