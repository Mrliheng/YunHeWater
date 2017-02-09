//
//  HomeViewController.m
//  YunHWater
//
//  Created by 李 恒 on 16/10/12.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "HomeViewController.h"
#import "CZCell.h"
#import "KxMenu.h"
#import "ETPOSTViewController.h"
#import "MapViewController.h"
#import "SKJSViewController.h"
#import "ProctViewController.h"



@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>

@end

@implementation HomeViewController
- (void)viewWillAppear:(BOOL)animated
{   //设置导航栏半透明为NO
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title =@"首页";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"主界面.jpg"]];
    
//    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    leftBtn.frame = CGRectMake(0, 0, 25,25);
//    leftBtn.backgroundColor = [UIColor blueColor];
//    [leftBtn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(showMenux:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
//    
//    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    rightBtn.frame = CGRectMake(0, 0, 25,25);
//    rightBtn.backgroundColor = [UIColor blueColor];
//    [rightBtn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(mapShow) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [self initcollectionView];
//    [self initCeHuaView];
}

//侧滑界面初始化
-(void)initCeHuaView{
    _CeHuaView = [[UIView alloc]init];
    _CeHuaView.frame = CGRectMake(-self.view.bounds.size.width/3*2, 0, self.view.bounds.size.width/3*2, self.view.bounds.size.height);
    _CeHuaView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_CeHuaView];
    
    [self setCeHuaview];
}

//设置侧滑界面
-(void)setCeHuaview{
    //头像
    _headView = [[UIImageView alloc]initWithFrame:CGRectMake(_CeHuaView.frame.size.width/3, 50, _CeHuaView.frame.size.width/3, _CeHuaView.frame.size.width/3)];
    _headView.backgroundColor = [UIColor whiteColor];
    _headView.layer.masksToBounds = YES;
    _headView.layer.cornerRadius = _headView.frame.size.width/2;
    [_CeHuaView addSubview:_headView];
    
    //用户名
    _usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50+_CeHuaView.frame.size.width/3, _CeHuaView.frame.size.width, 30)];
    _usernameLabel.textAlignment = NSTextAlignmentCenter;
    _usernameLabel.textColor = [UIColor blackColor];
    _usernameLabel.font = [UIFont systemFontOfSize:15];
    _usernameLabel.text = @"Love无悔";
    [_CeHuaView addSubview:_usernameLabel];
    
    //菜单
    _menuxTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _CeHuaView.frame.size.height/3, _CeHuaView.frame.size.width, _CeHuaView.frame.size.height/2) style:UITableViewStylePlain];
    _menuxTableView.tableFooterView.frame = CGRectZero;
    _menuxTableView.tableHeaderView.frame = CGRectZero;
    _menuxTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线隐藏
    _menuxTableView.backgroundColor = [UIColor whiteColor];
    _menuxTableView.delegate = self;
    _menuxTableView.dataSource = self;
    _menuxTableView.scrollEnabled =NO; //设置tableview 不能滚动
    [_CeHuaView addSubview:_menuxTableView];
}

//主界面初始化
-(void)initcollectionView
{
    _colletionView.frame = self.view.bounds;
    _colletionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"主界面.jpg"]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _colletionView.delegate = self;
    _colletionView.dataSource = self;
    [self.view addSubview:_colletionView];
    [self setcolletionView];
    
//    _bageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/3, self.view.bounds.size.height)];
//    _bageView.backgroundColor = [UIColor grayColor];
//    _bageView.alpha = 0.3;
//    _bageView.hidden = YES;
//    [_colletionView addSubview:_bageView];
//    
//    _tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SetMenuxShow)];
//    [_bageView addGestureRecognizer:_tapGesture];
}

//设置主界面
-(void)setcolletionView{
    _Blabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/8, self.view.bounds.size.width, self.view.bounds.size.height/12)];
    _Blabel.textAlignment = NSTextAlignmentCenter;
    [_Blabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:self.view.bounds.size.height/24]];
    _Blabel.textColor = [UIColor whiteColor];
    _Blabel.text = @"云和县智慧水利";
    [_colletionView addSubview:_Blabel];
    
//    _leftBt = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 30, 30)];
//    [_leftBt setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
//    [_leftBt addTarget:self action:@selector(SetMenuxShow) forControlEvents:UIControlEventTouchDown];
//    [_colletionView addSubview:_leftBt];
    
    _RightBt = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-50, 20, 30, 30)];
    [_RightBt setImage:[UIImage imageNamed:@"map"] forState:UIControlStateNormal];
    [_RightBt addTarget:self action:@selector(mapShow) forControlEvents:UIControlEventTouchDown];
    [_colletionView addSubview:_RightBt];
    
}

//_colletionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  6;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CZCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    cell.numLabel.frame = CGRectMake(20, 0, cell.frame.size.width, 50);
    cell.numLabel.textAlignment = NSTextAlignmentLeft;
    cell.numLabel.textColor = [UIColor whiteColor];
    [cell.numLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    
    cell.cellImage.frame = CGRectMake(cell.frame.size.width/5*3-30, cell.frame.size.height/5*3-30, cell.frame.size.width/5*2, cell.frame.size.height/5*2);
    
    switch (indexPath.row) {
        case 0:
            cell.backgroundColor = [UIColor colorWithRed:243/255.0 green:107/255.0 blue:111/255.0 alpha:1.0];
            cell.numLabel.text = @"水利建设";

            cell.cellImage.image = [UIImage imageNamed:@"水利建设"];
            break;
        case 1:
            cell.backgroundColor = [UIColor colorWithRed:251/255.0 green:171/255.0 blue:78/255.0 alpha:1.0];
            cell.numLabel.text = @"水利管理";

            cell.cellImage.image = [UIImage imageNamed:@"水利管理"];
            break;
        case 2:
            cell.backgroundColor = [UIColor colorWithRed:38/255.0 green:77/255.0 blue:153/255.0 alpha:1.0];
            cell.numLabel.text = @"河道水事监管";

            cell.cellImage.image = [UIImage imageNamed:@"河道水事监管"];
            break;
        case 3:
            cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:193/255.0 blue:103/255.0 alpha:1.0];
            cell.numLabel.text = @"水资源管理";

            cell.cellImage.image = [UIImage imageNamed:@"水资源管理"];
            break;
        case 4:
            cell.backgroundColor = [UIColor colorWithRed:143/255.0 green:44/255.0 blue:221/255.0 alpha:1.0];
            cell.numLabel.text = @"山洪灾害测试";

            cell.cellImage.image = [UIImage imageNamed:@"山洪灾害"];
            break;
        case 5:
            cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:171/255.0 blue:139/255.0 alpha:1.0];
            cell.numLabel.text = @"设置";

            cell.cellImage.image = [UIImage imageNamed:@"设置"];
            break;
            
        default:
            break;
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        SKJSViewController *SKJSVC= [[SKJSViewController alloc]init];
        [self.navigationController pushViewController:SKJSVC animated:NO];
    }
    if (indexPath.row==1) {
        ProctViewController *proVC= [[ProctViewController alloc]init];
        [self.navigationController pushViewController:proVC animated:NO];
    }
    if (indexPath.row==2) {
       
    }
    if (indexPath.row==3) {
        
    }
    if (indexPath.row==4) {
       
    }
    if (indexPath.row==5) {
        
    }
    
    
    
}


//TableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _menuxTableView.frame.size.height/7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = @"workCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor orangeColor];
    //设置cell.textLabel
    cell.textLabel.font = [UIFont systemFontOfSize:self.view.bounds.size.height/40];
    cell.textLabel.textColor = [UIColor blackColor];
    if (indexPath.row == 0 ) {
        cell.textLabel.text = @"个人信息";
    } else if (indexPath.row == 1){
        cell.textLabel.text = @"我的收藏";
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"已办文件";
    }
    else if (indexPath.row == 3){
        cell.textLabel.text = @"待办文件";
    }
    else if (indexPath.row == 4){
        cell.textLabel.text = @"发帖";
    }
    else if (indexPath.row == 5){
        cell.textLabel.text = @"注销";
    }
    else if (indexPath.row == 6){
        cell.textLabel.text = @"退出";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4){
        ETPOSTViewController *etpost = [[ETPOSTViewController alloc]init];
        [self.navigationController pushViewController:etpost animated:NO];
    }
    if (indexPath.row == 5){
        [self exitID];
    }
    else if (indexPath.row == 6){
        [self exitApplication];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//侧滑界面切换
-(void)SetMenuxShow
{
    
    if (_colletionView.frame.origin.x == 0 ) {
        _CeHuaView.frame = CGRectMake(0, 0, self.view.bounds.size.width/3*2, self.view.bounds.size.height);
        _colletionView.frame = CGRectMake(self.view.bounds.size.width/3*2, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        _bageView.hidden = NO;
    }else{
        _CeHuaView.frame = CGRectMake(-self.view.bounds.size.width/3*2, 0, self.view.bounds.size.width/3*2, self.view.bounds.size.height);
        _colletionView.frame = self.view.bounds;
        _bageView.hidden = YES;
    }
}

//地图显示
- (void)mapShow
{
    UIViewController *mapVC;
    mapVC = [[MapViewController alloc]init];
    [self.navigationController pushViewController:mapVC animated:YES];
}

//弹窗菜单
- (void)showMenux:(UIButton *)sender
{
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"注销"
                     image:nil
                    target:self
                    action:@selector(exitID)],
      
      [KxMenuItem menuItem:@"退出"
                     image:nil
                    target:self
                    action:@selector(exitApplication)],
      ];
    CGRect f = sender.frame;
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(f.origin.x, -f.origin.y, f.size.width, f.size.height)
                 menuItems:menuItems];
    
}
//退出当前账号
- (void)exitID{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];           //获取注销后要跳转的页面
    id view = [storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
    [self presentViewController:view animated:YES completion:^{
        
    }];
}

//退出APP
- (void)exitApplication
{
   exit(0);
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
