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

- (void)snapView:(UIView *)view toCoordinates:(CGPoint)point;

@end

@implementation ContainerViewController

@synthesize tableViewController = _tableViewController;
@synthesize detailNavController = _detailNavController;

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
    
    [self addChildViewController:_tableViewController];
    [self.view addSubview:_tableViewController.view];
}

- (void)colorSelected:(UIColor *)color
{
    if (_detailNavController != nil)
    {
        [_detailNavController.view removeFromSuperview];
        [_detailNavController removeFromParentViewController];
    }
    
    _detailNavController = [self createControllerWithColor:color];
    
    [self addChildViewController:_detailNavController];
    [self.view addSubview:_detailNavController.view];
    
    [self snapView:_detailNavController.view toCoordinates:CGPointMake(0.0f, 0.0f)];
}

- (void)showMenu:(id)sender
{
    if (_detailNavController.view.frame.origin.x == 260.0f)
    {
        [self snapView:_detailNavController.view toCoordinates:CGPointMake(0.0f, 0.0f)];
    }
    else
    {
        [self snapView:_detailNavController.view toCoordinates:CGPointMake(260.0f, 0.0f)];
    }
}

- (UINavigationController *)createControllerWithColor:(UIColor *)color
{
    UIPanGestureRecognizer* gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [gestureRecognizer setMinimumNumberOfTouches:1];
    [gestureRecognizer setMaximumNumberOfTouches:1];
    
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithColor:color];
    detailViewController.view.frame = CGRectMake(0.0f, 0.0f, 320.0f, 416.0f);
    
    _detailNavController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    _detailNavController.view.frame = CGRectMake(260.0f, 0.0f, 320.0f, 460.0f);
    [_detailNavController.view addGestureRecognizer:gestureRecognizer];
    
    UIBarButtonItem *menuBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleDone target:self action:@selector(showMenu:)];
    detailViewController.navigationItem.leftBarButtonItem = menuBarButtonItem;
    
    return _detailNavController;
}

- (void)panGesture:(UIPanGestureRecognizer *)gesture
{
    UIView *view = [gesture view];
    CGPoint point = [gesture translationInView:view.superview];
    CGRect frame = view.frame;
    
    if ([gesture state] == UIGestureRecognizerStateChanged)
    {
        frame.origin.x = frame.origin.x + point.x;
        if (frame.origin.x >= 0.0f && frame.origin.x <= 260.0f)
        {
            [view setFrame:frame];
            [gesture setTranslation:CGPointZero inView:view.superview];
        }
    }
    else if ([gesture state] == UIGestureRecognizerStateEnded)
    {
        if (frame.origin.x < 160.0f)
        {
            [self snapView:view toCoordinates:CGPointMake(0.0f, 0.0f)];
        }
        else
        {
            [self snapView:view toCoordinates:CGPointMake(260.0f, 0.0f)];
        }
    }
}

- (void)snapView:(UIView *)view toCoordinates:(CGPoint)point
{
    CGRect frame = view.frame;
    frame.origin.x = point.x;
    float duration = (ABS(point.x - view.frame.origin.x) / 260.0f) * 0.3f;
    
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationCurveEaseInOut animations:^{
        view.frame = frame;
    } completion:^(BOOL finished){
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
