//
//  ETCLibrary.h
//  Leferi
//
//  Created by Cheon Park on 2014. 10. 16..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <sys/sysctl.h>
#import <UIKit/UIKit.h>
#import "Config.h"

@interface ETCLibrary : NSObject

///Downloaded cache path
+ (NSString *)getPath;

///Makeing random float number
+ (float)randFloatBetweenLow:(float)low andHigh:(float)high;

///Getting screen size, use it unless we can support iPhone 6+
+ (NSString *)getScreenPhysicalSize;

///Getting platform type
+ (NSString *)getPlatformType;

///Logging All Fonts
+ (void)showAllfonts;

///Getting StatusBarFontColor. 0:1 = Black:White.
+ (NSInteger)getStatusBarFontColor;


@end
