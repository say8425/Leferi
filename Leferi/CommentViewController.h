//
//  CommentViewController.h
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 11..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETCLibrary.h"
#import "UIBarButtonItem+Image.h"

@interface CommentViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIActivityIndicatorView *actiView;

@end
