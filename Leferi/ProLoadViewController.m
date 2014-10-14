//
//  ProLoadViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 10. 10..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "ProLoadViewController.h"
#define ENTERING_INTRO_JUG 9
#define INTRO_VIEW_PATH @"http://121.78.85.56/mobileApp/iOS/currentVersion/images/IntroView/"

@interface ProLoadViewController ()

@end

@implementation ProLoadViewController

- (void)viewDidLoad {
    pathDictionary = [[NSMutableDictionary alloc]initWithCapacity:ENTERING_INTRO_JUG];
    [super viewDidLoad];
    [self makeIntroPage];
}

- (void)makeIntroPage {
    NSOperationQueue *operationQueue = [NSOperationQueue new];
    
    for (int fileNum = 1; fileNum <= 4; ++fileNum) {
        NSString *urlPath = INTRO_VIEW_PATH;
        NSString *filePath = [NSString stringWithFormat:@"%@page%d@2x.png", urlPath, fileNum];
        NSLog(@"URL:%@",filePath);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:filePath]];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"page%d@2x.png",fileNum]];
        operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
        
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"Successfully downloaded file to %@", path);
            [pathDictionary setObject:path forKey:[NSString stringWithFormat:@"page%d", fileNum]];
            if (pathDictionary.count == ENTERING_INTRO_JUG) {
                [self showIntroView];
                NSLog(@"loadingView is dis1");
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            float percentDone = ((float)((int)totalBytesRead) / (float)((int)totalBytesExpectedToRead));
            NSLog(@"%ddone:%f", fileNum, percentDone);
        }];
        [operationQueue addOperation:operation];
    }
    
    for (int fileNum = 1; fileNum <= 4; ++fileNum) {
        NSString *urlPath = INTRO_VIEW_PATH;
        NSString *filePath = [NSString stringWithFormat:@"%@pageText%d@2x.png", urlPath, fileNum];
        NSLog(@"URL:%@",filePath);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:filePath]];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"pageText%d@2x.png",fileNum]];
        operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
        
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [pathDictionary setObject:path forKey:[NSString stringWithFormat:@"pageText%d", fileNum]];
            NSLog(@"Successfully downloaded file to %@", path);
            
            if (pathDictionary.count == ENTERING_INTRO_JUG) {
                [self showIntroView];
                NSLog(@"loadingView is dis2");
            }
            

            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            float percentDone = ((float)((int)totalBytesRead) / (float)((int)totalBytesExpectedToRead));
            NSLog(@"%ddone:%f", fileNum, percentDone);
        }];
        [operationQueue addOperation:operation];
    }
    
    NSString *urlPath = INTRO_VIEW_PATH;
    NSString *filePath = [NSString stringWithFormat:@"%@pageSkipBtn@2x.png", urlPath];
    NSLog(@"URL:%@",filePath);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:filePath]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"pageSkipBtn@2x.png"];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];

    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [pathDictionary setObject:path forKey:@"pageSkipBtn"];
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
    [operationQueue addOperation:operation];
    
    
    
}

- (void)showIntroView {
    NSLog(@"entering Intro");
    [self performSegueWithIdentifier:@"enterIntro" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier]isEqualToString:@"enterIntro"]) {
        ViewController *viewController = [segue destinationViewController];
        viewController.pathDictionary = pathDictionary;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
