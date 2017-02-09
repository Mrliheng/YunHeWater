//
//  SKStyleViewController1.m
//  YunHWater
//
//  Created by 李 恒 on 16/12/13.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "SKStyleViewController1.h"
#import "SKMatterController.h"

@interface SKStyleViewController1 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *vcTableview1;
@property (nonatomic, strong) NSMutableArray *photoListArray;//图片列表

@end

@implementation SKStyleViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setImage:[[UIImage imageNamed:@"返回1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ViewBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    
    _photoListArray = [@[@"photo_sample_01",
                        @"photo_sample_02",
                        @"photo_sample_03",
                        @"photo_sample_04",
                        @"photo_sample_05",
                        @"photo_sample_06",
                        @"photo_sample_07",
                        @"photo_sample_08",] mutableCopy];
    self.view.backgroundColor = [UIColor whiteColor];
    _vcTableview1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT-100)) style:UITableViewStylePlain];
    _vcTableview1.delegate = self;
    _vcTableview1.dataSource = self;
    _vcTableview1.tableHeaderView.size = CGSizeZero;
    _vcTableview1.tableFooterView.size = CGSizeZero;
    [self.view addSubview:_vcTableview1];
}

-(void)ViewBack{
    [self.navigationController popViewControllerAnimated:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _photoListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"PlayListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: cellIdentifier];
        
    }
    UIImageView *cellImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_HEIGHT-100)/6-10, (SCREEN_HEIGHT-100)/6-10)];
    [cell.contentView addSubview:cellImageView];
    cellImageView.image = [UIImage imageNamed:_photoListArray[indexPath.row]];
    cellImageView.sd_layout
    .bottomSpaceToView(cell.contentView,5)
    .topSpaceToView(cell.contentView,5)
    .leftSpaceToView(cell.contentView,10);
    //标题
    UILabel* textlabel = [[UILabel alloc]init];
    textlabel.font = [UIFont systemFontOfSize:20];
    textlabel.textAlignment = NSTextAlignmentLeft;
    textlabel.textColor = [UIColor blackColor];
    textlabel.text =@"xxx水库";
    [cell.contentView addSubview:textlabel];
    //副标题
    UILabel* subheadtextlabel = [[UILabel alloc]init];
    subheadtextlabel.font = [UIFont systemFontOfSize:15];
    subheadtextlabel.textAlignment = NSTextAlignmentLeft;
    subheadtextlabel.textColor = [UIColor colorWithRed:242/255 green:242/255 blue:242/255 alpha:0.7];
    subheadtextlabel.text =@"xxx副标题";
    [cell.contentView addSubview:subheadtextlabel];
    
    textlabel.sd_layout
    .topSpaceToView(cell.contentView,(SCREEN_HEIGHT-100)/12-30)
    .rightSpaceToView(cell.contentView,0)
    .widthIs(SCREEN_WIDTH-(SCREEN_HEIGHT-100)/6-30)
    .heightIs(30);
    subheadtextlabel.sd_layout
    .topSpaceToView(textlabel,5)
    .rightSpaceToView(cell.contentView,0)
    .widthIs(SCREEN_WIDTH-(SCREEN_HEIGHT-100)/6-30)
    .heightIs(20);
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKMatterController *skMatterVc = [[SKMatterController alloc]init];
    [self.navigationController pushViewController:skMatterVc animated:NO];
    [_vcTableview1 deselectRowAtIndexPath:[_vcTableview1 indexPathForSelectedRow] animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (SCREEN_HEIGHT-100)/6;
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
