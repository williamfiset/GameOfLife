//
//  WAFViewPlacer.h
//  GameOfLife
//
//  Created by William Fiset on 2014-06-14.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//

@class UIView;

#import <Foundation/Foundation.h>

@interface WAFViewPlacer : NSObject


+ (void) placeMainSceneViews: (UIView*) view;

// Allows you to get the values on the segments
+ (double) segmentLoopSpeed;
+ (int) segmentSizeValue;
+ (BOOL) isStartButtonSelected;

@end

/*

 Random , create
 Start, Stop

*/