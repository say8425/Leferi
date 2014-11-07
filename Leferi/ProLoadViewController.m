//
//  ProLoadViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 10. 10..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "ProLoadViewController.h"

@interface ProLoadViewController ()

@end

@implementation ProLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //If classic, then bagImage is changed whit classicStyle
    if ([[ETCLibrary getScreenPhysicalSize] isEqual:@"Classic/"]) [self.launchImage setImage:[UIImage imageNamed:@"launch_4S.png"]];
    pathDictionary = [[NSMutableDictionary alloc]initWithCapacity:ENTERING_INTRO_JUG];

    //GoogleAnal Screen
    [self setScreenName:@"LoadView"];

    //Data Load
    [self makeIntroPage];
    
}

#pragma mark - Download Cache
///Download cache from server
- (void)makeIntroPage {
    NSOperationQueue *operationQueue = [NSOperationQueue new];
    
//IntroView Bak
    [operationQueue addOperations:[self conditionOperationPath:INTRO_VIEW_PATH withFileName:@"page" withForCount:4] waitUntilFinished:NO];
    
//IntroView Text
    [operationQueue addOperations:[self conditionOperationPath:INTRO_VIEW_PATH withFileName:@"pageText" withForCount:4] waitUntilFinished:NO];
    
//IntroView SkipButton
    [operationQueue addOperation:[self singOperationPath:INTRO_VIEW_PATH withFileName:@"pageSkipBtn"]];
    
//MenuView Menu
    [operationQueue addOperations:[self conditionOperationPath:MENU_VIEW_PATH withFileName:@"story" withForCount:4] waitUntilFinished:NO];
    
//MenuView Letter
    [operationQueue addOperations:[self conditionOperationPath:MENU_VIEW_PATH withFileName:@"letter" withForCount:2] waitUntilFinished:NO];

//ProposeView Image
    [operationQueue addOperation:[self singOperationPath:PROPOSE_VIEW_PATH withFileName:@"proposeStory"]];
    
//ReviewView List
    [operationQueue addOperations:[self conditionOperationPath:REVIEW_VIEW_PATH withFileName:@"blogMenu" withForCount:4] waitUntilFinished:NO];
    
//Plist
    [operationQueue addOperation:[self plistOperationPath]];
}

#pragma mark - Entering Intro
- (void)showIntroView {
    NSLog(@"entering Intro");
    [pathDictionary writeToFile:[ETCLibrary getPath] atomically:YES];
    NSLog(@"%@", [NSDictionary dictionaryWithContentsOfFile:[ETCLibrary getPath]]);
    [self performSegueWithIdentifier:@"enterIntro" sender:nil];
}

#pragma mark - Downloading Func
///Work on multiple operation. Put in count numbers. And It'll be only work on images
- (NSMutableArray *)conditionOperationPath:(NSString *)descriptionPath withFileName:(NSString *)fileName withForCount:(NSInteger)count {
    NSMutableArray* operationArray = [[NSMutableArray alloc]initWithCapacity:count];
    NSString *devicePath = [ETCLibrary getScreenPhysicalSize];
    for (int fileNum = 1; fileNum <= count; ++fileNum) {
        NSString *filePath = [NSString stringWithFormat:@"%@images/%@%@%@%d@2x.png", DEFAULT_PATH, devicePath, descriptionPath, fileName, fileNum];
        NSLog(@"URL:%@",filePath);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:filePath]];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d@2x.png",fileName, fileNum]];
        operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:path]];
            [pathDictionary setObject:path forKey:[NSString stringWithFormat:@"%@%d", fileName, fileNum]];
            NSLog(@"Successfully downloaded file to %@", path);
            
            //if all downloaded, then enterin
            if (pathDictionary.count == ENTERING_INTRO_JUG) {
                [self showIntroView];
            }            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            float percentDone = ((float)((int)totalBytesRead) / (float)((int)totalBytesExpectedToRead));
            NSLog(@"%ddone:%f", fileNum, percentDone);
        }];
        [operationArray addObject:operation];
    }
    return operationArray;
}

///Work on singleOperation.
- (AFHTTPRequestOperation *)singOperationPath:(NSString *)descriptionPath withFileName:(NSString *)fileName {
    NSString *devicePath = [ETCLibrary getScreenPhysicalSize];
    NSString *filePath = [NSString stringWithFormat:@"%@images/%@%@%@@2x.png", DEFAULT_PATH, devicePath, descriptionPath, fileName];
    //NSString *filePath = [NSString stringWithFormat:@"%@%@@2x.png", urlPath, fileName];
    NSLog(@"URL:%@",filePath);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:filePath]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@@2x.png", fileName]];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:path]];
        [pathDictionary setObject:path forKey:[NSString stringWithFormat:@"%@",fileName]];
        NSLog(@"Successfully downloaded file to %@", path);

        //if all downloaded, then enterin
        if (pathDictionary.count == ENTERING_INTRO_JUG) {
            [self showIntroView];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float percentDone = ((float)((int)totalBytesRead) / (float)((int)totalBytesExpectedToRead));
        NSLog(@"done:%f", percentDone);
    }];
    return operation;
}

///Getting JSON File. (read-only)
- (AFHTTPRequestOperation *)plistOperationPath {
    NSString *filePath = [NSString stringWithFormat:@"%@config.plist", PLIST_PATH];
    NSLog(@"URL:%@",filePath);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:filePath]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"config.plist"];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:path]];
        [pathDictionary setObject:path forKey:[NSString stringWithFormat:@"config"]];
        NSLog(@"Successfully downloaded file to %@", path);
        
        //if all downloaded, then enterin
        if (pathDictionary.count == ENTERING_INTRO_JUG) {
            [self showIntroView];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error:%@", error);
    }];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float percentDone = ((float)((int)totalBytesRead) / (float)((int)totalBytesExpectedToRead));
        NSLog(@"done:%f", percentDone);
    }];
    return operation;
}

///Make don't backUp in iCloud.
- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL {
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
