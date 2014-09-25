//
//  WAFViewHandler.h
//  GameOfLife
//
//  Created by William Fiset on 2014-06-14.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WAFTouchEventHandler.h"

#define IS_IPHONE       UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad
#define IS_IPHONE4      ([[UIScreen mainScreen] bounds].size.width == 320 && [[UIScreen mainScreen] bounds].size.height == 480)
#define IS_IPHONE5      ([[UIScreen mainScreen] bounds].size.width == 320 && [[UIScreen mainScreen] bounds].size.height == 568)
#define IS_IPHONE6      ([[UIScreen mainScreen] bounds].size.width == 375 && [[UIScreen mainScreen] bounds].size.height == 667)
#define IS_IPHONE6_PLUS ([[UIScreen mainScreen] bounds].size.width == 414 && [[UIScreen mainScreen] bounds].size.height == 736)
#define IS_IPAD         UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

@class UIView;
@class UISegmentedControl;
@class UIButton, NSArray;
@class NSDictionary;


// Views
UISegmentedControl *sizeSegment;
UISegmentedControl *speedSegment;
UISegmentedControl *modeSegment;
UISegmentedControl *blockAppearanceSegment;

// Constant View Properties
static NSDictionary *segmentSpeeds;
static NSDictionary *gameModes;
static NSArray *blockAppearanceModes;
static NSArray *segmentSizes;

@interface WAFViewHandler : NSObject

+ (void) placeMainSceneViews: (UIView*) view withVerticalLimit: (float*) verticalLimit;

// Allows you to get the values on the segments
+ (double) segmentLoopSpeed;
+ (int) segmentSizeValue;
+ (BOOL) playButtonIsSelected;
+ (BOOL) randomButtonIsSelected;
+ (void) setPlayModeToStop: (BOOL) predicate;


@end











