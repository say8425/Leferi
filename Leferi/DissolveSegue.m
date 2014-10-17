//
//  DissolveSegue.m
//  Leferi
//
//  Created by Cheon Park on 2014. 10. 17..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "DissolveSegue.h"

@implementation DissolveSegue

- (void)perform
{
    CATransition *transition = [CATransition animation];
    transition.duration = 2.4;
    transition.type = kCATransitionFade;
    
    [[[[[self sourceViewController] view] window] layer] addAnimation:transition
                                                               forKey:kCATransitionFade];
    
    [[self sourceViewController]
     presentViewController:[self destinationViewController]
     animated:NO completion:NULL];
}

@end
