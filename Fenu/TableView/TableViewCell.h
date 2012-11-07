//
//  TableViewCell.h
//  Fenu
//
//  Created by Justin C. Beck on 9/25/12.
//  Copyright (c) 2012 Justin C. Beck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
{
    UILabel *_author;
}

@property (nonatomic, retain) UILabel *author;

- (void)configureWithEntry:(id)entry;

@end
