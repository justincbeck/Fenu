//
//  DetailView.h
//  Fenu
//
//  Created by Justin C. Beck on 9/27/12.
//  Copyright (c) 2012 Justin C. Beck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailView : UIView
{
    UILabel *_created;
    UILabel *_title;
    UILabel *_author;
    UIWebView *_content;
}

@property (nonatomic, retain) UILabel *created;
@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UILabel *author;
@property (nonatomic, retain) UIWebView *content;

@end
