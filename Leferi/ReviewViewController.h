//
//  ReviewViewController.h
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 31..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBarButtonItem+Image.h"
#import "UIViewController+ScrollingNavbar.h"

@interface ReviewViewController : UIViewController <UIWebViewDelegate>


@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSURL *reviewURL;
@property (strong, nonatomic) NSString *urlString;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIActivityIndicatorView *actiView;


@end
