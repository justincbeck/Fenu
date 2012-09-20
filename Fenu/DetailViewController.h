//
//  DetailViewController.h
//  Fenu
//
//  Created by Justin C. Beck on 9/15/12.
//  Copyright (c) 2012 Justin C. Beck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
{
    UIView *_detailView;
}

@property (nonatomic, strong) UIView *detailView;

- (id)initWithColor:(UIColor *)color;

@end
