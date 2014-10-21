//
//  TransAlphaSegue.m
//  Leferi
//
//  Created by Cheon Park on 2014. 9. 2..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "TransAlphaSegue.h"

@implementation TransAlphaSegue

- (void) perform {
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    // Add the destination view as a subview, temporarily
    [sourceViewController.view addSubview:destinationViewController.view];
    
    // Transformation start scale
    destinationViewController.view.alpha = 0.0f;
    
    // Store original centre point of the destination view
//    CGPoint originalCenter = destinationViewController.view.center;
    // Set center to start point of the button
//    destinationViewController.view.center = self.originatingPoint;
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // Grow!
                         sourceViewController.navigationController.navigationBar.alpha = 0.0f;
                         destinationViewController.view.alpha = 1.0f;
                     }
                     completion:^(BOOL finished){
                         [destinationViewController.view removeFromSuperview]; // remove from temp super view
                         [sourceViewController presentViewController:destinationViewController animated:NO completion:NULL]; // present VC
                     }];
}

//
//- (void)perform {
//    UIViewController *sourceViewController = self.sourceViewController;
//    UIViewController *destinationViewController = self.destinationViewController;
//    
//    // Add the destination view as a subview, temporarily
//    [sourceViewController.view addSubview:destinationViewController.view];
//    
//    destinationViewController.view.alpha = 0.0f;
//    CGAffineTransform
//    
//    // Transformation start scale
//    [sourceViewController.navigationController.navigationBar setAlpha:0.0];
//    [destinationViewController.view setAlpha:0.0];
//    
//    [UIView animateWithDuration:0.5
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut
//                     animations:^{
//                         [sourceViewController.navigationController.navigationBar setAlpha:1.0];
//                         [destinationViewController.view setAlpha:1.0];
//                     } completion:^(BOOL finished){
//                         [destinationViewController.view removeFromSuperview];
//                         [sourceViewController presentViewController:destinationViewController animated:NO completion:NULL]; // present VC
//                     }];
//}





@end
