//
//  WAFViewHandler.m
//  GameOfLife
//
//  Created by William Fiset on 2014-06-14.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//



@import UIKit;
@import Foundation;

#import "WAFViewHandler.h"
#import "WAFTouchEventHandler.h"

#define SLIDER_WIDTH 165
#define VERTICAL_SPACING 7
#define SIDE_SPACING 10
#define BELOW_HEIGHT view.frame.size.height - 35
#define UPPER_HEIGHT view.frame.size.height - 75
#define TEXT_HEIGHT 25
#define LEFT_SEGMENT_SIZE 125
#define RIGHT_SEGMENT_SIZE 150



// Private Variables
@interface WAFViewHandler ()
+ (void) initVariables;
@end


@implementation WAFViewHandler


+ (void) initVariables {
    
    justChangedTileSize = NO;
    
    // Creates all the menu item text and constants
    segmentSpeeds = [NSDictionary dictionaryWithObjects: @[ @1.5, @0.75, @0 ] forKeys: @[ @"Slow", @"Med", @"Fast" ] ];
    segmentSizes =  @[ @"10", @"16", @"20", @"32", @"40", @"64" ];
    gameModes = @{ @"Play" : @true , @"Stop" : @false };
    blockAppearanceModes = @[ @"Random" , @"Empty" ];
    
    // Creates all the View Objects
    blockAppearanceSegment = [[UISegmentedControl alloc] initWithItems: blockAppearanceModes];
    modeSegment = [[UISegmentedControl alloc] initWithItems: [gameModes allKeys] ];
    sizeSegment = [[UISegmentedControl alloc] initWithItems: segmentSizes];
    speedSegment = [[UISegmentedControl alloc] initWithItems: [segmentSpeeds allKeys] ];

}


/* Places all the menu objects on the screen (Labels, Sliders, buttons... ) */
+ (void) placeMainSceneViews:(UIView *) view {
    
    [self initVariables];
    
  /* SegmentControl */

    
    [blockAppearanceSegment setFrame: CGRectMake(SIDE_SPACING, UPPER_HEIGHT , LEFT_SEGMENT_SIZE, TEXT_HEIGHT)];
    [blockAppearanceSegment setTintColor: [UIColor whiteColor]];
    [blockAppearanceSegment setSelectedSegmentIndex: 0]; // Random
    
    [modeSegment setFrame: CGRectMake( SIDE_SPACING, BELOW_HEIGHT , LEFT_SEGMENT_SIZE, TEXT_HEIGHT)];
    [modeSegment setTintColor: [UIColor whiteColor]];
    [modeSegment setSelectedSegmentIndex: 0]; // Stop
    
    
    [sizeSegment setFrame: CGRectMake(view.frame.size.width * 0.5 , UPPER_HEIGHT , RIGHT_SEGMENT_SIZE, TEXT_HEIGHT)];
    [sizeSegment setTintColor: [UIColor whiteColor]];
    [sizeSegment setSelectedSegmentIndex: 2]; // tileSize of 20
    [sizeSegment addTarget: [WAFTouchEventHandler class]
                    action: @selector(tileSizeChanged:)
          forControlEvents: UIControlEventValueChanged];
    
    
    [speedSegment setFrame: CGRectMake(view.frame.size.width * 0.5 , BELOW_HEIGHT , RIGHT_SEGMENT_SIZE, TEXT_HEIGHT)];
    [speedSegment setTintColor: [UIColor whiteColor]];
    [speedSegment setSelectedSegmentIndex: 2]; // Fast (0 pause)

    
   
    
  /* Labels */
    
    
    // Reproduction Speed
    UILabel *loopSpeedLabel = [[UILabel alloc] initWithFrame:
                           CGRectMake(speedSegment.frame.origin.x + 30, speedSegment.frame.origin.y - speedSegment.frame.size.height - VERTICAL_SPACING, 100, 50)];
    
    [loopSpeedLabel setValue: @"Reproduction Speed" forKey: @"text"];
    [loopSpeedLabel setFont: [UIFont fontWithName: @"Helvetica" size: 10]];
    [loopSpeedLabel setTextColor: [UIColor whiteColor]];

    
    
    // Critter Size
    UILabel *tileSizeLabel = [[UILabel alloc] initWithFrame:
                          CGRectMake(sizeSegment.frame.origin.x + 57, sizeSegment.frame.origin.y - sizeSegment.frame.size.height - VERTICAL_SPACING, 100, 50)];
    
    [tileSizeLabel setValue: @"Critter Size" forKey: @"text"];
    [tileSizeLabel setFont: [UIFont fontWithName: @"Helvetica" size: 10]];
    [tileSizeLabel setTextColor: [UIColor whiteColor]];

    
    
    // Mode Label
    UILabel *player_stop_label = [[UILabel alloc] initWithFrame:
                          CGRectMake(modeSegment.frame.origin.x + 50, modeSegment.frame.origin.y - modeSegment.frame.size.height - VERTICAL_SPACING, 100, 50)];
    
    [player_stop_label setValue: @"Mode" forKey: @"text"];
    [player_stop_label setFont: [UIFont fontWithName: @"Helvetica" size: 10]];
    [player_stop_label setTextColor: [UIColor whiteColor]];
    
    // startMode Label
    
    UILabel *random_empty_label = [[UILabel alloc] initWithFrame:
                                  CGRectMake(blockAppearanceSegment.frame.origin.x + 30, blockAppearanceSegment.frame.origin.y - blockAppearanceSegment.frame.size.height - VERTICAL_SPACING, 100, 50)];
    
    [random_empty_label setValue: @"Starting Mode" forKey: @"text"];
    [random_empty_label setFont: [UIFont fontWithName: @"Helvetica" size: 10]];
    [random_empty_label setTextColor: [UIColor whiteColor]];
    
    
    
  /* Place Things on Screen */
    
    // Control Segments
    [view addSubview: sizeSegment];
    [view addSubview: speedSegment];
    [view addSubview: modeSegment];
    [view addSubview: blockAppearanceSegment];
    
    
    // Labels
    [view addSubview: tileSizeLabel];
    [view addSubview: loopSpeedLabel];
    [view addSubview: player_stop_label];
    [view addSubview: random_empty_label];
    
}


+ (double) segmentLoopSpeed {

    NSString *key = [speedSegment titleForSegmentAtIndex: speedSegment.selectedSegmentIndex];
    return [segmentSpeeds[key] doubleValue];

}

+ (int) segmentSizeValue {
    return [segmentSizes[sizeSegment.selectedSegmentIndex] intValue] ;
}

+ (BOOL) playButtonIsSelected {
    return [gameModes[ [modeSegment titleForSegmentAtIndex: modeSegment.selectedSegmentIndex ] ] boolValue] ;
}

+ (BOOL) randomGridIsSelected {
    
    // Tests to see if Gird is set to be random (index 0)
    return [blockAppearanceSegment selectedSegmentIndex] == 0;
}


+ (void) setPlayModeToStop: (BOOL) predicate {

    if (predicate) {
        [modeSegment setSelectedSegmentIndex: 0];
    } else {
        [modeSegment setSelectedSegmentIndex: 1];
    }
    
}


@end























