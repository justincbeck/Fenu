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
    
    [self addChildViewController:_tableViewController];
    [self.view addSubview:_tableViewController.view];
}

- (void)colorSelected:(UIColor *)color
{
    if (_detailViewController != nil)
    {
        [_detailViewController.view removeFromSuperview];
        [_detailViewController removeFromParentViewController];
    }
    
    UIPanGestureRecognizer* gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [gestureRecognizer setMinimumNumberOfTouches:1];
    [gestureRecognizer setMaximumNumberOfTouches:1];
    
    _detailViewController = [[DetailViewController alloc] initWithColor:color];
    _detailViewController.view.frame = CGRectMake(280.0f, 0.0f, 320.0f, 460.0f);
    [_detailViewController.view addGestureRecognizer:gestureRecognizer];
    
    [self addChildViewController:_detailViewController];
    [self.view addSubview:_detailViewController.view];
    
    [self snapView:_detailViewController.view toCoordinates:CGPointMake(0.0f, 0.0f)];
}

- (void)panGesture:(UIPanGestureRecognizer *)gesture
{
    UIView *view = [gesture view];
    CGPoint point = [gesture translationInView:view.superview];
    CGRect frame = view.frame;
    
    if ([gesture state] == UIGestureRecognizerStateChanged)
    {
        frame.origin.x = frame.origin.x + point.x;
        if (frame.origin.x >= 0.0f && frame.origin.x <= 280.0f)
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
            [self snapView:view toCoordinates:CGPointMake(280.0f, 0.0f)];
        }
    }
}

- (void)snapView:(UIView *)view toCoordinates:(CGPoint)point
{
    CGRect frame = view.frame;
    frame.origin.x = point.x;
    float duration = (ABS(point.x - view.frame.origin.x) / 280.0f) * 0.3f;
    
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
