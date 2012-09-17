//
//  DetailViewController.h
//  Fenu
//
//  Created by Justin C. Beck on 9/15/12.
//  Copyright (c) 2012 Justin C. Beck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailView.h"

@interface DetailViewController : UIViewController
{
    DetailView *_detailView;
}

@property (nonatomic, strong) UIView *detailView;

- (id)initWithColor:(UIColor *)color;

@end
