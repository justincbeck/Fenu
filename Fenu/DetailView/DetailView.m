//
//  DetailView.m
//  Fenu
//
//  Created by Justin C. Beck on 9/27/12.
//  Copyright (c) 2012 Justin C. Beck. All rights reserved.
//

#import "DetailView.h"

@implementation DetailView

@synthesize created = _created;
@synthesize title = _title;
@synthesize author = _author;
@synthesize content = _content;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _created = [[UILabel alloc] initWithFrame:CGRectZero];
        _title = [[UILabel alloc] initWithFrame:CGRectZero];
        _author = [[UILabel alloc] initWithFrame:CGRectZero];
        _content = [[UIWebView alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
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
