//
//  ContainerViewController.m
//  Fenu
//
//  Created by Justin C. Beck on 9/15/12.
//  Copyright (c) 2012 Justin C. Beck. All rights reserved.
//

#import "ContainerViewController.h"
#import "TableViewController.h"
#import "DetailViewController.h"

@interface ContainerViewController ()

@end

@implementation ContainerViewController

@synthesize tableViewController = _tableViewController;
@synthesize detailViewController = _detailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _tableViewController = [[TableViewController alloc] initWithStyle:UITableViewStylePlain];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];

    [self addChildViewController:_tableViewController];
    [self.view addSubview:_tableViewController.view];
    
    [self createDetailControllerWithColor:[UIColor grayColor] andFrame:CGRectMake(0.0f, 0.0f, 320.0f, 460.0f)];
    _detailViewController.view.frame = CGRectMake(0.0f, 0.0f, 320.0f, 460.0f);
}

- (void)createDetailControllerWithColor:(UIColor *)color andFrame:(CGRect)frame
{
    if (_detailViewController != nil)
    {
        [_detailViewController.view removeFromSuperview];
        [_detailViewController removeFromParentViewController];
    }
    
    _detailViewController = [[DetailViewController alloc] initWithColor:color];
    _detailViewController.view.frame = frame;
    
    [self addChildViewController:_detailViewController];
    [self.view addSubview:_detailViewController.view];
    
    [(DetailView*) _detailViewController.view snapToCoordinates:CGPointMake(0.0f, 0.0f)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
