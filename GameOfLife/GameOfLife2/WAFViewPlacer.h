//
//  WAFViewPlacer.h
//  GameOfLife
//
//  Created by William Fiset on 2014-06-14.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WAFTouchEventHandler.h"

@class UIView;
@class UISegmentedControl;
@class UIButton, NSArray;
@class NSDictionary;


// Views
UISegmentedControl *sizeSegment;
UISegmentedControl *speedSegment;
UISegmentedControl *modeSegment;
UIButton *randomButton;

// Constant View Properties
static NSDictionary *segmentSpeeds;
static NSDictionary *gameModes;
static NSArray *segmentSizes;



@interface WAFViewPlacer : NSObject

+ (void) placeMainSceneViews: (UIView*) view;

// Allows you to get the values on the segments
+ (double) segmentLoopSpeed;
+ (int) segmentSizeValue;
+ (BOOL) isStartButtonSelected;

@end











