//
//  ETPOSTViewController.h
//  云和App
//
//  Created by 李 恒 on 16/11/30.
//  Copyright © 2016年 gsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeButton.h"
@interface ETPOSTViewController : UIViewController

@property(nonatomic,strong)NSArray *titleReauleArr;
//帖子板块id
@property(nonatomic,strong)NSNumber *fildId;

//所选发帖的板块id
@property(nonatomic,strong)NSNumber *selectFid;


@property (strong,nonatomic)NSString *titleStr;//项目名称

@property (strong,nonatomic)NSString *jincBtStr;//进程选项的Str

@property (strong,nonatomic)UIButton *ConstructBfBt;//施工前
@property (strong,nonatomic)UIButton *ConstructUnBt;//施工中
@property (strong,nonatomic)UIButton *ConstructAfBt;//施工后
@property (strong,nonatomic)TypeButton *ziBt;//子项
@property (strong,nonatomic)NSMutableArray *ziMutabelArray;//子项内容
@property (nonatomic, strong) UITableView *ziTableview;//子项Tableview
@property (nonatomic) BOOL isDonghua;




@property (nonatomic)BOOL isflowVC;
@end
