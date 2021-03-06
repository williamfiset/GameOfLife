//
//  WAFTouchEventHandler.h
//  Game Of Life
//
//  Created by William Fiset on 2014-06-20.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UISegmentedControl;

BOOL clickedToChangeMode;
BOOL justChangedTileSize;

@interface WAFTouchEventHandler : NSObject

+ (void) tileSizeChanged: (UISegmentedControl  *) selector;
+ (void) stop_play_changed: (UISegmentedControl  *) selector;
+ (void) loopSpeedChanged: (UISegmentedControl *) selector;
+ (void) random_empty_changed: (UISegmentedControl *) selector;


@end
