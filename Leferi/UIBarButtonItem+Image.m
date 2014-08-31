//
//  UIBarButtonItem+Image.m
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 6..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "UIBarButtonItem+Image.h"

@implementation UIBarButtonItem (Image)

+ (UIBarButtonItem *)customBackButtonWithImage:(UIImage *)image Target:(id)target action:(SEL)action {
    UIImage *buttonImage = image;

    //create the button and assign the image
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];

    //set the frame of the button to the size of the image (see note below)
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);

    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    //create a UIBarButtonItem with the button as a custom view
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return customBarItem;
}

@end
