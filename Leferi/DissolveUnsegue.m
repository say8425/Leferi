//
//  DissolveUnsegue.m
//  Leferi
//
//  Created by Cheon Park on 2014. 10. 20..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "DissolveUnsegue.h"

@implementation DissolveUnsegue

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;

    // Add view to super view temporarily
    [sourceViewController.view.superview insertSubview:destinationViewController.view atIndex:0];
    
//    UIView *statusBarView;
//    statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 22)];
//    statusBarView.backgroundColor  =  [UIColor blackColor];
//    statusBarView.alpha = 1.0f;
//    [sourceViewController.view addSubview:statusBarView];

    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         sourceViewController.navigationController.navigationBar.alpha = 0.0f;
                         sourceViewController.view.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         [destinationViewController.view removeFromSuperview]; // remove from temp super view
                         [sourceViewController dismissViewControllerAnimated:NO completion:NULL]; // dismiss VC
                     }];
}

@end
