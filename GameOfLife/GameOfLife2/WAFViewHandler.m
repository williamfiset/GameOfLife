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
#import <sys/sysctl.h>

#define VERTICAL_SPACING 7
#define LABEL_FONT @"Helvetica"
#define LABEL_POSITION_ABOVE_SEGMENT 47

static short BELOW_HEIGHT = 0;
static short UPPER_HEIGHT = 0;
static short TEXT_HEIGHT = 0;
static short FONT_SIZE = 0;
static short SEGMENT_WIDTH = 0;
static short LEFT_SEGMENT_POS = 0;
static short RIGHT_SEGMENT_POS = 0;


// Private Variables
@interface WAFViewHandler ()
+ (void) initVariables: (UIView*) view withVerticalLimit: (float*) verticalLimit ;
@end


@implementation WAFViewHandler


/*
 * Creates all the objects that will be put on the screen
 * Creates all the constants (Different for iPad or iPhone)
 */

+ (void) initVariables: (UIView*) view withVerticalLimit: (float*) verticalLimit {
   
    
    if (IS_IPAD) {
        
        // Adjusts the vertical tile limit specifically for the IPad
        *verticalLimit = 100;
        
        SEGMENT_WIDTH = view.frame.size.width * 0.40;
        TEXT_HEIGHT = 27;
        
        const int SIDE_SPACING = (view.frame.size.width - ( 2 * SEGMENT_WIDTH )) / 2;
        
        LEFT_SEGMENT_POS = SIDE_SPACING / 2;
        RIGHT_SEGMENT_POS = SEGMENT_WIDTH + LEFT_SEGMENT_POS * 3;
        
        BELOW_HEIGHT = view.frame.size.height - 38;
        UPPER_HEIGHT = view.frame.size.height - 86;
        
        segmentSizes =  @[ @"24", @"32", @"48", @"64", @"96", @"128" ];
        FONT_SIZE = 15;

    // IPhone or IPod
    } else if (IS_IPHONE) {
        
        
        if (IS_IPHONE6) {
            
            SEGMENT_WIDTH = 160;

            // Based on 375 (1, 3, 5, 15, 25, 75, 125)
            segmentSizes =  @[ @"15", @"25", @"34", @"53", @"75" ];
        
        } else if (IS_IPHONE6_PLUS) {
            
            SEGMENT_WIDTH = 160;
            
            // Based on 414 (1, 2, 3, 6, 9, 18, 23, 46, 69, 138, 207)
            segmentSizes =  @[ @"18", @"23" , @"34", @"46", @"69" ];
        
        // IPhone models 5 and below
        } else {
            
            SEGMENT_WIDTH = 140;
            
            segmentSizes =  @[ @"16", @"20", @"32", @"40", @"64" ]; 
            
        }
        
        TEXT_HEIGHT = 25;
        const int SIDE_SPACING = (view.frame.size.width - ( 2 * SEGMENT_WIDTH )) / 2;
        
        BELOW_HEIGHT = view.frame.size.height - 35;
        UPPER_HEIGHT = view.frame.size.height - 75;
        
        LEFT_SEGMENT_POS = SIDE_SPACING / 2;
        RIGHT_SEGMENT_POS = SEGMENT_WIDTH + LEFT_SEGMENT_POS * 3;

        FONT_SIZE = 14;
        
    }

    
    justChangedTileSize = NO;
    
    // TIME ENTERED IN DICTIONARY GETS DOUBLED BECAUSE OF ISSUE 17! THe real pause times are: @[ @.75, @0.35, @0.0 ]
    segmentSpeeds = [NSDictionary dictionaryWithObjects: @[ @0.6, @0.3, @0.0 ] forKeys: @[ @"Slow", @"Med", @"Fast" ] ];
    gameModes = @{ @"Play" : @true , @"Stop" : @false };
    blockAppearanceModes = @[ @"Random" , @"Empty" ];
    
    // Creates all the View Objects
    blockAppearanceSegment = [[UISegmentedControl alloc] initWithItems: blockAppearanceModes];
    modeSegment =  [[UISegmentedControl alloc] initWithItems: [gameModes allKeys] ];
    sizeSegment =  [[UISegmentedControl alloc] initWithItems: segmentSizes];
    speedSegment = [[UISegmentedControl alloc] initWithItems: [segmentSpeeds allKeys] ];

}


/* Places all the menu objects on the screen (Labels, Sliders, buttons... ) */
+ (void) placeMainSceneViews:(UIView *) view withVerticalLimit: (float*) verticalLimit {
    
    [self initVariables:view withVerticalLimit: verticalLimit];

    
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
    
    // Label Text
    NSString *reproductionSpeed = @"Reproduction Speed";
    NSString *critterSize = @"Citter Size";
    NSString *modeLabel = @"Mode";
    NSString *startingMode = @"Starting Mode";
    
    CGSize reproductionSpeedSize = [reproductionSpeed sizeWithAttributes: @{ NSFontAttributeName: [UIFont fontWithName: LABEL_FONT size:FONT_SIZE] }];
    CGSize critterSizeCGSize = [critterSize sizeWithAttributes: @{ NSFontAttributeName: [UIFont fontWithName: LABEL_FONT size:FONT_SIZE] }];
    CGSize modeLabelSize = [modeLabel sizeWithAttributes: @{ NSFontAttributeName: [UIFont fontWithName: LABEL_FONT size:FONT_SIZE] }];
    CGSize startingModeSize = [startingMode sizeWithAttributes: @{ NSFontAttributeName: [UIFont fontWithName: LABEL_FONT size:FONT_SIZE] }];
    
    const short sStartingMode = (blockAppearanceSegment.frame.size.width - startingModeSize.width) / 2;
    const short sCritterSize = (sizeSegment.frame.size.width - critterSizeCGSize.width) / 2;
    const short sMode = (modeSegment.frame.size.width - modeLabelSize.width) / 2;
    const short sReproductionSpeed = (speedSegment.frame.size.width - reproductionSpeedSize.width) / 2;
    
    

    
    // Reproduction Speed
    UILabel *loopSpeedLabel = [[UILabel alloc] initWithFrame:
                           CGRectMake(speedSegment.frame.origin.x + sReproductionSpeed,
                                      speedSegment.frame.origin.y - speedSegment.frame.size.height - VERTICAL_SPACING ,
                                      SEGMENT_WIDTH, LABEL_POSITION_ABOVE_SEGMENT)];
    
    // Critter Size
    UILabel *tileSizeLabel = [[UILabel alloc] initWithFrame:
                          CGRectMake(sizeSegment.frame.origin.x + sCritterSize,
                                     sizeSegment.frame.origin.y - sizeSegment.frame.size.height - VERTICAL_SPACING,
                                     SEGMENT_WIDTH , LABEL_POSITION_ABOVE_SEGMENT)];
    
    // Mode Label
    UILabel *player_stop_label = [[UILabel alloc] initWithFrame:
                          CGRectMake(modeSegment.frame.origin.x + sMode,
                                     modeSegment.frame.origin.y - modeSegment.frame.size.height - VERTICAL_SPACING,
                                     SEGMENT_WIDTH, LABEL_POSITION_ABOVE_SEGMENT)];
    
    // startMode Label
    UILabel *random_empty_label = [[UILabel alloc] initWithFrame:
                                  CGRectMake(blockAppearanceSegment.frame.origin.x + sStartingMode,
                                             blockAppearanceSegment.frame.origin.y - blockAppearanceSegment.frame.size.height - VERTICAL_SPACING,
                                             SEGMENT_WIDTH, LABEL_POSITION_ABOVE_SEGMENT)];

    
  /* Set Label Attributes */
   
    [loopSpeedLabel setValue: @"Reproduction Speed" forKey: @"text"];
    [loopSpeedLabel setFont: [UIFont fontWithName: LABEL_FONT size: FONT_SIZE]];
    [loopSpeedLabel setTextColor: [UIColor whiteColor]];
    
    [tileSizeLabel setValue: @"Critter Size" forKey: @"text"];
    [tileSizeLabel setFont: [UIFont fontWithName: LABEL_FONT size: FONT_SIZE]];
    [tileSizeLabel setTextColor: [UIColor whiteColor]];
    
    [player_stop_label setValue: @"Mode" forKey: @"text"];
    [player_stop_label setFont: [UIFont fontWithName: LABEL_FONT size: FONT_SIZE]];
    [player_stop_label setTextColor: [UIColor whiteColor]];
    
    [random_empty_label setValue: @"Starting Mode" forKey: @"text"];
    [random_empty_label setFont: [UIFont fontWithName: LABEL_FONT size: FONT_SIZE]];
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













