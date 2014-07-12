//
//  WAFTouchEventHandler.m
//  Game Of Life
//
//  Created by William Fiset on 2014-06-20.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "WAFTouchEventHandler.h"
#import "WAFViewHandler.h"
#import <Foundation/Foundation.h>
#import "GameOfLife2-Bridging-Header.h"


@implementation WAFTouchEventHandler


+ (void) tileSizeChanged: (UISegmentedControl *) tileSizeSelector {

    
    if ( [WAFViewHandler playButtonIsSelected] ) {
        
        // turning this on will activate the stop button when changing tile size
        // [WAFViewHandler setPlayModeToStop: YES];
        
        justChangedTileSize = YES; // This makes sure you skip the pause at the end of the loop
        
    }
    
}

+ (void) stop_play_changed:(UISegmentedControl *)selector {
    
}


+ (void) loopSpeedChanged:(UISegmentedControl *) selector {

}


+ (void) random_empty_changed:(UISegmentedControl *)selector {
    clickedToChangeMode = true;
}
    




@end



























