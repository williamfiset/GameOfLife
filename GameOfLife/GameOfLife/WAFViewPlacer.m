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


@implementation WAFViewPlacer


/* Places all the menu objects on the screen (Labels, Sliders, buttons... ) */
+ (void) placeMainSceneViews:(UIView *) view {
    
    
  /* Reset Button */
    
    UIButton *resetButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [resetButton addTarget: self action: @selector(pressedReset) forControlEvents:UIControlEventTouchUpInside];
    [resetButton setTitle: @"Reset" forState: UIControlStateNormal];
    resetButton.titleLabel.font = [UIFont systemFontOfSize: 20.5];
    [resetButton setTitleColor: [UIColor colorWithRed: 0 green: 91/255.0 blue: 255.0 alpha: 1] forState: UIControlStateNormal];
    resetButton.frame = CGRectMake(25.0, view.frame.size.height - 80, 80.0, 30.0);

    
  /* Stop/Resume Button */
    
    UIButton *srButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [srButton addTarget: self action: @selector (pressedStopOrResume) forControlEvents: UIControlEventTouchUpInside];
    [srButton setTitle: @"Stop" forState: UIControlStateNormal];
    srButton.titleLabel.font = [UIFont systemFontOfSize: 20.5];
    [srButton setTitleColor: [UIColor colorWithRed: 0 green: 91/255.0 blue: 255.0 alpha: 1] forState: UIControlStateNormal];
    srButton.frame = CGRectMake(25.0, view.frame.size.height - 40, 80.0, 30.0);
    
  /* Slider */
    
    UIImage *sliderThumbImage = [UIImage imageNamed: @"circle45.png"];

    
    UISlider *speedSlider = [[UISlider alloc] initWithFrame:
                        CGRectMake( view.frame.size.width - SLIDER_WIDTH - 20, view.frame.size.height - 45, SLIDER_WIDTH, 50)];
    [speedSlider setThumbImage: sliderThumbImage forState: UIControlStateNormal];
    
    
    
    UISlider *sizeSlider = [[UISlider alloc] initWithFrame:
                        CGRectMake( view.frame.size.width - SLIDER_WIDTH - 20, view.frame.size.height - 90, SLIDER_WIDTH, 50)];
    [sizeSlider setThumbImage: sliderThumbImage forState: UIControlStateNormal];
    
  /* Labels */
    
    
    // speed Label
    UILabel *speedLabel = [[UILabel alloc] initWithFrame:
                      CGRectMake(speedSlider.frame.origin.x + 40, speedSlider.frame.origin.y - 20, 100, 50)];
    
    [speedLabel setValue: @"Reproduction Speed" forKey: @"text"];
    [speedLabel setFont: [UIFont fontWithName: @"Helvetica" size: 10]];
    
    // Size Label
    UILabel *sizeLabel = [[UILabel alloc] initWithFrame:
                           CGRectMake(sizeSlider.frame.origin.x + 60, sizeSlider.frame.origin.y - 20, 100, 50)];
    
    [sizeLabel setValue: @"Critter Size" forKey: @"text"];
    [sizeLabel setFont: [UIFont fontWithName: @"Helvetica" size: 10]];
    
    
  /* Place Things on Screen */
    
    [view addSubview: sizeLabel];
    [view addSubview: speedLabel];
    
    [view addSubview: resetButton];
    [view addSubview: srButton];
    
    [view addSubview: speedSlider];
    [view addSubview: sizeSlider];


    
}

+ (void) pressedReset {
    
    
    
    printf("Pressed Reset!\n");
}

+ (void) pressedStopOrResume {
    printf("%s \n", "Pressed Stop or Resume!");

}

@end























