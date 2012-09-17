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
    
    if (frame.origin.x > 0.0f && frame.origin.x < 320.0f)
    {
        [self setFrame:frame];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.frame.origin.x < 160.0f)
    {
        [self snapBack];
    }
    
    if (self.frame.origin.x > 160.0f)
    {
        [self snapForward];
    }
}

- (void)snapBack
{
    CGRect frame = self.frame;
    
    frame.origin.x = 0.0f;
    [UIView animateWithDuration:0.15f delay:0.0f options:UIViewAnimationCurveEaseInOut animations:^{
        self.frame = frame;
    } completion:^(BOOL finished){
        
    }];
}

- (void)snapForward
{
    CGRect frame = self.frame;
    
    frame.origin.x = 280.0f;
    [UIView animateWithDuration:0.15f delay:0.0f options:UIViewAnimationCurveEaseInOut animations:^{
        self.frame = frame;
    } completion:^(BOOL finished){
            
    }];
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
