//
//  NewBeautiViewCollectionViewController.h
//  Leferi
//
//  Created by Cheon Park on 2014. 10. 28..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETCLibrary.h"
#import "InstagramKit.h"
#import "InstagramUser.h"
#import "InstagramMedia.h"
#import "BeautiCollectionViewCell.h"
#import "HeadCollectionViewCell.h"
#import "CSStickyHeaderFlowLayout.h"
#import "UIKit+AFNetworking.h"
#import "UIBarButtonItem+Image.h"
#import "UIViewController+ScrollingNavbar.h"

@interface NewBeautiViewCollectionViewController : UICollectionViewController {
    NSMutableArray *mediaArray;
    NSString *headString;
    NSString *loadString;
    NSString *tagString;
    BOOL login;
}

@property (strong, nonatomic) InstagramMedia * media;
@property (strong, nonatomic) InstagramPaginationInfo *currentPaginationInfo;

@end
