//
//  EAIntroView.h
//
//  Copyright (c) 2013-2014 Evgeny Aleksandrov. License: MIT.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EAIntroPageNP.h"

#define skipBtnFinishAlpha 1.0f

enum EAIntroViewTags {
    kTitleLabelTag = 1,
    kDescLabelTag,
    kTitleImageViewTag
};

@class EAIntroViewNP;

@protocol EAIntroDelegate
@optional
- (void)introDidFinish:(EAIntroViewNP *)introView;
- (void)intro:(EAIntroViewNP *)introView pageAppeared:(EAIntroPageNP *)page withIndex:(NSInteger)pageIndex;
- (void)intro:(EAIntroViewNP *)introView pageStartScrolling:(EAIntroPageNP *)page withIndex:(NSInteger)pageIndex;
- (void)intro:(EAIntroViewNP *)introView pageEndScrolling:(EAIntroPageNP *)page withIndex:(NSInteger)pageIndex;
@end

@interface EAIntroViewNP : UIView <UIScrollViewDelegate>

@property (nonatomic, weak) id<EAIntroDelegate> delegate;

// titleView Y position - from top of the screen
// pageControl Y position - from bottom of the screen
@property (nonatomic, assign) bool swipeToExit;
@property (nonatomic, assign) bool tapToNext;
@property (nonatomic, assign) bool hideOffscreenPages;
@property (nonatomic, assign) bool easeOutCrossDisolves;
@property (nonatomic, assign) bool showSkipButtonOnlyOnLastPage;
@property (nonatomic, assign) bool useMotionEffects;
@property (nonatomic, assign) CGFloat motionEffectsRelativeValue;
@property (nonatomic, strong) UIImage *bgImage;
@property (nonatomic, assign) UIViewContentMode bgViewContentMode;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, assign) CGFloat titleViewY;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) CGFloat pageControlY;
@property (nonatomic, strong) UIButton *skipButton;
@property (nonatomic, assign) float judgeLastPage;
@property (nonatomic, assign) BOOL judgeSkipBUtton;
@property (nonatomic, assign) BOOL judgeSkipButtonSeen;
@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, assign) NSInteger visiblePageIndex;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *pages;

- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pagesArray;

- (void)showInView:(UIView *)view animateDuration:(CGFloat)duration;
- (void)hideWithFadeOutDuration:(CGFloat)duration;
- (void)hidePageControl;
- (void)setCurrentPageIndex:(NSInteger)currentPageIndex;
- (void)setCurrentPageIndex:(NSInteger)currentPageIndex animated:(BOOL)animated;


@end