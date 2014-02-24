//
//  SPLViewController.m
//  Double Slider
//
//  Created by Skyler Patrick Lutz on 2/23/14.
//  Copyright (c) 2014 Skyler Patrick Lutz. All rights reserved.
//

#import "SPLViewController.h"
#import "SPLSlider.h"

@implementation SPLViewController

- (void)viewDidLoad {
    
    SPLSlider *slider = [[SPLSlider alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.bounds), CGRectGetMinY(self.view.bounds), CGRectGetWidth(self.view.bounds)/1.25, 60)];
    slider.center = self.view.center;
    [self.view addSubview:slider];
}
@end
