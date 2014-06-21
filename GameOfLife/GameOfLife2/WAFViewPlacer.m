//
//  WAFViewPlacer.m
//  GameOfLife
//
//  Created by William Fiset on 2014-06-14.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//



@import UIKit;
@import Foundation;

#import "WAFViewPlacer.h"
#import "WAFTouchEventHandler.h"

#define SLIDER_WIDTH 165
#define VERTICAL_SPACING 7


// Private Variables
@interface WAFViewPlacer ()
+ (void) initVariables;
@end


@implementation WAFViewPlacer


+ (void) initVariables {
    
    // Creates all the menu item text and constants
    segmentSpeeds = [NSDictionary dictionaryWithObjects: @[ @1.5, @0.75, @0 ] forKeys: @[ @"Slow", @"Med", @"Fast" ] ];
    segmentSizes =  @[ @"10", @"16", @"20", @"32", @"40", @"64" ];
    gameModes = @{ @"Play" : @true , @"Stop" : @false };
    
    // Creates all the View Objects
    randomButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    modeSegment = [[UISegmentedControl alloc] initWithItems: [gameModes allKeys] ];
    sizeSegment = [[UISegmentedControl alloc] initWithItems: segmentSizes];
    speedSegment = [[UISegmentedControl alloc] initWithItems: [segmentSpeeds allKeys] ];

}


/* Places all the menu objects on the screen (Labels, Sliders, buttons... ) */
+ (void) placeMainSceneViews:(UIView *) view {
    
    [self initVariables];
    
  /* Buttons */
    
    [randomButton setFrame: CGRectMake( 10, view.frame.size.height - 100, 150, 60)];
    [randomButton setTitle: @"Randomize" forState: UIControlStateNormal];
    [randomButton.titleLabel setFont:[UIFont fontWithName: @"Helvetica-Bold" size:20.5]];

  /* SegmentControl */
    
    
    [modeSegment setFrame: CGRectMake( 20, view.frame.size.height - 35 , 120, 25)];
    [modeSegment setTintColor: [UIColor whiteColor]];
    [modeSegment setSelectedSegmentIndex: 0];
    
    
    [sizeSegment setFrame: CGRectMake(view.frame.size.width * 0.5 , view.frame.size.height - 75 , 150, 25)];
    [sizeSegment setTintColor: [UIColor whiteColor]];
    [sizeSegment setSelectedSegmentIndex: 2]; // tileSize of 20
    [sizeSegment addTarget: [WAFTouchEventHandler class]
                    action: @selector(tileSizeChanged:)
          forControlEvents: UIControlEventValueChanged];
    
    
    [speedSegment setFrame: CGRectMake(view.frame.size.width * 0.5 , view.frame.size.height - 35 , 150, 25)];
    [speedSegment setTintColor: [UIColor whiteColor]];
    [speedSegment setSelectedSegmentIndex: 2]; // Loop Speed of Fast (0 pause)

    
   
    
  /* Labels */
    
    
    // Reproduction Speed
    UILabel *speedLabel = [[UILabel alloc] initWithFrame:
                           CGRectMake(speedSegment.frame.origin.x + 30, speedSegment.frame.origin.y - speedSegment.frame.size.height - VERTICAL_SPACING, 100, 50)];
    
    [speedLabel setValue: @"Reproduction Speed" forKey: @"text"];
    [speedLabel setFont: [UIFont fontWithName: @"Helvetica" size: 10]];
    
    
    // Critter Size
    UILabel *sizeLabel = [[UILabel alloc] initWithFrame:
                          CGRectMake(sizeSegment.frame.origin.x + 57, sizeSegment.frame.origin.y - sizeSegment.frame.size.height - VERTICAL_SPACING, 100, 50)];
    
    [sizeLabel setValue: @"Critter Size" forKey: @"text"];
    [sizeLabel setFont: [UIFont fontWithName: @"Helvetica" size: 10]];
    
    
    
    // Mode Label
    UILabel *playModeLabel = [[UILabel alloc] initWithFrame:
                          CGRectMake(modeSegment.frame.origin.x + 50, modeSegment.frame.origin.y - modeSegment.frame.size.height - VERTICAL_SPACING, 100, 50)];
    
    [playModeLabel setValue: @"Mode" forKey: @"text"];
    [playModeLabel setFont: [UIFont fontWithName: @"Helvetica" size: 10]];
    
    
    
    
    
  /* Place Things on Screen */
    
    
    // Buttons
    [view addSubview: randomButton];
    
    // Control Segments
    [view addSubview: sizeSegment];
    [view addSubview: speedSegment];
    [view addSubview: modeSegment];
    
    // Labels
    [view addSubview: sizeLabel];
    [view addSubview: speedLabel];
    [view addSubview: playModeLabel];
    
 
}


+ (double) segmentLoopSpeed {

    NSString *key = [speedSegment titleForSegmentAtIndex: speedSegment.selectedSegmentIndex];
    return [segmentSpeeds[key] doubleValue];

}

+ (int) segmentSizeValue {
    return [segmentSizes[sizeSegment.selectedSegmentIndex] intValue] ;
}

+ (BOOL) isStartButtonSelected {
    return [gameModes[ [modeSegment titleForSegmentAtIndex: modeSegment.selectedSegmentIndex ] ] boolValue] ;
}


@end























