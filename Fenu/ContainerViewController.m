//
//  ContainerViewController.m
//  Fenu
//
//  Created by Justin C. Beck on 9/15/12.
//  Copyright (c) 2012 Justin C. Beck. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ContainerViewController.h"
#import "TableViewController.h"
#import "DetailViewController.h"

@interface ContainerViewController ()
{
    TableViewController *_tableViewController;
    UINavigationController *_detailNavController;
}

@end

@implementation ContainerViewController

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
    
    self.view.backgroundColor = [UIColor cyanColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addChildViewController:_tableViewController];
    
    CGRect frame = _tableViewController.view.frame;
    frame.origin.y -= [[UIApplication sharedApplication] statusBarFrame].size.height;
    _tableViewController.view.frame = frame;
    
    [self.view addSubview:_tableViewController.view];
}

- (void)entrySelected:(id)entry
{
    if (_detailNavController != nil)
    {
        [_detailNavController.view removeFromSuperview];
        [_detailNavController removeFromParentViewController];
    }
    
    _detailNavController = [self createControllerWithEntry:entry];
    
    [self addChildViewController:_detailNavController];
    [self.view addSubview:_detailNavController.view];
    
    CGRect frame = _detailNavController.view.frame;
    frame.origin.x = [self getMaxX];
    _detailNavController.view.frame = frame;
    
    [self snapView:_detailNavController.view toCoordinates:CGPointMake(0.0f, 0.0f)];
}

- (UINavigationController *)createControllerWithEntry:(id)entry
{
    UIPanGestureRecognizer* gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [gestureRecognizer setMinimumNumberOfTouches:1];
    [gestureRecognizer setMaximumNumberOfTouches:1];
    
    UIBarButtonItem *menuBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleDone target:self action:@selector(showMenu:)];
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithEntry:entry];
    detailViewController.navigationItem.leftBarButtonItem = menuBarButtonItem;
    
    _detailNavController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    _detailNavController.view.layer.borderWidth = 1.0f;
    _detailNavController.view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [_detailNavController.view addGestureRecognizer:gestureRecognizer];
    
    return _detailNavController;
}

- (void)snapView:(UIView *)view toCoordinates:(CGPoint)point
{
    CGRect frame = view.frame;
    frame.origin.x = point.x;
    float duration = (ABS(point.x - view.frame.origin.x) / [self getMaxX]) * 0.3f;
    
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationCurveEaseInOut animations:^{
        view.frame = frame;
    } completion:^(BOOL finished){
        // TODO: bounce it!
    }];
}

- (void)showMenu:(id)sender
{
    if (_detailNavController.view.frame.origin.x == [self getMaxX])
    {
        [self snapView:_detailNavController.view toCoordinates:CGPointMake(0.0f, 0.0f)];
    }
    else
    {
        [self snapView:_detailNavController.view toCoordinates:CGPointMake([self getMaxX], 0.0f)];
    }
}

- (void)panGesture:(UIPanGestureRecognizer *)gesture
{
    UIView *view = [gesture view];
    CGPoint point = [gesture translationInView:view.superview];
    CGRect frame = view.frame;
    
    if ([gesture state] == UIGestureRecognizerStateChanged)
    {
        frame.origin.x = frame.origin.x + point.x;
        if (frame.origin.x >= 0.0f && frame.origin.x <= [self getMaxX])
        {
            [view setFrame:frame];
            [gesture setTranslation:CGPointZero inView:view.superview];
        }
    }
    else if ([gesture state] == UIGestureRecognizerStateEnded)
    {
        if (frame.origin.x < [self getMaxX]/ 2.0f)
        {
            [self snapView:view toCoordinates:CGPointMake(0.0f, 0.0f)];
        }
        else
        {
            [self snapView:view toCoordinates:CGPointMake([self getMaxX], 0.0f)];
        }
    }
}

- (float)getMaxX
{
    return _detailNavController.view.frame.size.width - 63.0f;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGRect frame = _detailNavController.view.frame;
    
    if (_detailNavController.view.frame.origin.x != 0.0f)
    {
        frame.origin.x = frame.size.height - 43.0f;
    }
    
    _detailNavController.view.frame = frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
