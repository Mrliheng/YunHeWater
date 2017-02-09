//
//  textFieldBackground.m
//  YunHWater
//
//  Created by 李 恒 on 16/10/12.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "textFieldBackground.h"

@implementation textFieldBackground

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,0.2);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 5, 50);
    CGContextAddLineToPoint(context,self.frame.size.width-5, 50);
    CGContextClosePath(context);
    [[UIColor grayColor] setStroke];
    CGContextStrokePath(context);
}

@end
