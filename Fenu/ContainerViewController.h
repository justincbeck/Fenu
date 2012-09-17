//
//  ContainerViewController.h
//  Fenu
//
//  Created by Justin C. Beck on 9/15/12.
//  Copyright (c) 2012 Justin C. Beck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewController.h"
#import "DetailViewController.h"

@interface ContainerViewController : UIViewController
{
    TableViewController *_tableViewController;
    DetailViewController *_detailViewController;
}

@property (nonatomic, strong) TableViewController *tableViewController;
@property (nonatomic, strong) DetailViewController *detailViewController;

- (void)createDetailControllerWithColor:(UIColor *)color;

@end
