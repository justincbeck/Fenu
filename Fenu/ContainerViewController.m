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

float const kMaxDetailXLandscape = 420.0f; // Use relative (window) widths
float const kMaxDetailXPortrait = 260.0f; // User relative (see above)

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
    if (_detailNavController.view.frame.origin.x == [self getMaxX])
    {
        [self snapView:_detailNavController.view toCoordinates:CGPointMake(0.0f, 0.0f)];
    }
    else
    {
        [self snapView:_detailNavController.view toCoordinates:CGPointMake([self getMaxX], 0.0f)];
    }
}

- (UINavigationController *)createControllerWithColor:(UIColor *)color
{
    UIPanGestureRecognizer* gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [gestureRecognizer setMinimumNumberOfTouches:1];
    [gestureRecognizer setMaximumNumberOfTouches:1];
    
    UIBarButtonItem *menuBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleDone target:self action:@selector(showMenu:)];
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithColor:color];
    detailViewController.navigationItem.leftBarButtonItem = menuBarButtonItem;
    
    _detailNavController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    
    CGRect frame = self.view.frame;
    frame.origin.x = [self getMaxX];
    _detailNavController.view.frame = frame;
    [_detailNavController.view addGestureRecognizer:gestureRecognizer];
    
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

- (void)snapView:(UIView *)view toCoordinates:(CGPoint)point
{
    CGRect frame = view.frame;
    frame.origin.x = point.x;
    float duration = (ABS(point.x - view.frame.origin.x) / [self getMaxX]) * 0.3f;
    
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationCurveEaseInOut animations:^{
        view.frame = frame;
    } completion:^(BOOL finished){
        
    }];
}

- (float)getMaxX
{
    if (UIDeviceOrientationIsLandscape(self.interfaceOrientation))
    {
        return kMaxDetailXLandscape;
    }
    else
    {
        return kMaxDetailXPortrait;
    }
}

- (float)getMaxY
{
    if (UIDeviceOrientationIsLandscape(self.interfaceOrientation))
    {
        return 256.0f;
    }
    else
    {
        return 416.0f;
    }
}

// This will go away once the auto sizeing is taken care of...
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGRect frame = _detailNavController.view.frame;
    
    if (UIDeviceOrientationIsLandscape(toInterfaceOrientation))
    {
        if (_detailNavController.view.frame.origin.x == kMaxDetailXPortrait)
        {
            frame.origin.x = kMaxDetailXLandscape;
        }
    }
    else
    {
        if (_detailNavController.view.frame.origin.x == kMaxDetailXLandscape)
        {
            frame.origin.x = kMaxDetailXPortrait;
        }
    }
    
    _detailNavController.view.frame = frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
