//
//  SPLViewController.m
//  Double Slider
//
//  Created by Skyler Patrick Lutz on 2/23/14.
//  Copyright (c) 2014 Skyler Patrick Lutz. All rights reserved.
//

#import "SPLViewController.h"
#import "SPLSlider.h"

@interface SPLViewController () <SPLSliderDelegate>

@end

@implementation SPLViewController

- (void)viewDidLoad {
    
    SPLSlider *slider = [[SPLSlider alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.bounds), CGRectGetMinY(self.view.bounds), CGRectGetWidth(self.view.bounds)/1.25, 60)];
    slider.delegate = self;
    slider.center = self.view.center;
    [self.view addSubview:slider];
}

#pragma mark SPLSliderDelegate
- (void)slider:(SPLSlider *)slider changedLeftValue:(NSInteger)left rightValue:(NSInteger)right {
    NSLog(@"left: %d right: %d", left, right);
}
- (void)slider:(SPLSlider *)slider finalizedLeftValue:(NSInteger)left rightValue:(NSInteger)right {
    NSLog(@"finalized");
}
@end
