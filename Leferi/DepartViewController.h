//
//  DepartViewController.h
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 26..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBarButtonItem+Image.h"
#import "TLYShyNavBarManager.h"

@interface DepartViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIActivityIndicatorView *actiView;


@end
