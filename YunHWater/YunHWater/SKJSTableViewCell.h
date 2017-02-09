//
//  SKJSTableViewCell.h
//  YunHWater
//
//  Created by 李 恒 on 16/12/16.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKJSTableViewCell : UITableViewCell
@property(strong,nonatomic)UILabel *sortLabel;//序号
@property(strong,nonatomic)UILabel *proNameLabel;//标题名称
@property(strong,nonatomic)UILabel *investNumLabel;//投资
@property(strong,nonatomic)UILabel *scheduleLabel;//进度
@property(strong,nonatomic)UIImageView *scheduleView;//进度条
@end
