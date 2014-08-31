//
//  ReviewViewController.h
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 31..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewViewController : UIViewController 

@property (strong, nonatomic) NSURL *reviewURL;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
