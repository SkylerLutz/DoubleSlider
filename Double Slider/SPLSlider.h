//
//  SPLSlider.h
//  Double Slider
//
//  Created by Skyler Patrick Lutz on 2/23/14.
//  Copyright (c) 2014 Skyler Patrick Lutz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPLSlider;

@protocol SPLSliderDelegate <NSObject>

@optional
- (void)slider:(SPLSlider *)slider changedLeftValue:(NSInteger)left rightValue:(NSInteger)right;
- (void)slider:(SPLSlider *)slider finalizedLeftValue:(NSInteger)left rightValue:(NSInteger)right;
@end

@interface SPLSlider : UIControl

@property (nonatomic, weak) id<SPLSliderDelegate> delegate;

@property (nonatomic) NSInteger maxValue;
@property (nonatomic) NSInteger minValue;
@property (nonatomic) NSInteger stepValue;
@property (nonatomic) NSInteger leftSlideValue;
@property (nonatomic) NSInteger rightSlideValue;
@property (nonatomic) CGFloat slideRadius;

@end
