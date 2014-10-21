//
//  DissolveSegue.m
//  Leferi
//
//  Created by Cheon Park on 2014. 10. 17..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//
//  northPenguin
//  Each class means the going way. For example `isKindOfClass:[NewMenuViewController class]`
//  then that case mena `going to NewMenuViewController` Use wisely.

#import "DissolveSegue.h"
#import "ViewController.h"
#import "NewMenuViewController.h"
#import "VersionViewController.h"

@implementation DissolveSegue


//- (void)perform {
//    CATransition* transition = [CATransition animation];
//    
//    transition.duration = 1.5;
//    transition.type = kCATransitionFade;
//    
//    [[self.sourceViewController navigationController].view.layer addAnimation:transition forKey:kCATransition];
//    [[self.sourceViewController navigationController] pushViewController:[self destinationViewController] animated:NO];
//}

- (void)perform
{
    CATransition *transition = [CATransition animation];
    
    if ([self.destinationViewController isKindOfClass:[NewMenuViewController class]]) {
        [transition setDuration:1.2];
    } else if ([self.destinationViewController isKindOfClass:[ViewController class]]) {
        //[NSThread sleepForTimeInterval:1];
        [transition setDuration:0.84];

//        [[[[[self sourceViewController] view] window] layer] addAnimation:transition
//                                                                   forKey:kCATransitionFade];
//        [[self sourceViewController]presentViewController:[self destinationViewController] animated:NO completion:NULL];
//        return;
//        
//    } else if ([self.destinationViewController isKindOfClass:[VersionViewController class]]) {
//        [transition setDuration:0.42];
//    }
    
    
    } else {
        [transition setDuration:0.6];
    } [transition setType:kCATransitionFade];
    
    [[[[[self sourceViewController] view] window] layer] addAnimation:transition
                                                               forKey:kCATransitionFade];
    [[self sourceViewController]presentViewController:[self destinationViewController] animated:NO completion:NULL];
}

//- (void)perform {
//    UIViewController *sourceViewController = self.sourceViewController;
//    UIViewController *destinationViewController = self.destinationViewController;
//
//    // Add the destination view as a subview, temporarily
//    [sourceViewController.view addSubview:destinationViewController.view];
//
//    // Transformation start scale
//    destinationViewController.view.transform = cga
//
//    // Store original centre point of the destination view
//    CGPoint originalCenter = destinationViewController.view.center;
//    // Set center to start point of the button
//    destinationViewController.view.center = self.originatingPoint;
//
//    [UIView animateWithDuration:0.5
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut
//                     animations:^{
//                     // Grow!
//                     destinationViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
//                     destinationViewController.view.center = originalCenter;
//                 }
//                 completion:^(BOOL finished){
//                     [destinationViewController.view removeFromSuperview]; // remove from temp super view
//                     [sourceViewController presentViewController:destinationViewController animated:NO completion:NULL]; // present VC
//                 }];


//- (void)perform {
//    UIViewController *sourceViewController = (UIViewController *)self.sourceViewController;
//    UIViewController *destinationViewController = (UIViewController *)self.destinationViewController;
//    
//    [UIView transitionWithView:sourceViewController.view
//                      duration:2.4
//                       options:UIViewAnimationOptionTransitionCrossDissolve
//                    animations:^{
//                        [sourceViewController.view addSubview:destinationViewController.view];
//                    }
//                    completion:^(BOOL finished){
//                        [destinationViewController.view removeFromSuperview];
//                        [sourceViewController presentViewController:destinationViewController animated:NO completion:nil];
//                    }];
//}

@end
