//
//  JSIntroViewController.m
//  YunHWater
//
//  Created by 李 恒 on 16/12/16.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "JSIntroViewController.h"
#import "FlowViewController.h"
#import "ETPOSTViewController.h"
@interface JSIntroViewController ()<UIScrollViewDelegate>

@end

@implementation JSIntroViewController
-(void)viewWillAppear:(BOOL)animated{
    //设置导航栏半透明为NO
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setImage:[[UIImage imageNamed:@"返回1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ViewBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectZero];
    titleView.font = [UIFont fontWithName:@"Futura-Medium" size:19];
    titleView.textColor = [UIColor colorWithRed:0.333333 green:0.333333 blue:0.333333 alpha:1.0];
    titleView.text = _titleStr;
    [titleView sizeToFit];
    titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleView;
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(0, 0, 24,24);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"发送添加"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(lookSend) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];//背景颜色
    [self creatUI];
}
-(void)ViewBack{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)lookSend{
    ETPOSTViewController *etPostVC = [[ETPOSTViewController alloc]init];
    etPostVC.titleStr = _titleStr;
    etPostVC.isflowVC = NO;
    [self.navigationController pushViewController:etPostVC animated:NO];
}
-(void)creatUI{
    //项目图片
    UIImageView *proImageview = [[UIImageView alloc]initWithFrame:CGRectMake(15, 20, (SCREEN_HEIGHT-60)/4-40, (SCREEN_HEIGHT-60)/4-40)];
    proImageview.backgroundColor = [UIColor blueColor];
    [self.view addSubview:proImageview];

    //项目名称
    UILabel *proName = [[UILabel alloc]init];
    proName.textColor = [UIColor colorWithRed:89/255.0 green:117/255.0 blue:72/255.0 alpha:1.0];
    proName.textAlignment = NSTextAlignmentLeft;
    proName.text = _titleStr;
    CGSize maximumLabelSize = CGSizeMake(SCREEN_WIDTH-(SCREEN_HEIGHT-60)/4-10, 25);
    CGSize expectSize = [proName sizeThatFits:maximumLabelSize];
    proName.frame = CGRectMake((SCREEN_HEIGHT-60)/4-5,20,expectSize.width,expectSize.height);
    [self.view addSubview:proName];
    
    //负责人
    UILabel *principal = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_HEIGHT-60)/4-5, 60, SCREEN_WIDTH-(SCREEN_HEIGHT-60)/4-10, 25)];
    principal.textColor = [UIColor blackColor];
    principal.textAlignment = NSTextAlignmentLeft;
    principal.font = [UIFont systemFontOfSize:15];
    principal.text = @"负责人：xxx";
    [self.view addSubview:principal];
    
    //详情资料视图
    
    //文字滚动视图
    UIScrollView *labelScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0,(SCREEN_HEIGHT-60)/4+20,SCREEN_WIDTH , (SCREEN_HEIGHT-60)/4*3-80)];
    labelScroll.backgroundColor = [UIColor whiteColor];
    labelScroll.scrollEnabled = YES;
    [self.view addSubview:labelScroll];

    //文字视图
    UILabel *labelView = [[UILabel alloc]init];
    NSString *string = @"其实，经年过往，每个人何尝不是在这场虚妄里跋涉？在真实的笑里哭着，在真实的哭里笑着，一笺烟雨，半帘幽梦，许多时候，我们不得不承认：生活，不是不寂寞，只是不想说。\n于无声处倾听凡尘落素，渐渐明白：人生，总会有许多无奈，希望、失望、憧憬、彷徨，苦过了，才知甜蜜；痛过了，才懂坚强；傻过了，才会成长。\n其实，经年过往，每个人何尝不是在这场虚妄里跋涉？在真实的笑里哭着，在真实的哭里笑着，一笺烟雨，半帘幽梦，许多时候，我们不得不承认：生活，不是不寂寞，只是不想说。\n于无声处倾听凡尘落素，渐渐明白：人生，总会有许多无奈，希望、失望、憧憬、彷徨，苦过了，才知甜蜜；痛过了，才懂坚强；傻过了，才会成长。\n生命中，总有一些令人唏嘘的空白，有些人，让你牵挂，却不能相守；有些东西，让你羡慕，却不能拥有；有些错过，让你留恋，却终生遗憾。\n在这喧闹的凡尘，我们需要有适合自己的地方，用来安放灵魂。\n也许，是一座安静宅院；也许，是一本无字经书；也许，是一条迷津小路。只要是自己心之所往，便是驿站，为了将来起程时，不再那么迷惘。\n红尘三千丈，念在山水间。生活，不总是一帆风顺。因为爱，所以放手；因为放手，所以沉默；因为一份懂得，所以安心着一个回眸。\n也许，有风有雨的日子，才承载了生命的厚重；风轻云淡的日子，更适于静静领悟。";
    CGRect r = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-10,10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f]} context:nil];
    
    labelView.frame = CGRectMake(5, 0, SCREEN_WIDTH-10, r.size.height);
    labelScroll.contentSize = CGSizeMake(SCREEN_WIDTH, r.size.height);
    labelView.text = string;
    labelView.numberOfLines = 0;
    labelView.backgroundColor = [UIColor whiteColor];
    labelView.textColor = [UIColor blackColor];
    [labelScroll addSubview:labelView];
    
    //资金数
    UIButton *zijinBt = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-120, SCREEN_WIDTH/3, 60)];
    zijinBt.layer.masksToBounds = YES;
    zijinBt.layer.borderColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0].CGColor;
    zijinBt.layer.borderWidth = 1;
    [zijinBt setTitle:@"资金：89万" forState:UIControlStateNormal];
    zijinBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
    [zijinBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:zijinBt];
    
    //进度
    UIButton *jinduBt = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, SCREEN_HEIGHT-120, SCREEN_WIDTH/3, 60)];
    jinduBt.layer.masksToBounds = YES;
    jinduBt.layer.borderColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0].CGColor;
    jinduBt.layer.borderWidth = 1;
    [jinduBt setTitle:@"进度：50%" forState:UIControlStateNormal];
    jinduBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
    [jinduBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:jinduBt];
    
    //时间轴
    UIButton *timeBt = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, SCREEN_HEIGHT-120, SCREEN_WIDTH/3, 60)];
    timeBt.layer.masksToBounds = YES;
    timeBt.layer.borderColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0].CGColor;
    timeBt.layer.borderWidth = 1;
    [timeBt setTitle:@"流程" forState:UIControlStateNormal];
    timeBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
    [timeBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [timeBt addTarget:self action:@selector(pushTimeVc) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:timeBt];
}

-(void)pushTimeVc{
    FlowViewController *flowVC = [[FlowViewController alloc]init];
    [self.navigationController pushViewController:flowVC animated:NO];
    flowVC.titleStr = _titleStr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
