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
    NSDictionary *_entry;
}

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _detailView = [[DetailView alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (id)initWithEntry:(id)entry
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _detailView = [[DetailView alloc] initWithFrame:CGRectZero];
        _entry = entry;

        _detailView.created.text = ((NSDate *)[NSDate dateWithTimeIntervalSince1970:[[entry objectForKey:@"updated"] intValue]]).description;
        [_detailView addSubview:_detailView.created];
        
        _detailView.title.text = [_entry objectForKey:@"title"];
        [_detailView addSubview:_detailView.title];
        
        _detailView.author.text = [_entry objectForKey:@"author"];
        [_detailView addSubview:_detailView.author];

        [_detailView.content loadHTMLString:[_entry objectForKey:@"content"] baseURL:[[NSBundle mainBundle] resourceURL]];
        [_detailView addSubview:_detailView.content];
    }
    return self;
}

- (void)loadView
{
    self.view = _detailView;
    self.view.frame = self.view.superview.frame;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    
    _detailView.backgroundColor = [UIColor whiteColor];
    
    _detailView.created.frame = CGRectMake(10.0f, 10.0f, 300.0f, 15.0f);
    _detailView.title.frame = CGRectMake(10.0f, 30.0f, 300.0f, 15.0f);
    _detailView.author.frame = CGRectMake(10.0f, 50.0f, 300.0f, 15.0f);
    _detailView.content.frame = CGRectMake(10.0f, 70.0f, 300.0f, 611.0f);
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(-1.0f, 0.0f, 1.0f, self.navigationController.view.frame.size.height)];
    lineView.backgroundColor = [UIColor orangeColor];
    [self.navigationController.view addSubview:lineView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
