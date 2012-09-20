//
//  DetailViewController.m
//  Fenu
//
//  Created by Justin C. Beck on 9/15/12.
//  Copyright (c) 2012 Justin C. Beck. All rights reserved.
//

#import "DetailViewController.h"
#import "ContainerViewController.h"

@interface DetailViewController ()
{
    UIColor *_color;
}

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _detailView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (id)initWithColor:(UIColor *)color
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _detailView = [[UIView alloc] initWithFrame:CGRectZero];
        _color = color;
    }
    return self;
}

- (void)loadView
{
    self.view = _detailView;
    self.view.frame = self.view.superview.frame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _detailView.backgroundColor = _color;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
