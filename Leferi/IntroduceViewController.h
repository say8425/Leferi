//
//  IntroduceViewController.h
//  Leferi
//
//  Created by Cheon Park on 2014. 9. 19..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EAIntroView.h"
#import "ETCLibrary.h"

@interface IntroduceViewController : UIViewController <EAIntroDelegate>

@property (strong, nonatomic) IBOutlet UIView *introduceView;

@end
