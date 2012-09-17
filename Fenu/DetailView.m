//
//  DetailView.m
//  Fenu
//
//  Created by Justin C. Beck on 9/17/12.
//  Copyright (c) 2012 Justin C. Beck. All rights reserved.
//

#import "DetailView.h"

@implementation DetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint loc = [touch locationInView:self];
    CGPoint prevLoc = [touch previousLocationInView:self];
    
    CGRect frame = self.frame;
    float deltaX = loc.x - prevLoc.x;
    frame.origin.x += deltaX;
    
    if (frame.origin.x > 0.0f && frame.origin.x < 280.0f)
    {
        [self setFrame:frame];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.frame.origin.x < 160.0f)
    {
        [self snapToCoordinates:CGPointMake(0.0f, 0.0f)];
    }
   
    if (self.frame.origin.x > 160.0f)
    {
        [self snapToCoordinates:CGPointMake(280.0f, 0.0f)];
    }
}

- (void)snapToCoordinates:(CGPoint)point
{
    CGRect frame = self.frame;
    frame.origin.x = point.x;
    float duration = [self calculateDuration:point];
    
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationCurveEaseInOut animations:^{
        self.frame = frame;
    } completion:^(BOOL finished){
        
    }];
}

- (float)calculateDuration:(CGPoint)point
{
    return (ABS(point.x - self.frame.origin.x) / 320.0f) * 0.3;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
