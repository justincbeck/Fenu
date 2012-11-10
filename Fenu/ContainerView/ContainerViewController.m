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

#import "HorizontalPanGestureDelegate.h"
#import "VerticalPanGestureDelegate.h"

@interface ContainerViewController ()
{
    NSArray *_dataURLs;
    NSMutableArray *_tableViews;
    
    UINavigationController *_detailNavController;
    
    HorizontalPanGestureDelegate *_horizontalPanGestureDelegate;
    VerticalPanGestureDelegate *_verticalPanGestureDelegate;
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
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        _dataURLs = [defaults objectForKey:@"dataURLs"];
        _tableViews = [[NSMutableArray alloc] init];
        
        _horizontalPanGestureDelegate = [[HorizontalPanGestureDelegate alloc] init];
        
        for (int i = 0; i < 2; i++)
        {
            TableViewController *controller = [[TableViewController alloc] initWithStyle:UITableViewStylePlain];
            controller.dataURL = [_dataURLs objectAtIndex:i];
            controller.view.layer.borderColor = [UIColor lightGrayColor].CGColor;
            controller.view.layer.borderWidth = 1.0f;
            
            [self addChildViewController:controller];
            [controller setContainerViewController:self];
            
            [self.view addSubview:controller.view];
            [_tableViews addObject:controller.view];
            
            float x = (i * 299.0f) + 14.0f;
            controller.view.frame = CGRectMake(x, 0.0f, 292.0f, 568.0f);
            
            UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(horizontalPan:)];
            gestureRecognizer.delegate = _horizontalPanGestureDelegate;
            [controller.view addGestureRecognizer:gestureRecognizer];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)horizontalPan:(id)sender
{
    UIPanGestureRecognizer *gesture = (UIPanGestureRecognizer *) sender;
   
    if (gesture.state == UIGestureRecognizerStateChanged)
    {
        for (UIView *view in _tableViews)
        {
            CGPoint translation = [gesture translationInView:view.superview];
            CGRect frame = view.frame;
            frame.origin.x = frame.origin.x + translation.x;
            view.frame = frame;
        }
        
        [gesture setTranslation:CGPointZero inView:self.view];
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        [self snapViews];
    }
}

- (void)snapViews
{
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationCurveEaseInOut animations:^{
        for (UIView *view in _tableViews)
        {
            CGRect frame = view.frame;
            int index = [_tableViews indexOfObject:view];
            frame.origin.x = (index * 299.0f) + 14.0f;
            view.frame = frame;
        }
    } completion:^(BOOL finished) {
        // Nothing to see here
    }];
}

- (void)entrySelected:(id)entry
{
    return;
}

- (UINavigationController *)createControllerWithEntry:(id)entry
{
    UIPanGestureRecognizer* gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(verticalPanGesture:)];
    [gestureRecognizer setMinimumNumberOfTouches:1];
    [gestureRecognizer setMaximumNumberOfTouches:1];
    
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithEntry:entry];
    
    _detailNavController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    _detailNavController.view.layer.borderWidth = 1.0f;
    _detailNavController.view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _detailNavController.navigationBarHidden = YES;
    
    [_detailNavController.view addGestureRecognizer:gestureRecognizer];
    
    return _detailNavController;
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
