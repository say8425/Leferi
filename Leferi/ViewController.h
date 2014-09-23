//
//  ViewController.h
//  Leferi
//
//  Created by Cheon Park on 2014. 7. 9..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EAIntroView.h"
#import "SMPageControl.h"
#import "RTScreenPhysicalSize.h"
#import "UIViewController+Rotation.h"
#import "Config.h"

@interface ViewController : UIViewController <EAIntroDelegate>

@property (weak, nonatomic) IBOutlet EAIntroView *introView;
@property (weak, nonatomic) IBOutlet UIButton *proposeBtn;

@end
