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
- (void)slider:(SPLSlider *)slider changedLeftValue:(CGFloat)left rightValue:(CGFloat)right;
- (void)slider:(SPLSlider *)slider finalizedLeftValue:(CGFloat)left rightValue:(CGFloat)right;
@end

@interface SPLSlider : UIControl

@property (nonatomic, weak) id<SPLSliderDelegate> delegate;

@property (nonatomic) CGFloat maxValue;
@property (nonatomic) CGFloat minValue;
@property (nonatomic) CGFloat stepValue;
@property (nonatomic) CGFloat leftSlideValue;
@property (nonatomic) CGFloat rightSlideValue;
@property (nonatomic) CGFloat slideRadius;

@end
