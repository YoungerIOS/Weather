//
//  UIView+ScaleSize.m
//  Weather
//
//  Created by young on 2018/8/6.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "UIView+ScaleSize.h"

@implementation UIView (ScaleSize)

+(CGRect)setFrame:(CGRect)frame{
    
    float a=[UIView setWidth:frame.origin.x];
    float b=[UIView setHeight:frame.origin.y];
    float c=[UIView setWidth:frame.size.width];
    float d=[UIView setHeight:frame.size.height];
    CGRect frame1=CGRectMake(a, b, c, d);
    return frame1;
    
}

+(float)setWidth:(float)width
{
    
    //    return width*WRATIO;
    if (IS_IPAD) {
        return width * H_SCALE;
    }else{
        
        return width * W_SCALE;
    }
    
}

+(float)setHeight:(float)height
{
    
    //    if (IS_IPAD) {
    //        return height *WRATIO;
    //    }else{
    //
    return height * H_SCALE;
    //    }
}

+ (float)setMWidth:(float)width
{
    return width * W_SCALE_PLUS;
}

+ (float)setMHeight:(float)height
{
    return height * H_SCALE_PLUS;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}


@end
