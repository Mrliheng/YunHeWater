//
//  MapViewController.m
//  YunHWater
//
//  Created by 李 恒 on 16/11/8.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "MapViewController.h"
#import <MAMapKit/MAMapKit.h>

@interface MapViewController ()
@property (strong,nonatomic) MAMapView *mapView;
@end

@implementation MapViewController
- (void)viewWillAppear:(BOOL)animated
{   //设置导航栏半透明为NO
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"地图";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setImage:[[UIImage imageNamed:@"返回1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ViewBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    [self initMap];
}
-(void)ViewBack{
    [self.navigationController popViewControllerAnimated:NO];
}
//初始化地图
- (void)initMap{
    _mapView = [[MAMapView alloc]initWithFrame:self.view.bounds];
    _mapView.mapType = MAMapTypeSatellite;
    
    [self.view addSubview:_mapView];
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
