//
//  CALayer+Spin.m
//  Giveit100
//
//  Created by ytb on 14-3-24.
//  Copyright (c) 2014年 Feinno. All rights reserved.
//

#import "CALayer+Spin.h"

@implementation CALayer (Spin)

- (void)spinArrowImage
{
    self.hidden = NO;
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
	CGRect frame = self.frame;
	self.anchorPoint = CGPointMake(0.5, 0.5);
	self.position = CGPointMake(frame.origin.x + 0.5 * frame.size.width, frame.origin.y + 0.5 * frame.size.height);
	[CATransaction commit];
    
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
	[CATransaction setValue:[NSNumber numberWithFloat:1.0] forKey:kCATransactionAnimationDuration];
    
	CABasicAnimation *animation;
	animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	animation.fromValue = [NSNumber numberWithFloat:0.0];
	animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
	animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
	animation.delegate = self;
    animation.repeatCount = INT_MAX;
	[self addAnimation:animation forKey:@"rotationAnimation"];
    
	[CATransaction commit];
}

@end
