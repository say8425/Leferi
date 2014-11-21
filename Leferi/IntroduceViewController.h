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
#import "GAITrackedViewController.h"

@interface IntroduceViewController : GAITrackedViewController <EAIntroDelegate>

@property (strong, nonatomic) IBOutlet UIView *introduceView;
@property (strong, nonatomic) EAIntroPage *introduce1;
@property (strong, nonatomic) EAIntroPage *introduce2;
@property (strong, nonatomic) EAIntroPage *introduce3;
@property (strong, nonatomic) EAIntroPage *introduce4;
@property (strong, nonatomic) EAIntroPage *introduce5;
@property (strong, nonatomic) EAIntroPage *introduce6;


@end
