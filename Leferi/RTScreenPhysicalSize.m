//
//  RTScreenPhysicalSize.m
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 27..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "RTScreenPhysicalSize.h"

@implementation RTScreenPhysicalSize

- (CGFloat)screenPhysicalSize
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if (result.height < 500) return SCREEN_SIZE_IPHONE_CLASSIC;  // iPhone 4S / 4th Gen iPod Touch or earlier
        else return SCREEN_SIZE_IPHONE_TALL;                         // iPhone 5
    } else {
        CGSize result = [[UIScreen mainScreen] bounds].size;         // iPad
        if (result.height < 900) return SCREEN_SIZE_IPAD_CLASSIC;    // iPad mini
        else return SCREEN_SIZE_IPAD_MINI;
    }
}


@end
