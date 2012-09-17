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
        _detailViewController = [[DetailViewController alloc] initWithColor:[UIColor grayColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];

    [self addChildViewController:_tableViewController];
    [self addChildViewController:_detailViewController];
    
    [self.view addSubview:_tableViewController.view];
    [self.view addSubview:_detailViewController.view];
}

- (void)createDetailControllerWithColor:(UIColor *) color
{
    [_detailViewController removeFromParentViewController];
    _detailViewController = [[DetailViewController alloc] initWithColor:color];
    
    [self addChildViewController:_detailViewController];
    [self.view addSubview:_detailViewController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
