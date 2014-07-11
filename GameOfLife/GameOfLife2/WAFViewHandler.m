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

#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define VERTICAL_SPACING 7

static short BELOW_HEIGHT = 0;
static short UPPER_HEIGHT = 0;
static short TEXT_HEIGHT = 0;
static short FONT_SIZE = 0;
static short SEGMENT_WIDTH = 0;
static short LEFT_SEGMENT_POS = 0;
static short RIGHT_SEGMENT_POS = 0;


// Private Variables
@interface WAFViewHandler ()
+ (void) initVariables: (UIView*) view;
@end


@implementation WAFViewHandler

/*
 * Creates all the objects that will be put on the screen
 * Creates all the constants (Different for iPad or iPhone)
 */
+ (void) initVariables: (UIView*) view {
   
    
    if (IPAD) {
        
        SEGMENT_WIDTH = view.frame.size.width * 0.25;
        TEXT_HEIGHT = 27;
        
        LEFT_SEGMENT_POS = view.frame.size.width * 0.10;
        RIGHT_SEGMENT_POS = view.frame.size.width * 0.65;
        
        BELOW_HEIGHT = view.frame.size.height - 35;
        UPPER_HEIGHT = view.frame.size.height - 85;
        
        segmentSizes =  @[ @"24", @"32", @"48", @"64", @"96", @"128" ];
        FONT_SIZE = 14;
        
    // IPhone or IPod
    } else {

        SEGMENT_WIDTH = 140;
        TEXT_HEIGHT = 25;
        const int SIDE_SPACING = (view.frame.size.width - ( 2 * SEGMENT_WIDTH )) / 2;

        BELOW_HEIGHT = view.frame.size.height - 35;
        UPPER_HEIGHT = view.frame.size.height - 75;
        
        LEFT_SEGMENT_POS = SIDE_SPACING / 2;
        RIGHT_SEGMENT_POS = SEGMENT_WIDTH + LEFT_SEGMENT_POS * 3;

        segmentSizes =  @[ @"10", @"16", @"20", @"32", @"40", @"64" ];
        FONT_SIZE = 10;
    }

    
    justChangedTileSize = NO;
    
    // Creates all the menu item text and constants
    segmentSpeeds = [NSDictionary dictionaryWithObjects: @[ @.35, @0.75, @0.0 ] forKeys: @[ @"Slow", @"Med", @"Fast" ] ];
    gameModes = @{ @"Play" : @true , @"Stop" : @false };
    blockAppearanceModes = @[ @"Random" , @"Empty" ];
    
    // Creates all the View Objects
    blockAppearanceSegment = [[UISegmentedControl alloc] initWithItems: blockAppearanceModes];
    modeSegment =  [[UISegmentedControl alloc] initWithItems: [gameModes allKeys] ];
    sizeSegment =  [[UISegmentedControl alloc] initWithItems: segmentSizes];
    speedSegment = [[UISegmentedControl alloc] initWithItems: [segmentSpeeds allKeys] ];

}


/* Places all the menu objects on the screen (Labels, Sliders, buttons... ) */
+ (void) placeMainSceneViews:(UIView *) view {
    
    [self initVariables: view];
    
  /* SegmentControl */

    
    [blockAppearanceSegment setFrame: CGRectMake(LEFT_SEGMENT_POS, UPPER_HEIGHT , SEGMENT_WIDTH, TEXT_HEIGHT)];
    [blockAppearanceSegment setTintColor: [UIColor whiteColor]];
    [blockAppearanceSegment setSelectedSegmentIndex: 0]; // Random
    [blockAppearanceSegment addTarget: [WAFTouchEventHandler class]
                               action: @selector(random_empty_changed:)
                     forControlEvents: UIControlEventValueChanged];
    
    
    [modeSegment setFrame: CGRectMake( LEFT_SEGMENT_POS, BELOW_HEIGHT , SEGMENT_WIDTH, TEXT_HEIGHT)];
    [modeSegment setTintColor: [UIColor whiteColor]];
    [modeSegment setSelectedSegmentIndex: 0]; // Stop
    
    
    [sizeSegment setFrame: CGRectMake( RIGHT_SEGMENT_POS , UPPER_HEIGHT , SEGMENT_WIDTH, TEXT_HEIGHT)];
    [sizeSegment setTintColor: [UIColor whiteColor]];
    [sizeSegment setSelectedSegmentIndex: 2]; // tileSize of 20 || 48
    [sizeSegment addTarget: [WAFTouchEventHandler class]
                    action: @selector(tileSizeChanged:)
          forControlEvents: UIControlEventValueChanged];
    
    
    [speedSegment setFrame: CGRectMake(RIGHT_SEGMENT_POS , BELOW_HEIGHT , SEGMENT_WIDTH, TEXT_HEIGHT)];
    [speedSegment setTintColor: [UIColor whiteColor]];
    [speedSegment setSelectedSegmentIndex: 2]; // Fast (0 pause)
    [speedSegment addTarget: [WAFTouchEventHandler class]
                     action: @selector(loopSpeedChanged:)
           forControlEvents: UIControlEventValueChanged];
    
   
    
  /* Labels */
    
    
    // Reproduction Speed
    UILabel *loopSpeedLabel = [[UILabel alloc] initWithFrame:
                           CGRectMake(speedSegment.frame.origin.x + 30,
                                      speedSegment.frame.origin.y - speedSegment.frame.size.height - VERTICAL_SPACING,
                                      SEGMENT_WIDTH, 50)];
    
    
    [loopSpeedLabel setValue: @"Reproduction Speed" forKey: @"text"];
    [loopSpeedLabel setFont: [UIFont fontWithName: @"Helvetica" size: FONT_SIZE]];
    [loopSpeedLabel setTextColor: [UIColor whiteColor]];

    
    
    // Critter Size
    UILabel *tileSizeLabel = [[UILabel alloc] initWithFrame:
                          CGRectMake(sizeSegment.frame.origin.x + 57,
                                     sizeSegment.frame.origin.y - sizeSegment.frame.size.height - VERTICAL_SPACING,
                                     SEGMENT_WIDTH, 50)];
    

    
    [tileSizeLabel setValue: @"Critter Size" forKey: @"text"];
    [tileSizeLabel setFont: [UIFont fontWithName: @"Helvetica" size: FONT_SIZE]];
    [tileSizeLabel setTextColor: [UIColor whiteColor]];

    
    
    // Mode Label
    UILabel *player_stop_label = [[UILabel alloc] initWithFrame:
                          CGRectMake(modeSegment.frame.origin.x + 50,
                                     modeSegment.frame.origin.y - modeSegment.frame.size.height - VERTICAL_SPACING,
                                     SEGMENT_WIDTH, 50)];
    
    [player_stop_label setValue: @"Mode" forKey: @"text"];
    [player_stop_label setFont: [UIFont fontWithName: @"Helvetica" size: FONT_SIZE]];
    [player_stop_label setTextColor: [UIColor whiteColor]];
    
    // startMode Label
    UILabel *random_empty_label = [[UILabel alloc] initWithFrame:
                                  CGRectMake(blockAppearanceSegment.frame.origin.x + 30,
                                             blockAppearanceSegment.frame.origin.y - blockAppearanceSegment.frame.size.height - VERTICAL_SPACING,
                                             SEGMENT_WIDTH, 50)];
    
    [random_empty_label setValue: @"Starting Mode" forKey: @"text"];
    [random_empty_label setFont: [UIFont fontWithName: @"Helvetica" size: FONT_SIZE]];
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

+ (BOOL) randomButtonIsSelected {
    
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













