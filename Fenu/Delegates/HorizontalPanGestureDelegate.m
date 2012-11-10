//
//  HorizontalPanGestureDelegate.m
//  Fenu
//
//  Created by Justin C. Beck on 11/9/12.
//  Copyright (c) 2012 Justin C. Beck. All rights reserved.
//

#import "HorizontalPanGestureDelegate.h"

@implementation HorizontalPanGestureDelegate

- (BOOL)gestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer translationInView:self.containerView];
    
    return ABS(point.x) > ABS(point.y);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}

@end
