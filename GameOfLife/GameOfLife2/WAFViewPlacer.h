//
//  WAFViewPlacer.h
//  GameOfLife
//
//  Created by William Fiset on 2014-06-14.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//

@class UIView;
@class UISlider;

#import <Foundation/Foundation.h>

UISlider *sizeSlider = nil;
UISlider *speedSlider = nil;

@interface WAFViewPlacer : NSObject

+ (void) pressedReset;
+ (void) pressedStopOrResume;

+ (void) placeMainSceneViews: (UIView*) view;


@end
