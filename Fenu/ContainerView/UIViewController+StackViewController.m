//
//  UIViewController+StackViewController.m
//  Fenu
//
//  Created by Justin C. Beck on 11/1/12.
//  Copyright (c) 2012 Justin C. Beck. All rights reserved.
//

#import "UIViewController+StackViewController.h"
#import "ContainerViewController.h"

#import <objc/runtime.h>

@implementation UIViewController (StackViewController)

static const char * ContainerViewControllerKey = "ContainerViewControllerKey";

- (ContainerViewController *)containerViewController
{
    return objc_getAssociatedObject(self, &ContainerViewControllerKey);
}

- (void)setContainerViewController:(ContainerViewController *)containerViewController
{
    objc_setAssociatedObject(self, &ContainerViewControllerKey, containerViewController, OBJC_ASSOCIATION_ASSIGN);
}

@end
