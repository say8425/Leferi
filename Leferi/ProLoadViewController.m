//
//  ProLoadViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 10. 10..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "ProLoadViewController.h"
#define ENTERING_INTRO_JUG 22
#define INTRO_VIEW_PATH @"http://121.78.85.56/mobileApp/iOS/currentVersion/images/IntroView/"
#define MENU_VIEW_PATH @"http://121.78.85.56/mobileApp/iOS/currentVersion/images/MenuView/"
#define PROPOSE_VIEW_PATH @"http://121.78.85.56/mobileApp/iOS/currentVersion/images/ProposeView/"
#define REVIEW_VIEW_PATH @"http://121.78.85.56/mobileApp/iOS/currentVersion/images/ReviewView/"
#define BEAUTIGRAM_PATH @"http://121.78.85.56/mobileApp/iOS/currentVersion/images/BeautiGram/"
#define PLIST_PATH @"http://121.78.85.56/mobileApp/iOS/currentVersion/plist/"

@interface ProLoadViewController ()

@end

@implementation ProLoadViewController

- (void)viewDidLoad {
    pathDictionary = [[NSMutableDictionary alloc]initWithCapacity:ENTERING_INTRO_JUG];
    [super viewDidLoad];
    [self makeIntroPage];
}

#pragma mark - Download Cache
///Download cache from server
- (void)makeIntroPage {
    NSOperationQueue *operationQueue = [NSOperationQueue new];
    
//IntroView Bak
    [operationQueue addOperations:[self conditionOperationPath:INTRO_VIEW_PATH withFileName:@"page" withStatusText:@"시작화면을 그리고 있어요" withForCount:4] waitUntilFinished:NO];
    
//IntroView Text
    [operationQueue addOperations:[self conditionOperationPath:INTRO_VIEW_PATH withFileName:@"pageText" withStatusText:@"시작화면 문구가 준비되었어요" withForCount:4] waitUntilFinished:NO];
    
//IntroView SkipButton
    [operationQueue addOperation:[self singOperationPath:INTRO_VIEW_PATH withFileName:@"pageSkipBtn" withStatusText:@"터치버튼을 준비하고 있어요"]];
    
//MenuView Menu
    [operationQueue addOperations:[self conditionOperationPath:MENU_VIEW_PATH withFileName:@"story" withStatusText:@"메뉴를 배치하고 있어요" withForCount:4] waitUntilFinished:NO];
    
//MenuView Letter
    [operationQueue addOperations:[self conditionOperationPath:MENU_VIEW_PATH withFileName:@"letter" withStatusText:@"초대장을 받아오고 있어요" withForCount:2] waitUntilFinished:NO];

//ProposeView Image
    [operationQueue addOperation:[self singOperationPath:PROPOSE_VIEW_PATH withFileName:@"proposeStory" withStatusText:@"초대장을 작성하고 있어요"]];
    
//ReviewView List
    [operationQueue addOperations:[self conditionOperationPath:REVIEW_VIEW_PATH withFileName:@"blogMenu" withStatusText:@"블로거들의 리뷰를 받아오고 있어요" withForCount:4] waitUntilFinished:NO];
    
//Beautigram HeadImage
    [operationQueue addOperation:[self singOperationPath:BEAUTIGRAM_PATH withFileName:@"instaHead" withStatusText:@"인스타그램에 접속중이에요"]];

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier]isEqualToString:@"enterIntro"]) {
        ViewController *viewController = [segue destinationViewController];
        viewController.pathDictionary = pathDictionary;
    }
    
}

#pragma mark - Downloading Func
///Work on multiple operation. Put in count numbers.
- (NSMutableArray *)conditionOperationPath:(NSString *)urlPath withFileName:(NSString *)fileName withStatusText:(NSString *)statusText withForCount:(NSInteger)count {
    NSMutableArray* operationArray = [[NSMutableArray alloc]initWithCapacity:count];
    for (int fileNum = 1; fileNum <= count; ++fileNum) {
        NSString *filePath = [NSString stringWithFormat:@"%@%@%d@2x.png", urlPath, fileName, fileNum];
        NSLog(@"URL:%@",filePath);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:filePath]];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d@2x.png",fileName, fileNum]];
        operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
        
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [pathDictionary setObject:path forKey:[NSString stringWithFormat:@"%@%d", fileName, fileNum]];
            [self.connectStatus setText:statusText];
            NSLog(@"Successfully downloaded file to %@", path);
            
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
- (AFHTTPRequestOperation *)singOperationPath:(NSString *)urlPath withFileName:(NSString *)fileName withStatusText:(NSString *)statusText {
    NSString *filePath = [NSString stringWithFormat:@"%@%@@2x.png", urlPath, fileName];
    NSLog(@"URL:%@",filePath);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:filePath]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@@2x.png", fileName]];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [pathDictionary setObject:path forKey:[NSString stringWithFormat:@"%@",fileName]];
        [self.connectStatus setText:statusText];
        NSLog(@"Successfully downloaded file to %@", path);
        if (pathDictionary.count == ENTERING_INTRO_JUG) {
            [self showIntroView];
            NSLog(@"loadingView is dis3");
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
    NSString *urlPath = PLIST_PATH;
    NSString *filePath = [NSString stringWithFormat:@"%@config.plist", urlPath];
    NSLog(@"URL:%@",filePath);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:filePath]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"config.plist"];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [pathDictionary setObject:path forKey:[NSString stringWithFormat:@"config"]];
        NSLog(@"Successfully downloaded file to %@", path);
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

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
