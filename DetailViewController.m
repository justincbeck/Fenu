//
//  DetailViewController.m
//  Fenu
//
//  Created by Justin C. Beck on 9/15/12.
//  Copyright (c) 2012 Justin C. Beck. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailView.h"

@interface DetailViewController ()
{
    UIColor *_color;
}

@property (nonatomic, strong) UIColor* color;

@end

@implementation DetailViewController

@synthesize detailView = _detailView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)initWithColor:(UIColor *)color
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _color = color;
    }
    return self;
}

- (void)loadView
{
    _detailView = [[DetailView alloc] initWithFrame:CGRectZero];
    self.view = _detailView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _detailView.backgroundColor = _color;
    [_detailView snapToCoordinates:CGPointMake(0.0f, 0.0f)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
