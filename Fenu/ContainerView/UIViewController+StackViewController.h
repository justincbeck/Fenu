//
//  UIViewController+StackViewController.h
//  Fenu
//
//  Created by Justin C. Beck on 11/1/12.
//  Copyright (c) 2012 Justin C. Beck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerViewController.h"

@interface UIViewController (StackViewController)

@property (nonatomic, readonly) ContainerViewController *containerViewController;

@end
