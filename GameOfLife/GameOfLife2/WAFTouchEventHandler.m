//
//  WAFTouchEventHandler.m
//  Game Of Life
//
//  Created by William Fiset on 2014-06-20.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "WAFTouchEventHandler.h"
#import "WAFViewPlacer.h"
#import <Foundation/Foundation.h>
#import "GameOfLife2-Bridging-Header.h"


@implementation WAFTouchEventHandler


+ (void) tileSizeChanged: (UISegmentedControl *) tileSizeSelector {
    
    if ( [WAFViewPlacer isStartButtonSelected] ) {
        
        [modeSegment setSelectedSegmentIndex: 0]; // Stop
        justChangedTileSize = YES; // This makes sure you skip the pause at the end of the loop
    }
    
}

+ (void) gameModeChanged:(UISegmentedControl *) selector {
    
}

+ (void) loopSpeedChanged:(UISegmentedControl *) selector {
    
}

+ (void) randomizeCells {
    
    if ( [WAFViewPlacer isStartButtonSelected] ) {
        [modeSegment setSelectedSegmentIndex: 0]; // Stop
    }
    
    timeToRandomizeGrid = YES;
}


@end



























