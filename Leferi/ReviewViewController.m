//
//  ReviewViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 31..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "ReviewViewController.h"

@implementation ReviewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.reviewURL]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
