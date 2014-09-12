//
//  InstaLoginViewController.h
//  Leferi
//
//  Created by Cheon Park on 2014. 9. 12..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstagramKit.h"
#import "BeautiViewController.h"

@class BeautiViewController;
@interface InstaLoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) BeautiViewController *beautiViewController;
@property (assign, nonatomic) IKLoginScope scope;



@end
