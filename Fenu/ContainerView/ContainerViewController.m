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
#import "UIViewController+StackViewController.h"

@interface ContainerViewController ()
{
    TableViewController *_tableViewController;
    UINavigationController *_detailNavController;
    UIView *_alphaView;
}

@end

@interface UIViewController ()

@property (nonatomic, readwrite) ContainerViewController *containerViewController;

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
    
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self addChildViewController:_tableViewController];
    [_tableViewController setContainerViewController:self];
    
    CGRect frame = _tableViewController.view.frame;
    frame.origin.y -= [[UIApplication sharedApplication] statusBarFrame].size.height;
    _tableViewController.view.frame = frame;
    
    [self.view addSubview:_tableViewController.view];
    
    _alphaView = [[UIView alloc] initWithFrame:frame];
    _alphaView.alpha = 0.0f;
    _alphaView.backgroundColor = [UIColor blackColor];
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
    
    [_alphaView removeFromSuperview];
    [self.view insertSubview:_alphaView aboveSubview:_tableViewController.view];
    
    [self snapView:_detailNavController.view toCoordinates:CGPointMake(0.0f, 0.0f)];
    [self snapView:_tableViewController.view toCoordinates:CGPointMake(-96.0f, 0.0f)];
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
    float alpha = point.x / [self getMaxX];
    
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationCurveEaseInOut animations:^{
        view.frame = frame;
        _alphaView.alpha = alpha;
    } completion:^(BOOL finished){
        // TODO: bounce it!
    }];
}

- (void)showMenu:(id)sender
{
    if (_detailNavController.view.frame.origin.x == [self getMaxX])
    {
        [self snapView:_detailNavController.view toCoordinates:CGPointMake(0.0f, 0.0f)];
        [self snapView:_tableViewController.view toCoordinates:CGPointMake(-96.0f, 0.0f)];
    }
    else
    {
        [self snapView:_detailNavController.view toCoordinates:CGPointMake([self getMaxX], 0.0f)];
        [self snapView:_tableViewController.view toCoordinates:CGPointMake(0.0f, 0.0f)];
    }
}

- (void)panGesture:(UIPanGestureRecognizer *)gesture
{
    UIView *view = [gesture view];
    CGPoint point = [gesture translationInView:view.superview];
    CGRect detailViewFrame = view.frame;
    CGRect tableViewFrame = _tableViewController.view.frame;
    
    if ([gesture state] == UIGestureRecognizerStateChanged)
    {
        detailViewFrame.origin.x = detailViewFrame.origin.x + point.x;
        tableViewFrame.origin.x = (detailViewFrame.origin.x / [self getMaxX] * 96.0f) - 96.0f;
        
        if (detailViewFrame.origin.x >= 0.0f && detailViewFrame.origin.x <= [self getMaxX])
        {
            [view setFrame:detailViewFrame];
            [_tableViewController.view setFrame:tableViewFrame];
            
            [gesture setTranslation:CGPointZero inView:view.superview];
            
            _alphaView.alpha = 1 - (detailViewFrame.origin.x / [self getMaxX]);
        }
    }
    else if ([gesture state] == UIGestureRecognizerStateEnded)
    {
        if (detailViewFrame.origin.x < [self getMaxX]/ 2.0f)
        {
            [self snapView:view toCoordinates:CGPointMake(0.0f, 0.0f)];
            [self snapView:_tableViewController.view toCoordinates:CGPointMake(-96.0f, 0.0f)];
        }
        else
        {
            [self snapView:view toCoordinates:CGPointMake([self getMaxX], 0.0f)];
            [self snapView:_tableViewController.view toCoordinates:CGPointMake(0.0f, 0.0f)];
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
