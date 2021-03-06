//
//  NewMenuViewController.h
//  Leferi
//
//  Created by Cheon Park on 2014. 9. 15..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAITrackedViewController.h"
#import "ETCLibrary.h"
#import "DissolveUnsegue.h"
#import "UIColor+HexString.h"
#import "UIViewController+Rotation.h"

@interface NewMenuViewController : GAITrackedViewController {
    UIView *statusBarView;
    NSString *instaTag;
    NSString *instaWeb;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *titleImageView;
@property (strong, nonatomic) IBOutlet UIImageView *letterImageView;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn1;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn2;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn3;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn4;

- (IBAction)InstagramOpen:(id)sender;

@end
