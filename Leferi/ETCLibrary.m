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

@end
