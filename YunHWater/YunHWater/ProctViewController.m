//
//  ProctViewController.m
//  YunHWater
//
//  Created by 李 恒 on 16/11/8.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "ProctViewController.h"

#import "SKViewController.h"
#import "STViewController.h"
#import "DFViewController.h"
#import "NCGSViewController.h"
#import "SWCZViewController.h"
#import "SDZViewController.h"
#import "YBViewController.h"
@interface ProctViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView *proTabelView;
@property (strong,nonatomic)UIImageView *cellimageView;
@property (strong,nonatomic)UILabel *celltextLabel;
@property (strong,nonatomic)UILabel *numtextLabel;
@end

@implementation ProctViewController
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
    titleView.text = @"水利管理";
    [titleView sizeToFit];
    titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleView;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];//背景颜色
    
    [self initableview];
}

-(void)ViewBack{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initableview
{
    _proTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/12, self.view.bounds.size.width, self.view.bounds.size.height- self.view.bounds.size.height/6-60) style:UITableViewStylePlain];
    _proTabelView.tableFooterView.frame = CGRectZero;
    _proTabelView.tableHeaderView.frame = CGRectZero;
    _proTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线隐藏
    _proTabelView.backgroundColor = [UIColor clearColor];
    _proTabelView.delegate = self;
    _proTabelView.dataSource = self;
    _proTabelView.scrollEnabled =NO; //设置tableview 不能滚动
    [self.view addSubview:_proTabelView];
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
    return _proTabelView.frame.size.height/7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = @"workCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    _cellimageView = [[UIImageView alloc]init];
    [cell.contentView addSubview:_cellimageView];
    _celltextLabel = [[UILabel alloc]init];
    _celltextLabel.textAlignment = NSTextAlignmentLeft;
    _celltextLabel.font =[UIFont systemFontOfSize:self.view.bounds.size.height/40];
    _celltextLabel.textColor = [UIColor blackColor];
    [cell.contentView addSubview:_celltextLabel];
    _numtextLabel = [[UILabel alloc]init];
    _numtextLabel.textAlignment = NSTextAlignmentRight;
    _numtextLabel.font =[UIFont systemFontOfSize:self.view.bounds.size.height/40];
    _numtextLabel.textColor = [UIColor blackColor];
    [cell.contentView addSubview:_numtextLabel];
    
    UIImageView *separatorView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _proTabelView.frame.size.height/7, SCREEN_WIDTH, 1)];
    separatorView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];
    [cell addSubview:separatorView];
    
    
    _cellimageView.sd_layout
    .topSpaceToView(cell.contentView,10)
    .leftSpaceToView(cell.contentView,20)
    .widthIs(_proTabelView.frame.size.height/7-20)
    .heightIs(_proTabelView.frame.size.height/7-20);
    
    _celltextLabel.sd_layout
    .leftSpaceToView(_cellimageView,20)
    .heightIs(_proTabelView.frame.size.height/7);
    
    _numtextLabel.sd_layout
    .rightSpaceToView(cell.contentView,50)
    .heightIs(_proTabelView.frame.size.height/7);
    
    if (indexPath.row == 0 ) {
        _celltextLabel.text = @"水库";
        [_cellimageView setImage:[UIImage imageNamed:@"水库"]];
        _numtextLabel.text = @"23座";
    } else if (indexPath.row == 1){
        _celltextLabel.text = @"山塘";
        [_cellimageView setImage:[UIImage imageNamed:@"山塘"]];
        _numtextLabel.text = @"23座";
    }else if (indexPath.row == 2){
        _celltextLabel.text = @"堤防";
        [_cellimageView setImage:[UIImage imageNamed:@"堤防"]];
        _numtextLabel.text = @"23座";
    }else if (indexPath.row == 3){
        _celltextLabel.text = @"农村供水";
        [_cellimageView setImage:[UIImage imageNamed:@"农村供水"]];
        _numtextLabel.text = @"23座";
    }else if (indexPath.row == 4){
        _celltextLabel.text = @"水文测站";
        [_cellimageView  setImage:[UIImage imageNamed:@"水文测站"]];
        _numtextLabel.text = @"23座";
    }else if (indexPath.row == 5){
        _celltextLabel.text = @"水电站";
        [_cellimageView setImage:[UIImage imageNamed:@"水电站"]];
        _numtextLabel.text = @"23座";
    }
    else if (indexPath.row == 6){
        _celltextLabel.text = @"堰坝";
        [_cellimageView setImage:[UIImage imageNamed:@"堰坝"]];
        _numtextLabel.text = @"23座";
        separatorView.hidden = YES;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        SKViewController *SKVC = [[SKViewController alloc]init];
        [self.navigationController pushViewController:SKVC animated:NO];
    }
    if (indexPath.row==1) {
        STViewController *STVC= [[STViewController alloc]init];
        [self.navigationController pushViewController:STVC animated:NO];
    }
    if (indexPath.row==2) {
        DFViewController *DFVC = [[DFViewController alloc]init];
        [self.navigationController pushViewController:DFVC animated:NO];
    }
    if (indexPath.row==3) {
        NCGSViewController *NCGSVC = [[NCGSViewController alloc]init];
        [self.navigationController pushViewController:NCGSVC animated:NO];
    }
    if (indexPath.row==4) {
        SWCZViewController *SWCZVC = [[SWCZViewController alloc]init];
        [self.navigationController pushViewController:SWCZVC animated:NO];
    }
    if (indexPath.row==5) {
        SDZViewController *SDZVC = [[SDZViewController alloc]init];
        [self.navigationController pushViewController:SDZVC animated:NO];
    }
    if (indexPath.row==6) {
        YBViewController *YBVC = [[YBViewController alloc]init];
        [self.navigationController pushViewController:YBVC animated:NO];
    }
    [_proTabelView deselectRowAtIndexPath:[_proTabelView indexPathForSelectedRow] animated:YES];
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
