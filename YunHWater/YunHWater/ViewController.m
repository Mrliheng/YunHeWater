//
//  ViewController.m
//  YunHWater
//
//  Created by 李 恒 on 16/10/12.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    MBProgressHUD *HUD;
}
@property (nonatomic,strong) UITextField *account;//账号
@property (nonatomic,strong) UITextField *password;//密码
@property (nonatomic,strong) UIButton *loginButton;//登录按钮
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view setBackgroundColor:[UIColor colorWithRed:51/255.0 green:204/255.0 blue:255/255.0 alpha:1]];
    
    //账号
    _account=[[UITextField alloc] initWithFrame:CGRectMake(20, 200, self.view.frame.size.width-40, 50)];
    _account.backgroundColor=[UIColor whiteColor];
    _account.placeholder=[NSString stringWithFormat:@"请输入用户名"];
    [self.view addSubview:_account];
    _account.layer.cornerRadius=5.0;
    
    //密码
    _password=[[UITextField alloc] initWithFrame:CGRectMake(20, 260, self.view.frame.size.width-40, 50)];
    _password.backgroundColor=[UIColor whiteColor];
    _password.placeholder=[NSString stringWithFormat:@"请输入密码"];
    [self.view addSubview:_password];
    _password.layer.cornerRadius=5.0;
    
    //登录按钮
    _loginButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_loginButton setFrame:CGRectMake(20, 320, self.view.frame.size.width-40, 50)];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setBackgroundColor:[UIColor colorWithRed:51/255.0 green:102/255.0 blue:255/255.0 alpha:1]];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_loginButton];
    _loginButton.layer.cornerRadius=5.0;
    //点击登录按钮
    [_loginButton addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchDown];
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"登录中...";
    //点击空白处
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

//点击空白处
-(void)dismissKeyboard {
    [self.view endEditing:YES];
    [_account resignFirstResponder];
    [_password resignFirstResponder];
}

//点击登录按钮
- (void)Login{
    // MBProgressHUD后台新建子线程执行任务
    [HUD showWhileExecuting:@selector(loginUser) onTarget:self withObject:nil animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 子线程中
-(void) loginUser {
    // 显示进度条
//    sleep(0);
    
    // 返回主线程执行
    [self  performSelectorOnMainThread:@selector(goToMainView) withObject:nil waitUntilDone:FALSE];
}

// 服务器交互进行用户名，密码认证
-(BOOL)loginWithUsername:(NSString *)username Password:(NSString *)password {
    return true;
}

-(void) goToMainView {
    [self performSegueWithIdentifier:@"GoToMainViewSegue" sender:self];
    
}

@end
