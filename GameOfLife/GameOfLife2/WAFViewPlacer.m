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

#define SLIDER_WIDTH 165
#define VERTICAL_SPACING 7

// static
static UISegmentedControl *sizeSegment;
static UISegmentedControl *speedSegment;
static UISegmentedControl *modeSegment;
static UIButton *randomButton;
static UIButton *createButton;


// Global
const NSDictionary *segmentSpeeds;
NSArray *segmentSizes;


// Private Variables
@interface WAFViewPlacer ()

@end


@implementation WAFViewPlacer


/* Places all the menu objects on the screen (Labels, Sliders, buttons... ) */
+ (void) placeMainSceneViews:(UIView *) view {

    segmentSpeeds = [NSDictionary dictionaryWithObjects: @[ @1.5, @0.75, @0 ] forKeys: @[ @"Slow", @"Med", @"Fast" ] ];
    segmentSizes =  @[ @"12", @"16", @"20", @"24", @"32", @"40"] ;
    
  /* Buttons */
    
    randomButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [randomButton setFrame: CGRectMake( 10, view.frame.size.height - 100, 150, 60)];
    [randomButton setTitle: @"Randomize" forState: UIControlStateNormal];
    [randomButton.titleLabel setFont:[UIFont fontWithName: @"Helvetica-Bold" size:20.5]];
    
//    createButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
//    [createButton setFrame: CGRectMake( 35, view.frame.size.height - 80, 100, 40)];
//    [createButton setTitle: @"Create" forState: UIControlStateNormal];
//    [createButton.titleLabel setFont:[UIFont fontWithName: @"Helvetica-Bold" size:14.5]];
    
    
  /* SegmentControl */
    
    
    modeSegment = [[UISegmentedControl alloc] initWithItems: @[ @"Stop" , @"Start" ]];
    [modeSegment setFrame: CGRectMake( 20, view.frame.size.height - 35 , 120, 25)];
    [modeSegment setTintColor: [UIColor whiteColor]];
    [modeSegment setSelectedSegmentIndex: 0];
    
    
    sizeSegment = [[UISegmentedControl alloc] initWithItems: segmentSizes];
    [sizeSegment setFrame: CGRectMake(view.frame.size.width * 0.5 , view.frame.size.height - 75 , 150, 25)];
    [sizeSegment setTintColor: [UIColor whiteColor]];
    [sizeSegment setSelectedSegmentIndex: 2]; // 20
    
    
    
    speedSegment = [[UISegmentedControl alloc] initWithItems: [segmentSpeeds allKeys] ];
    [speedSegment setFrame: CGRectMake(view.frame.size.width * 0.5 , view.frame.size.height - 35 , 150, 25)];
    [speedSegment setTintColor: [UIColor whiteColor]];
    [speedSegment setSelectedSegmentIndex: 2]; // Fast

    
   
    
  /* Labels */
    
    
    // Reproduction Speed
    UILabel *speedLabel = [[UILabel alloc] initWithFrame:
                           CGRectMake(speedSegment.frame.origin.x + 30, speedSegment.frame.origin.y - sizeSegment.frame.size.height - VERTICAL_SPACING, 100, 50)];
    
    [speedLabel setValue: @"Reproduction Speed" forKey: @"text"];
    [speedLabel setFont: [UIFont fontWithName: @"Helvetica" size: 10]];
    
    
    // Critter Size
    UILabel *sizeLabel = [[UILabel alloc] initWithFrame:
                          CGRectMake(sizeSegment.frame.origin.x + 57, sizeSegment.frame.origin.y - sizeSegment.frame.size.height - VERTICAL_SPACING, 100, 50)];
    
    [sizeLabel setValue: @"Critter Size" forKey: @"text"];
    [sizeLabel setFont: [UIFont fontWithName: @"Helvetica" size: 10]];
    
    
    
    // Play Mode
    UILabel *playModeLabel = [[UILabel alloc] initWithFrame:
                          CGRectMake(modeSegment.frame.origin.x + 40, modeSegment.frame.origin.y - sizeSegment.frame.size.height - VERTICAL_SPACING, 100, 50)];
    
    [playModeLabel setValue: @"Play Mode" forKey: @"text"];
    [playModeLabel setFont: [UIFont fontWithName: @"Helvetica" size: 10]];
    
    
    
    
    
  /* Place Things on Screen */
    
    
    // Buttons
    [view addSubview: randomButton];
    [view addSubview: createButton];
    
    // Control Segments
    [view addSubview: speedSegment];
    [view addSubview: sizeSegment];
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

+ (int) segmentMode {
    return 0;
}


@end























