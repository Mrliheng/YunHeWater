//
//  PopOverView.m
//  YunHWater
//
//  Created by 李 恒 on 16/12/21.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "PopOverView.h"

#define sgBtJ    ((SCREEN_WIDTH-140)/2)    //施工Bt间隙距离
@implementation PopOverView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    // 获取文本
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, 10);
    if(_ArrowDirection==WBArrowDirectionLeft){
        CGContextAddLineToPoint(context, 20,10);
        CGContextAddLineToPoint(context, 30, 0);
        CGContextAddLineToPoint(context, 40,10);
        CGContextAddLineToPoint(context, SCREEN_WIDTH-40,10);
        CGContextAddLineToPoint(context, SCREEN_WIDTH-40,SCREEN_HEIGHT-200);
        CGContextAddLineToPoint(context, 0,SCREEN_HEIGHT-200);
        CGContextAddLineToPoint(context, 0,10);
    }
    else if(_ArrowDirection==WBArrowDirectionUp){
        CGContextAddLineToPoint(context, 20+20+sgBtJ,10);
        CGContextAddLineToPoint(context, 30+20+sgBtJ, 0);
        CGContextAddLineToPoint(context, 40+20+sgBtJ,10);
        CGContextAddLineToPoint(context, SCREEN_WIDTH-40,10);
        CGContextAddLineToPoint(context, SCREEN_WIDTH-40,SCREEN_HEIGHT-200);
        CGContextAddLineToPoint(context, 0,SCREEN_HEIGHT-200);
        CGContextAddLineToPoint(context, 0,10);
    }
    else if(_ArrowDirection==WBArrowDirectionRight){
        CGContextAddLineToPoint(context, 20+40+sgBtJ*2,10);
        CGContextAddLineToPoint(context, 30+40+sgBtJ*2, 0);
        CGContextAddLineToPoint(context, 40+40+sgBtJ*2,10);
        CGContextAddLineToPoint(context, SCREEN_WIDTH-40,10);
        CGContextAddLineToPoint(context, SCREEN_WIDTH-40,SCREEN_HEIGHT-200);
        CGContextAddLineToPoint(context, 0,SCREEN_HEIGHT-200);
        CGContextAddLineToPoint(context, 0,10);
    }
    CGContextClosePath(context);
    //设置颜色 宽度
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    //边框颜色
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextSetLineWidth(context, 1);
    CGContextStrokePath(context);
}


@end
