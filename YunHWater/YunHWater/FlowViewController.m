//
//  FlowViewController.m
//  YunHWater
//
//  Created by 李 恒 on 16/12/16.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "FlowViewController.h"
#import "ETPOSTViewController.h"

#import "SKJSViewController.h"
#import "PopOverView.h"

#import "Demo9Model.h"
#import "DemoVC9Cell.h"
#define kDemoVC9CellId @"demovc9cell"

#define sgLabelJ    ((SCREEN_WIDTH-220)/2) //施工Label间隙距离
#define sgBtJ    ((SCREEN_WIDTH-140)/2)    //施工Bt间隙距离



@interface FlowViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)PopOverView *popOver;
@property (nonatomic) NSString *sgStr;

@property (nonatomic, strong) NSMutableArray *modelsArray;
@end

@implementation FlowViewController

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
    
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];//背景颜色
    [self creatFlowUI];
}
-(void)ViewBack{
    for (UIViewController *skjsVC in self.navigationController.viewControllers) {
        if ([skjsVC isKindOfClass:[SKJSViewController class]]) {
            [self.navigationController popToViewController:skjsVC animated:YES];
        }
    }
}
-(void)creatFlowUI{
    //创建Button部分
    [self creatFlowBt];
    
    //创建poperView
    [self creatpoperView];
}
//创建Button部分
-(void)creatFlowBt{
    
    //施工前Label
    _sgqLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 60, 20)];
    _sgqLabel.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
    _sgqLabel.textAlignment = NSTextAlignmentCenter;
    _sgqLabel.text = @"施工前";
    _sgqLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_sgqLabel];
    
    //施工中Label
    _sgzLabel = [[UILabel alloc]initWithFrame:CGRectMake(80+sgLabelJ, 30, 60, 20)];
    _sgzLabel.textColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
    _sgzLabel.textAlignment = NSTextAlignmentCenter;
    _sgzLabel.text = @"施工中";
    _sgzLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_sgzLabel];
    
    
    //施工后Label
    _sghLabel = [[UILabel alloc]initWithFrame:CGRectMake(140+sgLabelJ*2, 30, 60, 20)];
    _sghLabel.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
    _sghLabel.textAlignment = NSTextAlignmentCenter;
    _sghLabel.text = @"施工后";
    _sghLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_sghLabel];
    
    _sgStr = _sgzLabel.text;
    
    //施工前Bt
    _sgqBt = [[UIButton alloc]initWithFrame:CGRectMake(40, 55, 20, 20)];
    _sgqBt.layer.cornerRadius = 10;
    _sgqBt.layer.borderWidth= 1;
    _sgqBt.layer.borderColor =[UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0].CGColor;
    _sgqBt.backgroundColor = [UIColor clearColor];
    [_sgqBt addTarget:self action:@selector(changeSgBt:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_sgqBt];
    
    UIView *spacingView1 = [[UIView alloc]initWithFrame:CGRectMake(60, 64, sgBtJ, 2)];
    spacingView1.backgroundColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
    [self.view addSubview:spacingView1];
    
    //施工中Bt
    _sgzBt = [[UIButton alloc]initWithFrame:CGRectMake(60+sgBtJ, 55, 20, 20)];
    _sgzBt.layer.cornerRadius = 10;
    _sgzBt.layer.borderWidth= 1;
    _sgzBt.layer.borderColor =[UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0].CGColor;
    _sgzBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
    [_sgzBt addTarget:self action:@selector(changeSgBt:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_sgzBt];
    
    UIView *spacingView2 = [[UIView alloc]initWithFrame:CGRectMake(80+sgBtJ, 64, sgBtJ, 2)];
    spacingView2.backgroundColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
    [self.view addSubview:spacingView2];
    
    //施工后Bt
    _sghBt = [[UIButton alloc]initWithFrame:CGRectMake(80+sgBtJ*2, 55, 20, 20)];
    _sghBt.layer.cornerRadius = 10;
    _sghBt.layer.borderWidth= 1;
    _sghBt.layer.borderColor =[UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0].CGColor;
    _sghBt.backgroundColor = [UIColor clearColor];
    [_sghBt addTarget:self action:@selector(changeSgBt:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_sghBt];
    
    
    
    
}

//创建poperView
-(void)creatpoperView
{
    _popOver=[[PopOverView alloc]initWithFrame:CGRectMake(20, 80, SCREEN_WIDTH-40, SCREEN_HEIGHT-200)];
    _popOver.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_popOver];
    
    //流程信息
    _flowTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, _popOver.size.width, _popOver.size.height-30) style:UITableViewStylePlain];
    _flowTableView.tableHeaderView.size = CGSizeZero;
//    _flowTableView.tableFooterView.size = CGSizeZero;
    _flowTableView.delegate = self;
    _flowTableView.dataSource = self;
    
    [self creatModelsWithCount:10];
    [_flowTableView registerClass:[DemoVC9Cell class] forCellReuseIdentifier:kDemoVC9CellId];
    [_popOver addSubview:_flowTableView];
    
    //流程按钮
    _addFlowBt = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-150, 60, 60)];
    _addFlowBt.layer.cornerRadius = 30;
    [_addFlowBt setImage:[UIImage imageNamed:@"flowAdd"] forState:UIControlStateNormal];
    [_addFlowBt addTarget:self action:@selector(addXinxi) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_addFlowBt];
}

//选择施工前中后
-(void)changeSgBt:(UIButton *)sgButton
{
    [_flowTableView reloadData];
    if (sgButton == _sgqBt) {
        _sgStr = _sgqLabel.text;
        _popOver.ArrowDirection = WBArrowDirectionLeft;
        [_popOver setNeedsDisplay];
        
        _sgqBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
        _sgzBt.backgroundColor = [UIColor clearColor];
        _sghBt.backgroundColor = [UIColor clearColor];
        
        _sgqLabel.textColor =[UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
        _sgzLabel.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
        _sghLabel.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
    }
    if (sgButton == _sgzBt) {
        _sgStr = _sgzLabel.text;
        
        
        _popOver.ArrowDirection = WBArrowDirectionUp;
        [_popOver setNeedsDisplay];
        _sgzBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
        _sgqBt.backgroundColor = [UIColor clearColor];
        _sghBt.backgroundColor = [UIColor clearColor];
        
        _sgzLabel.textColor =[UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
        _sgqLabel.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
        _sghLabel.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
    }
    if (sgButton == _sghBt) {
        _sgStr = _sghLabel.text;
        _popOver.ArrowDirection = WBArrowDirectionRight;
        [_popOver setNeedsDisplay];
        _sghBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
        _sgzBt.backgroundColor = [UIColor clearColor];
        _sgqBt.backgroundColor = [UIColor clearColor];
        
        _sghLabel.textColor =[UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
        _sgzLabel.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
        _sgqLabel.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
    }
}


//添加信息
-(void)addXinxi{
    ETPOSTViewController *etpostVC= [[ETPOSTViewController alloc]init];
    etpostVC.isflowVC = YES;
    etpostVC.jincBtStr = _sgStr;
    etpostVC.titleStr = _titleStr;
    [self.navigationController pushViewController:etpostVC animated:NO];
}

#pragma mark - PopoverDelegare -
-(BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController{
    return YES;
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)creatModelsWithCount:(NSInteger)count
{
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray new];
    }
    
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *namesArray = @[@"GSD_iOS",
                            @"风口上的猪",
                            @"当今世界网名都不好起了",
                            @"我叫郭德纲",
                            @"Hello Kitty"];
    
    NSArray *styleArray = @[@"qwww",
                            @"fdsafda",
                            @"afdsf",
                            @"zxv",
                            @"fhsh"];
    
    NSArray *textArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
                           ];
    
    NSArray *picImageNamesArray = @[ @"pic0.jpg",
                                     @"pic1.jpg",
                                     @"pic2.jpg",
                                     @"pic3.jpg",
                                     @"pic4.jpg",
                                     @"pic5.jpg",
                                     @"pic6.jpg",
                                     @"pic7.jpg",
                                     @"pic8.jpg"
                                     ];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int styleRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        
        Demo9Model *model = [Demo9Model new];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandomIndex];
        model.styleStr = styleArray[styleRandomIndex];
        model.content = textArray[contentRandomIndex];
        
        
        // 模拟“随机图片”
        int random = arc4random_uniform(10);
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(9);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            model.picNamesArray = [temp copy];
        }
        
        [self.modelsArray addObject:model];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DemoVC9Cell *cell = [tableView dequeueReusableCellWithIdentifier:kDemoVC9CellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.modelsArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    CGFloat h = [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH-40 tableView:_flowTableView];
    return h;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
