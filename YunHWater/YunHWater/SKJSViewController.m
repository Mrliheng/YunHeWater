//
//  SKJSViewController.m
//  YunHWater
//
//  Created by 李 恒 on 16/12/15.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "SKJSViewController.h"
#import "SKJSTableViewCell.h"
#import "JSIntroViewController.h"


#import "MainViewController.h"
@interface SKJSViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *finshBt;
    UIButton *styleBt;
    UIButton *yearBt;
    UITableView *finshlistView;
    UITableView *stylelistView;
    UITableView *yearlistView;
}
@property (nonatomic,strong)UITextField *searchTextField;
@property (nonatomic,strong)UIButton *searchBt;

@property (nonatomic,retain) NSMutableArray *arr;
@property (nonatomic,retain) NSMutableArray *resultArr;

@property (strong,nonatomic)UITableView *skjsTabelView;
/*
@property (retain,nonatomic)UILabel *proNameLabel;//cell的标题名称
@property (strong,nonatomic)UILabel *investNumLabel;//投资数
@property (strong,nonatomic)UILabel *scheduleLabe;//进度
 */
@property (nonatomic) BOOL isSearch;//判断是否在搜索
@property (nonatomic,strong) SKJSTableViewCell *skjsCell;

@end

@implementation SKJSViewController
- (void)viewWillAppear:(BOOL)animated
{   //设置导航栏半透明为NO
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
    titleView.text = @"水利建设";
    [titleView sizeToFit];
    titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleView;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];//背景颜色
    
//    UITapGestureRecognizer *viewTap= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BtTabeleHidden)];
//    [self.view addGestureRecognizer:viewTap];
    _arr = [[NSMutableArray alloc] initWithObjects:@"云和智慧水利综合管理平台1",@"云和智慧水利综合管理平台12",@"云和智慧水利综合管理平台31",@"云和智慧水利综合管理平台41",@"云和智慧水利综合管理平台55", nil];
    _resultArr = [[NSMutableArray alloc]init];
    
    [self initableview];
    [self creatSearchBar];
    [self creatBt];
    
}
-(void)ViewBack{
    [self.navigationController popViewControllerAnimated:NO];

}
//创建button
-(void)creatBt{
    finshBt = [UIButton new];
    finshBt.layer.masksToBounds = YES;
    finshBt.layer.cornerRadius = 10;
    [finshBt setTitle:@"已完成" forState:UIControlStateNormal];
    finshBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
    [finshBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finshBt addTarget:self action:@selector(onTouch:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:finshBt];
    
    styleBt = [UIButton new];
    styleBt.layer.masksToBounds = YES;
    styleBt.layer.cornerRadius = 10;
    [styleBt setTitle:@"按类型" forState:UIControlStateNormal];
    styleBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
    [styleBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [styleBt addTarget:self action:@selector(onTouch:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:styleBt];
    
    yearBt = [UIButton new];
    yearBt.layer.masksToBounds = YES;
    yearBt.layer.cornerRadius = 10;
    [yearBt setTitle:@"2016年第三批" forState:UIControlStateNormal];
    yearBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
    [yearBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yearBt addTarget:self action:@selector(onTouch:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:yearBt];
    
    finshBt.sd_layout
    .leftSpaceToView(self.view,10)
    .topSpaceToView(self.view,15)
    .widthIs((SCREEN_WIDTH-40)/3)
    .heightIs((SCREEN_HEIGHT/6-55)/2);
    
    styleBt.sd_layout
    .leftSpaceToView(self.view,20+(SCREEN_WIDTH-40)/3)
    .topSpaceToView(self.view,15)
    .widthIs((SCREEN_WIDTH-40)/3)
    .heightIs((SCREEN_HEIGHT/6-55)/2);
    
    yearBt.sd_layout
    .leftSpaceToView(self.view,30+(SCREEN_WIDTH-40)/3*2)
    .topSpaceToView(self.view,15)
    .widthIs((SCREEN_WIDTH-40)/3)
    .heightIs((SCREEN_HEIGHT/6-55)/2);
    
    
    finshlistView = [UITableView new];
    finshlistView.layer.masksToBounds = YES;
    finshlistView.layer.cornerRadius = 5;
    finshlistView.hidden =YES;
    finshlistView.tableFooterView.frame = CGRectZero;
    finshlistView.tableHeaderView.frame = CGRectZero;
    finshlistView.delegate = self;
    finshlistView.dataSource = self;
    finshlistView.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
    [self.view addSubview:finshlistView];
    
    stylelistView = [UITableView new];
    stylelistView.layer.masksToBounds = YES;
    stylelistView.layer.cornerRadius = 5;
    stylelistView.hidden =YES;
    stylelistView.tableFooterView.frame = CGRectZero;
    stylelistView.tableHeaderView.frame = CGRectZero;
    stylelistView.delegate = self;
    stylelistView.dataSource = self;
    stylelistView.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
    [self.view addSubview:stylelistView];
    
    yearlistView = [UITableView new];
    yearlistView.layer.masksToBounds = YES;
    yearlistView.layer.cornerRadius = 5;
    yearlistView.hidden = YES;
    yearlistView.tableFooterView.frame = CGRectZero;
    yearlistView.tableHeaderView.frame = CGRectZero;
    yearlistView.delegate = self;
    yearlistView.dataSource = self;
    yearlistView.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
    [self.view addSubview:yearlistView];
    
    
    finshlistView.sd_layout
    .leftEqualToView(finshBt)
    .topSpaceToView(finshBt,0)
    .widthIs((SCREEN_WIDTH-40)/3)
    .heightIs(60);
    stylelistView.sd_layout
    .leftEqualToView(styleBt)
    .topSpaceToView(styleBt,0)
    .widthIs((SCREEN_WIDTH-40)/3)
    .heightIs(60);
    yearlistView.sd_layout
    .leftEqualToView(yearBt)
    .topSpaceToView(yearBt,0)
    .widthIs((SCREEN_WIDTH-40)/3)
    .heightIs(40);
  
}

//创建SearchBar
-(void)creatSearchBar
{
    _searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, (SCREEN_HEIGHT/6-55)/2+35, SCREEN_WIDTH-110, (SCREEN_HEIGHT/6-55)/2)];
    _searchTextField.placeholder = @"搜索";
    _searchTextField.layer.masksToBounds = YES;
    _searchTextField.layer.borderWidth = 1;
    _searchTextField.layer.borderColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0].CGColor;
    _searchTextField.layer.cornerRadius = 10;
    UITapGestureRecognizer *searchTap= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BtTabeleHidden)];
    [_searchTextField addGestureRecognizer:searchTap];
    [self.view addSubview:_searchTextField];
    
    _searchBt = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, (SCREEN_HEIGHT/6-55)/2+35, 70, (SCREEN_HEIGHT/6-55)/2)];
    _searchBt.layer.masksToBounds = YES;
    _searchBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
    _searchBt.layer.cornerRadius = 5;
    [_searchBt setTitle:@"确定" forState:UIControlStateNormal];
    [_searchBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_searchBt addTarget:self action:@selector(searchChange) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_searchBt];
}


-(void)BtTabeleHidden
{
    finshlistView.hidden = YES;
    stylelistView.hidden = YES;
    yearlistView.hidden = YES;
}

-(void)searchChange
{
    finshlistView.hidden = YES;
    stylelistView.hidden = YES;
    yearlistView.hidden = YES;
    [_searchTextField resignFirstResponder];
    [_resultArr removeAllObjects];
    if (![_searchTextField.text  isEqual: @""]) {
        self.isSearch = YES;
        int i;
        for (i=0; i<_arr.count; i++) {
            if ([_arr[i] rangeOfString:_searchTextField.text].location != NSNotFound) {
                [_resultArr addObject:_arr[i]];
            }
        }
    }else{
        self.isSearch = NO;
        [_resultArr removeAllObjects];
    }
    [_skjsTabelView reloadData];
}

-(void)onTouch:(UIButton *)button{
    [_searchTextField resignFirstResponder];
    if (button==finshBt) {
        stylelistView.hidden = YES;
        yearlistView.hidden = YES;
        if (finshlistView.hidden==YES) {
            finshlistView.hidden = NO;
        }else{
            finshlistView.hidden = YES;
        }
    }
    if (button==styleBt) {
        finshlistView.hidden = YES;
        yearlistView.hidden = YES;
        if (stylelistView.hidden==YES) {
            stylelistView.hidden = NO;
        }else{
            stylelistView.hidden = YES;
        }
    }
    if (button==yearBt) {
        stylelistView.hidden = YES;
        finshlistView.hidden = YES;
        if (yearlistView.hidden==YES) {
            yearlistView.hidden = NO;
        }else{
            yearlistView.hidden = YES;
        }
    }
}

//创建tableview
-(void)initableview
{
    _skjsTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/6, self.view.bounds.size.width, self.view.bounds.size.height/6*5-60) style:UITableViewStylePlain];
    _skjsTabelView.tableFooterView.frame = CGRectZero;
    _skjsTabelView.tableHeaderView.frame = CGRectZero;
    _skjsTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线隐藏
    _skjsTabelView.backgroundColor = [UIColor clearColor];
    _skjsTabelView.delegate = self;
    _skjsTabelView.dataSource = self;
    _skjsTabelView.scrollEnabled =NO; //设置tableview 不能滚动
    [self.view addSubview:_skjsTabelView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//TableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==yearlistView) {
        return 2;
    }else if(tableView==finshlistView){
        return 3;
    }else if(tableView==stylelistView){
        return 3;
    }else{
        if (self.isSearch) {
            return _resultArr.count ;
        }else{
            return _arr.count;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_skjsTabelView) {
        return _skjsTabelView.frame.size.height/5;
    } else {
        return 20;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==finshlistView){
        NSString *CellIdentifier = @"finshCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
        cell.textLabel.textColor = [UIColor whiteColor];
        if(indexPath.row==0)
        {
            cell.textLabel.text = @"按进度";
        }
        if(indexPath.row==1)
        {
            cell.textLabel.text = @"已完成";
        }
        if(indexPath.row==2)
        {
            cell.textLabel.text = @"未完成";
        }
        return cell;
    }
    else if (tableView==stylelistView){
        NSString *CellIdentifier = @"styleCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
        cell.textLabel.textColor = [UIColor whiteColor];
        if(indexPath.row==0)
        {
            cell.textLabel.text = @"按类型";
        }
        if(indexPath.row==1)
        {
            cell.textLabel.text = @"山塘";
        }
        if(indexPath.row==2)
        {
            cell.textLabel.text = @"水库";
        }
        return cell;
    }
    else if (tableView==yearlistView){
        NSString *CellIdentifier = @"yearCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
        cell.textLabel.textColor = [UIColor whiteColor];
        if(indexPath.row==0)
        {
            cell.textLabel.text = @"按年度";
        }
        if(indexPath.row==1)
        {
            cell.textLabel.text = @"2016年第三批";
        }
        return cell;
    }
    else{
        NSString *CellIdentifier = @"skjsCell";
        _skjsCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!_skjsCell)
        {
            _skjsCell = [[SKJSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        _skjsCell.accessoryType = UITableViewCellAccessoryNone;
        if (self.isSearch) {
            _skjsCell.proNameLabel.text = _resultArr[indexPath.row];
        } else {
            _skjsCell.proNameLabel.text = _arr[indexPath.row];
        }
        _skjsCell.sortLabel.text = [NSString stringWithFormat:@"%d",(int)indexPath.row+1];
        _skjsCell.investNumLabel.text = @"总投资：89万";
        _skjsCell.scheduleLabel.text = @"50%";
        _skjsCell.scheduleView.width = 50;
        
        return _skjsCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_skjsTabelView) {
        finshlistView.hidden = YES;
        stylelistView.hidden = YES;
        yearlistView.hidden = YES;
        SKJSTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        JSIntroViewController *jsIntroVC = [[JSIntroViewController alloc]init];
        jsIntroVC.titleStr = cell.proNameLabel.text;
        [self.navigationController pushViewController:jsIntroVC animated:NO];
        
    }else if(tableView==finshlistView){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [finshBt setTitle:cell.textLabel.text forState:UIControlStateNormal];
        finshlistView.hidden =YES;
    }else if(tableView==stylelistView){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [styleBt setTitle:cell.textLabel.text forState:UIControlStateNormal];
        stylelistView.hidden =YES;
    }else{
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [yearBt setTitle:cell.textLabel.text forState:UIControlStateNormal];
        yearlistView.hidden =YES;
    }
    
    [finshlistView deselectRowAtIndexPath:[finshlistView indexPathForSelectedRow] animated:YES];
    [stylelistView deselectRowAtIndexPath:[stylelistView indexPathForSelectedRow] animated:YES];
    [yearlistView deselectRowAtIndexPath:[yearlistView indexPathForSelectedRow] animated:YES];
    [_skjsTabelView deselectRowAtIndexPath:[_skjsTabelView indexPathForSelectedRow] animated:YES];
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
