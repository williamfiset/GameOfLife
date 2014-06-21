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


@implementation WAFTouchEventHandler


+ (void) tileSizeChanged: (UISegmentedControl *) tileSizeSelector {
    
    if ( [WAFViewPlacer isStartButtonSelected] ) {

        
        [modeSegment setSelectedSegmentIndex: 0];
        
    }
    
}

+ (void) gameModeChanged:(UISegmentedControl *) selector {
    
}

+ (void) loopSpeedChanged:(UISegmentedControl *) selector {
    
}



@end
