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
//Before working, clear the Document path.
    [self clearDocuments];
    
//Making operationgQueue
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
    
//IntroduceView Bak
    [operationQueue addOperations:[self conditionOperationPath:INTRODUCE_VIEW_PATH withFileName:@"introduce" withForCount:6] waitUntilFinished:NO];
    
//IntroduceView Text
    [operationQueue addOperations:[self conditionOperationPath:INTRODUCE_VIEW_PATH withFileName:@"introduceText" withForCount:6] waitUntilFinished:NO];
    
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
    NSDictionary *test = [NSDictionary dictionaryWithContentsOfFile:[ETCLibrary getPath]];
    NSLog(@"fff%@", [NSDictionary dictionaryWithContentsOfFile:[test objectForKey:@"config"]]);
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
        
//        NSString *tempDir = NSTemporaryDirectory();
//        NSString *path = [tempDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d@2x.png",fileName, fileNum]];
        
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
    NSLog(@"URL:%@",filePath);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:filePath]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@@2x.png", fileName]];
    
    
//    NSString *tempDir = NSTemporaryDirectory();
//    NSString *path = [tempDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@@2x.png",fileName]];
    
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
    
//    // Create a FileHandle
//    NSFileHandle *myHandle;
//    
//    // Check File Exist at Location or not, if not then create new
//    if(![[NSFileManager defaultManager] fileExistsAtPath:path])
//        [[NSFileManager defaultManager] createFileAtPath:path contents:[@"Your First String" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
//    
//    // Create handle for file to update content
//    myHandle = [NSFileHandle fileHandleForUpdatingAtPath:path];
//    
//    // move to the end of the file to add data
//    [myHandle seekToEndOfFile];
//    
//    // Write data to file
//    [myHandle writeData:  [@"YOUr Second String" dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    // Close file
//    [myHandle closeFile];
    
//    NSString *tempDir = NSTemporaryDirectory();
//    NSString *path = [tempDir stringByAppendingPathComponent:@"config.plist"];
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

- (void)clearDocuments {
    // Path to the Documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0) {
        NSError *error = nil;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        // Print out the path to verify we are in the right place
        NSString *directory = [paths objectAtIndex:0];
        NSLog(@"Directory: %@", directory);
        
        // For each file in the directory, create full path and delete the file
        for (NSString *file in [fileManager contentsOfDirectoryAtPath:directory error:&error]) {
            NSString *filePath = [directory stringByAppendingPathComponent:file];
            NSLog(@"File : %@", filePath);
            
            BOOL fileDeleted = [fileManager removeItemAtPath:filePath error:&error];
            
            if (fileDeleted != YES || error != nil) {
                NSLog(@"File can't be deleted");
            }
        }
        
    }
}

@end
