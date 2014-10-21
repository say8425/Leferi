//
//  ETCLibrary.h
//  Leferi
//
//  Created by Cheon Park on 2014. 10. 16..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETCLibrary : NSObject

///Downloaded cache path
+ (NSString *)getPath;

///Makeing random float number
+ (float)randFloatBetweenLow:(float)low andHigh:(float)high;


@end
