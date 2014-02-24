//
//  SPLSlider.m
//  Double Slider
//
//  Created by Skyler Patrick Lutz on 2/23/14.
//  Copyright (c) 2014 Skyler Patrick Lutz. All rights reserved.
//

#import "SPLSlider.h"

@interface SPLSlider ()
@property (nonatomic) CGRect left;
@property (nonatomic) CGRect right;
@property (nonatomic, assign) BOOL touchedLeft;
@property (nonatomic, assign) BOOL touchedRight;

@property (nonatomic, readwrite) NSInteger leftSlideValue;
@property (nonatomic, readwrite) NSInteger rightSlideValue;
@end

@implementation SPLSlider

#pragma mark Designated Initializer
- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _maxValue = 10;
        _minValue = 1;
        _stepValue= 2;
        _leftSlideValue = _minValue;
        _rightSlideValue = _maxValue;
        _slideRadius = CGRectGetHeight(frame) / 4.0;
        
        self.left = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMidY(self.bounds)-self.slideRadius, _slideRadius * 2.0, _slideRadius * 2.0);
        self.right = CGRectMake(CGRectGetMaxX(self.bounds) - self.slideRadius * 2.0, CGRectGetMidY(self.bounds) - self.slideRadius, _slideRadius * 2.0, _slideRadius * 2.0);
    }
    return self;
}
#pragma mark Overridden Setter Methods
- (void)setSlideRadius:(CGFloat)slideRadius {
    _slideRadius = slideRadius;
    
    self.left = CGRectMake(CGRectGetMinX(self.left), CGRectGetMidY(self.left) - self.slideRadius, _slideRadius * 2.0, _slideRadius * 2.0);
    self.right = CGRectMake(CGRectGetMaxX(self.right) - self.slideRadius * 2.0, CGRectGetMidY(self.right) - self.slideRadius, _slideRadius * 2.0, _slideRadius * 2.0);
}
- (void)setLeft:(CGRect)left {
    _left = left;
    
    CGFloat prop = self.left.origin.x / CGRectGetMaxX(self.bounds);
    NSInteger leftValue = (self.maxValue - self.minValue) * prop + self.minValue;

    NSInteger diff = leftValue - self.leftSlideValue;
    
    self.leftSlideValue = leftValue - (diff % self.stepValue);
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    if ([self.delegate respondsToSelector:@selector(slider:changedLeftValue:rightValue:)]) {
        [self.delegate slider:self changedLeftValue:self.leftSlideValue rightValue:self.rightSlideValue];
    }
}
- (void)setRight:(CGRect)right {
    _right = right;
    
    CGFloat prop = CGRectGetMaxX(self.right) / CGRectGetMaxX(self.bounds);
    NSInteger rightValue = (self.maxValue - self.minValue) * prop + self.minValue;
    NSInteger diff = rightValue - self.rightSlideValue;
    
    self.rightSlideValue = rightValue - (diff % self.stepValue);
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    if ([self.delegate respondsToSelector:@selector(slider:changedLeftValue:rightValue:)]) {
        [self.delegate slider:self changedLeftValue:self.leftSlideValue rightValue:self.rightSlideValue];
    }
}
#pragma mark Touch Logic
- (BOOL)slideWouldLeaveBounds:(CGPoint)down {
    return !CGRectContainsPoint(CGRectMake(CGRectGetMinX(self.bounds) + self.slideRadius, CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds) - self.slideRadius * 2.0, CGRectGetMaxY(self.bounds)), down);
}
- (BOOL)slidesWouldOverlap:(CGPoint)down {
    if (self.touchedLeft) {
        return CGRectContainsPoint(self.right, down) || down.x > self.right.origin.x;
    }
    else if (self.touchedRight) {
        return CGRectContainsPoint(self.left, down) || down.x < self.left.origin.x;
    }
    return NO;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint down = [touch locationInView:self];
    if (CGRectContainsPoint(self.left, down)) { // touched left
        self.touchedLeft = YES;
        [self setNeedsDisplay];
    }
    else if (CGRectContainsPoint(self.right, down)) {
        self.touchedRight = YES;
        [self setNeedsDisplay];
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint down = [touch locationInView:self];
    if ([self slideWouldLeaveBounds:down] || [self slidesWouldOverlap:down]) {
        return;
    }
    if (self.touchedLeft) {
        self.left = CGRectMake(down.x-self.slideRadius, CGRectGetMinY(self.left), CGRectGetWidth(self.left), CGRectGetHeight(self.left));
        [self setNeedsDisplay];
    }
    else if (self.touchedRight) {
        self.right = CGRectMake(down.x-self.slideRadius, CGRectGetMinY(self.right), CGRectGetWidth(self.right), CGRectGetHeight(self.right));
        [self setNeedsDisplay];
    }
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.touchedLeft = self.touchedRight = NO;
    
    if ([self.delegate respondsToSelector:@selector(slider:finalizedLeftValue:rightValue:)]) {
        [self.delegate slider:self finalizedLeftValue:self.leftSlideValue rightValue:self.rightSlideValue];
    }
}
#pragma mark Drawing
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint baseline_begin = CGPointMake(CGRectGetMinX(self.bounds) + self.slideRadius, CGRectGetMidY(self.bounds));
    CGPoint baseline_end = CGPointMake(CGRectGetMaxX(self.bounds) - self.slideRadius, CGRectGetMidY(self.bounds));
    CGContextMoveToPoint(context, baseline_begin.x, baseline_begin.y);
    CGContextAddLineToPoint(context, baseline_end.x, baseline_end.y);
    CGContextStrokePath(context);
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillEllipseInRect(context, self.left);
    CGContextStrokeEllipseInRect(context, self.left);
    CGContextFillEllipseInRect(context, self.right);
    CGContextStrokeEllipseInRect(context, self.right);
    CGContextRestoreGState(context);
}

@end
