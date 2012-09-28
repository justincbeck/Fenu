//
//  UIImage+Helper.m
//  Fenu
//
//  Created by Justin C. Beck on 9/27/12.
//  Copyright (c) 2012 Justin C. Beck. All rights reserved.
//

#import "UIImage+Helper.h"

@implementation UIImage (Helper)

- (UIImage *)thumbnail
{
    float width = 0.0f;
    float height = 0.0f;
    CGSize size = CGSizeMake(width, height);
    
    if (self.size.width > self.size.height)
    {
        width = self.size.width * (65.0f/self.size.height);
        size = CGSizeMake(width, 65.0f);
    }
    else
    {
        height = (65.0f/self.size.width) * self.size.height;
        size = CGSizeMake(65.0f, height);
    }

    UIGraphicsBeginImageContext(size);
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage= UIGraphicsGetImageFromCurrentImageContext();
    
    struct CGImage *cropped = CGImageCreateWithImageInRect(scaledImage.CGImage, CGRectMake(0.0f, 0.0f, 65.0f, 65.0f));
    UIImage *thumbnail = [UIImage imageWithCGImage:cropped scale:1 orientation:self.imageOrientation];
    CGImageRelease(cropped);
    
    UIGraphicsEndImageContext();
    return thumbnail;
}

@end
