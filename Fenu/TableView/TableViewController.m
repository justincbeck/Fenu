//
//  TableViewController.m
//  Fenu
//
//  Created by Justin C. Beck on 9/15/12.
//  Copyright (c) 2012 Justin C. Beck. All rights reserved.
//

#import "TableViewCell.h"
#import "TableViewController.h"
#import "ContainerViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <QuartzCore/QuartzCore.h>

@interface TableViewController ()
{
    UITableViewStyle _tableViewStyle;
    NSArray *_data;
}
@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _tableViewStyle = style;
        _data = [[NSArray alloc] init];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self refresh];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self refresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh
{
    NSURL *url = [NSURL URLWithString:@"http://breakingmedia.willowtreemobile.com/dealbreaker.json?limit=10"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        [self stopLoading];

        _data = [(NSDictionary *)JSON objectForKey:@"entries"];
        
        [[self tableView] reloadData];
        
    } failure:nil];

    [operation start];
}

- (UIImage *)cropImage:(UIImage *)image
{
    return nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    if (_data.count > 0)
    {
        NSDictionary *entry = [_data objectAtIndex:[indexPath row]];
        
        NSString *imageURL = [entry objectForKey:@"image"];
        NSString *author = [entry objectForKey:@"author"];
        NSString *title = [entry objectForKey:@"title"];
        NSDate *created = [NSDate dateWithTimeIntervalSince1970:[[entry objectForKey:@"updated"] intValue]];
        
        NSError *error = nil;
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:imageURL]];
        [request setTimeoutInterval:25.0];
        
        NSData *imageData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        UIImage *image = [UIImage imageWithData:imageData];

        if (image == nil)
        {
            image = [UIImage imageNamed:@"stock-image"];
        }
        
        // TODO: Not so sure about this scaling and the CGRect size being used here - JCB
        struct CGImage *cropped = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(image.size.width/2 - 65.0f, 0.0f, 130.0f, 130.0f));
        
        cell.author.text = author;
        cell.textLabel.text = title;
        cell.detailTextLabel.text = created.description;
        cell.imageView.image = [UIImage imageWithCGImage:cropped scale:2 orientation:image.imageOrientation];
        
        CGImageRelease(cropped);
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [((ContainerViewController *)self.parentViewController) entrySelected:[_data objectAtIndex:[indexPath row]]];
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.0f;
}

@end
