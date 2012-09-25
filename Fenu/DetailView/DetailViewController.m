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
    NSDictionary *_entry;
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

- (id)initWithEntry:(id)entry
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _detailView = [[UIView alloc] initWithFrame:CGRectZero];
        _entry = entry;
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
    
    _detailView.backgroundColor = [UIColor whiteColor];
    
    // TODO: Get rid of this: TEST (maybe come up with a custom view for this?)
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 130.0f, 15.0f)];
    label.text = [_entry objectForKey:@"author"];
    [_detailView addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
