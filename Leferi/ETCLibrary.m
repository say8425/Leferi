//
//  ETCLibrary.m
//  Leferi
//
//  Created by Cheon Park on 2014. 10. 16..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "ETCLibrary.h"

@implementation ETCLibrary

///Downloaded cache path
+ (NSString *)getPath {
    NSString *docsDir;
    NSArray *dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"path.plist"]];
    
    return databasePath;
}

///Makeing random float number
+ (float)randFloatBetweenLow:(float)low andHigh:(float)high {
    float diff = high - low;
    float result = (((float) rand() / RAND_MAX) * diff) + low;
    NSLog(@"floatResule:%f", result);
    return result;
}

///Getting screen size, use it unless we can support iPhone 6+
+ (NSString *)getScreenPhysicalSize {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if (result.height < 500) return @"Classic/";  // iPhone 4S or 4
        else return @"Tall/";                         // iPhone 5
}

///Getting platform type
+ (NSString *)getPlatformType {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    else if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    else return @"iPhone";
}

///Logging All Fonts
+ (void)showAllfonts {
    for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);

        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }
}

///Getting StatusBarFontColor. 0:1 = Black:White.
+ (NSInteger)getStatusBarFontColor {
    NSDictionary *pathPlist = [NSDictionary dictionaryWithContentsOfFile:[self getPath]];
    NSDictionary *configDict = [NSDictionary dictionaryWithContentsOfFile:[pathPlist objectForKey:@"config"]];
    
    return [[configDict objectForKey:@"statusBarFontColor"]integerValue];
}


@end
