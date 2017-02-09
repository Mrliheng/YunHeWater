//
//  MainButton.m
//  YunHWater
//
//  Created by 李 恒 on 16/12/19.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "MainButton.h"

@implementation MainButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor =  [UIColor colorWithRed:251/255.0 green:171/255.0 blue:78/255.0 alpha:1.0];
        
        self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, frame.size.width, 50)];
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        self.textLabel.textColor = [UIColor whiteColor];
        [self.textLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        [self addSubview:self.textLabel];
        
        self.MainimageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/5*3-30, frame.size.height/5*3-30, frame.size.width/5*2, frame.size.height/5*2)];
        [self addSubview:self.MainimageView];
        

    }
    return self;
}
@end
