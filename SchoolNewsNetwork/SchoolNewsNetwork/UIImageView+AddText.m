//
//  UIImageView+AddText.m
//  SchoolNewsNetwork
//
//  Created by heyuqing on 14-9-11.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import "UIImageView+AddText.h"

@implementation UIImageView (AddText)

-(void)addText:(NSString *)text
{
    int w = self.bounds.size.width;
    int h = self.bounds.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), self.image.CGImage);
    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1);
    char* textCh = (char *)[text cStringUsingEncoding:NSASCIIStringEncoding];
    CGContextSelectFont(context, "Georgia", 15, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
    
    //位置调整
    CGContextShowTextAtPoint(context, w/2-strlen(textCh)*3 , h/2, textCh, strlen(textCh));
    
    //Create image ref from the context
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    [self setImage: [UIImage imageWithCGImage:imageMasked]];
}
@end
