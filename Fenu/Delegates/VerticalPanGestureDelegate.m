//
//  VerticalPanGestureDelegate.m
//  Fenu
//
//  Created by Justin C. Beck on 11/9/12.
//  Copyright (c) 2012 Justin C. Beck. All rights reserved.
//

#import "VerticalPanGestureDelegate.h"

@implementation VerticalPanGestureDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    NSLog(@"Should receive touch?");
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"Should begin?");
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    NSLog(@"Should recieve multiple");
    return YES;
}

@end
