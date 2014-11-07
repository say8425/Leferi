//
//  FingraphAgent.h
//  FingraphAgent
//
//  Created by 광국 최 on 12. 6. 12..
//  Updated by 창제 정 on 14. 3. 21..
//  Copyright (주)티그레이프 All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FingraphAgent : NSObject  {

    NSString *sessionID;
    NSString *appkey;
    NSString *userId;
    NSString *gender;
    int age;
    long continueSession;
}

@property (retain, nonatomic) NSString *sessionID;
@property (retain, nonatomic) NSString *appkey;
@property (retain, nonatomic) NSString *userId;
@property (retain,nonatomic) NSString *gender;
@property int age;
@property long continueSession;

+ (FingraphAgent *)sharedFingraphAgent;
+ (void)releaseSharedFingraphAgent;

+ (void)onStartSession:(NSString *)apiKey;
+ (void)onEvent:(NSString *)eventKey;
+ (void)onTrace:(NSString *)traceKey stepNo:(NSUInteger)stepNo;
+ (void)onEndSession;
+ (void)onPageView;
+ (void)onPurchase:(NSString *)itemCode itemCount:(NSUInteger)itemCount chargeUnit:(NSString *)unit totalCharge:(float)totalCharge;

+ (void)setUserId:(NSString *)userId;
+ (void)setAge:(int)age;
+ (void)setGender:(NSString *)gender;
+ (void)setContinueSession:(long)continueSession;

@end
