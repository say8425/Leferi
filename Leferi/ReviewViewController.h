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

@interface ReviewViewController : UIViewController <UIScrollViewDelegate, UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSURL *reviewURL;
@property (strong, nonatomic) NSString *urlString;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIActivityIndicatorView *actiView;
@property (strong, nonatomic) IBOutlet UIButton *webBack;
@property (strong, nonatomic) IBOutlet UIButton *webForward;
@property (strong, nonatomic) IBOutlet UIButton *webReload;

- (IBAction)webBack:(id)sender;
- (IBAction)webForward:(id)sender;

@end
