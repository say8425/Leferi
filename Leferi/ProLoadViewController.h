//
//  ProLoadViewController.h
//  Leferi
//
//  Created by Cheon Park on 2014. 10. 10..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "ViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProLoadViewController : UIViewController{
    NSMutableDictionary *pathDictionary;
}

@property (strong, nonatomic) IBOutlet UILabel *connectStatus;

@end
