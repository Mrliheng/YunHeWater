//
//  FlowViewController.h
//  YunHWater
//
//  Created by 李 恒 on 16/12/16.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlowViewController : UIViewController
@property (strong,nonatomic)NSString *titleStr;//项目名称

@property (nonatomic,strong) UILabel *sgqLabel;//施工前Label
@property (nonatomic,strong) UILabel *sgzLabel;//施工中Label
@property (nonatomic,strong) UILabel *sghLabel;//施工后Label
@property (nonatomic,strong) UIButton *sgqBt;//施工前
@property (nonatomic,strong) UIButton *sgzBt;//施工中
@property (nonatomic,strong) UIButton *sghBt;//施工后

@property (nonatomic,strong) UITableView *flowTableView;//流程内容
@property (nonatomic,strong) UIButton *addFlowBt;//添加内容按钮
@end
