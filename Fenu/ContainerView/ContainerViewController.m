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

#define kMenuMinX -96.0f

typedef enum {
    kOpen,
    kClosed
} Position;

@interface ContainerViewController ()
{
    TableViewController *_tableViewController;
    UINavigationController *_detailNavController;
    UIViewController *_shadowViewController;
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
    
    _shadowViewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    _shadowViewController.view.alpha = 0.0f;
    _shadowViewController.view.backgroundColor = [UIColor blackColor];
    _shadowViewController.view.frame = _tableViewController.view.frame;
    
    [self addChildViewController:_shadowViewController];
    [self.view insertSubview:_shadowViewController.view aboveSubview:_tableViewController.view];
}

- (void)entrySelected:(id)entry
{
    if (_detailNavController != nil)
    {
        [_detailNavController.view removeFromSuperview];
        [_detailNavController removeFromParentViewController];
    }
    
    _detailNavController = [self createControllerWithEntry:entry];
    _detailNavController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    _detailNavController.view.layer.shadowOpacity = 1.0f;
    _detailNavController.view.layer.shadowRadius = 5.0f;
    _detailNavController.view.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
    _detailNavController.view.clipsToBounds = NO;
    
    [self addChildViewController:_detailNavController];
    [self.view addSubview:_detailNavController.view];
    
    CGRect frame = _detailNavController.view.frame;
    frame.origin.x = [self getMaxX];
    _detailNavController.view.frame = frame;
    
    [self snapViewsOpen:NO];
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

- (void)snapViewsOpen:(Boolean)open
{
    CGRect detailFrame = _detailNavController.view.frame;
    CGRect tableFrame = _tableViewController.view.frame;
    
    if (open)
    {
        detailFrame.origin.x = [self getMaxX];
        tableFrame.origin.x = 0.0f;
    }
    else
    {
        detailFrame.origin.x = 0.0f;
        tableFrame.origin.x = kMenuMinX;
    }
    
    float duration = (ABS(detailFrame.origin.x - _detailNavController.view.frame.origin.x) / [self getMaxX]) * 0.3f;
    float alpha = 1 - (detailFrame.origin.x / [self getMaxX]);
    
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationCurveEaseInOut animations:^{
        _detailNavController.view.frame = detailFrame;
        _tableViewController.view.frame = tableFrame;
        _shadowViewController.view.alpha = alpha;
    } completion:^(BOOL finished){
        // Nothing to see here!!
    }];
}

- (void)showMenu:(id)sender
{
    if (_detailNavController.view.frame.origin.x == [self getMaxX])
    {
        [self snapViewsOpen:NO];
    }
    else
    {
        [self snapViewsOpen:YES];
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
            
            _shadowViewController.view.alpha = 1 - (detailViewFrame.origin.x / [self getMaxX]);
        }
    }
    else if ([gesture state] == UIGestureRecognizerStateEnded)
    {
        if (detailViewFrame.origin.x < [self getMaxX]/ 2.0f)
        {
            [self snapViewsOpen:NO];
        }
        else
        {
            [self snapViewsOpen:YES];
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
