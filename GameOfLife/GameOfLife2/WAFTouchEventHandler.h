//
//  WAFTouchEventHandler.h
//  Game Of Life
//
//  Created by William Fiset on 2014-06-20.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UISegmentedControl;

@interface WAFTouchEventHandler : NSObject

+ (void) tileSizeChanged: (UISegmentedControl  *) selector;
+ (void) gameModeChanged: (UISegmentedControl  *) selector;
+ (void) loopSpeedChanged: (UISegmentedControl *) selector;

@end
