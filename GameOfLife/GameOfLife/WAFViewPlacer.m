//
//  WAFViewPlacer.m
//  GameOfLife
//
//  Created by William Fiset on 2014-06-14.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//


#define SLIDER_WIDTH 165

@import UIKit;
@import Foundation;
#import "WAFViewPlacer.h"

@implementation WAFViewPlacer

+ (void) placeMainSceneViews:(UIView *) view {
    
    
    /* Reset Button */
    
    UIButton *resetButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [resetButton addTarget:self action: @selector(pressedReset) forControlEvents:UIControlEventTouchUpInside];
    [resetButton setTitle:@"Reset" forState: UIControlStateNormal];
    resetButton.frame = CGRectMake(25.0, view.frame.size.height - 80, 80.0, 30.0);
    resetButton.backgroundColor = [UIColor colorWithRed: 0.196 green:0.3098 blue:0.52 alpha:1.0];
    [view addSubview:resetButton];
    
    
    /* Stop/Resume Button */
    
    UIButton *srButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [srButton addTarget:self action: @selector(pressedStopOrResume) forControlEvents:UIControlEventTouchUpInside];
    [srButton setTitle: @"Stop" forState: UIControlStateNormal];
    srButton.frame = CGRectMake(25.0, view.frame.size.height - 40, 80.0, 30.0);
    srButton.backgroundColor = [UIColor colorWithRed: 0.658 green: 0.3098 blue: 0.72 alpha: 1.0];
    [view addSubview: srButton];
    
    
    /* Slider */
    
    UISlider *slider = [[UISlider alloc] initWithFrame:
                        CGRectMake( view.frame.size.width - SLIDER_WIDTH - 20, view.frame.size.height - 60, SLIDER_WIDTH, 50)];
    
    [view addSubview: slider];
    
    
    /* Speed Label */
    
    UILabel *speedLabel = [[UILabel alloc] initWithFrame:
                           CGRectMake(slider.frame.origin.x + 60, slider.frame.origin.y - 30, 80, 40)];
    
    speedLabel.text = @"Speed";
    speedLabel.font = [UIFont fontWithName:@"Cochin" size: 24];
    [view addSubview: speedLabel];
    
}

+ (void) pressedReset {
    printf("Pressed Reset!\n");
}

+ (void) pressedStopOrResume {
    printf("%s \n", "Pressed Stop or Resume!");

}

@end























