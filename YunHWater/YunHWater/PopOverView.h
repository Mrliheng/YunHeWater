//
//  PopOverView.h
//  YunHWater
//
//  Created by 李 恒 on 16/12/21.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger,PopArrowDirection){
    
    //箭头位置
    WBArrowDirectionUp=0,//中
    WBArrowDirectionLeft,//左
    
    WBArrowDirectionRight,//右

    

    
};
@interface PopOverView : UIView

@property (nonatomic, assign)PopArrowDirection ArrowDirection;
@end
