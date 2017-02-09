//
//  HomeViewController.h
//  YunHWater
//
//  Created by 李 恒 on 16/10/12.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *colletionView;//主界面
@property (strong,nonatomic) UIView *CeHuaView;//侧滑界面
@property (strong,nonatomic) UIView *bageView;//侧滑界面切换后的半透明区域
@property (strong,nonatomic) UILabel *Blabel;//主界面的标题
@property (strong,nonatomic) UIButton *leftBt;//设置按钮
@property (strong,nonatomic) UIButton *RightBt;//地图按钮
@property (strong,nonatomic) UITapGestureRecognizer *tapGesture;//半透明区域点击事件

@property (strong,nonatomic) UIImageView *headView;//头像
@property (strong,nonatomic) UILabel *usernameLabel;//用户名
@property (strong,nonatomic) UITableView *menuxTableView;//侧滑菜单
@end
