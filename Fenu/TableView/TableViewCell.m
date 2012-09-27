//
//  TableViewCell.m
//  Fenu
//
//  Created by Justin C. Beck on 9/25/12.
//  Copyright (c) 2012 Justin C. Beck. All rights reserved.
//

#import "TableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation TableViewCell

@synthesize author = _author;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _author = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self addSubview:self.author];

    self.author.frame = CGRectMake(85.0f, 10.0f, 200.0f, 15.0f);
    self.textLabel.frame = CGRectMake(85.0f, 33.0f, 200.0f, 20.0f);
    self.detailTextLabel.frame = CGRectMake(85.0f, 60.0f, 200.0f, 15.0f);
    self.imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.imageView.layer.borderWidth = 1.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
