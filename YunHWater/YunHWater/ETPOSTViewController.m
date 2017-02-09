//
//  ETPOSTViewController.m
//  云和App
//
//  Created by 李 恒 on 16/11/30.
//  Copyright © 2016年 gsd. All rights reserved.
//

#import "ETPOSTViewController.h"
#import "FlowViewController.h"



#import "MBProgressHUD.h"
//关于图片选择器
#import "TZTestCell.h"
#import "TZImageManager.h"
#import "TZImagePickerController.h"


#import <AssetsLibrary/AssetsLibrary.h>

#define imageCount 4
#define maxCount 9


@interface ETPOSTViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,MBProgressHUDDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UILabel *nubLabel;
    UIButton *timButton;
    //标题输入框
    UITextField *titleFile;
    //内容输入框
    UITextView *contentView;
    
    NSMutableArray *_selectedAssets;
    CGFloat _margin;
    CGFloat _itemWh;
    
    MBProgressHUD *progressHUD;
    
    //存储图片aid
    NSMutableArray *aidArr;
    
}

@property (nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray * selectedPhotos;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property(nonatomic,strong)UIScrollView * scrollView;
@end

@implementation ETPOSTViewController

- (void)viewWillAppear:(BOOL)animated{
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
    
    
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    //界面
    self.title = @"发布";
    self.view.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
    aidArr = [NSMutableArray array];
    
    //发布按钮
    UIButton *postButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    postButton.frame = CGRectMake(0, 0, 40, 30);
    [postButton setTitle:@"发布" forState:UIControlStateNormal];
    postButton.tintColor = [UIColor blackColor];
    [postButton addTarget:self action:@selector(Postinvitation) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:postButton];
    self.navigationItem.rightBarButtonItem = rightBtn;
    UIView *classify = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    classify.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:classify];
    
    //标题label
    UILabel * titleLeb = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-20, 35)];
    NSString *nameStr=@"项目名称:";
    titleLeb.text = [nameStr stringByAppendingString:_titleStr];
    titleLeb.font = [UIFont systemFontOfSize:16.0];
    titleLeb.textColor = [UIColor grayColor];
    [self.view addSubview:titleLeb];
    
    //母项
    //施工前
    _ConstructBfBt = [[UIButton alloc]initWithFrame:CGRectMake(20, 45, (SCREEN_WIDTH-80)/3, (SCREEN_HEIGHT/5-70)/2)];
    [_ConstructBfBt setTitle:@"施工前" forState:UIControlStateNormal];
    [_ConstructBfBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_ConstructBfBt addTarget:self action:@selector(ConstructChange:) forControlEvents:UIControlEventTouchDown];
    _ConstructBfBt.layer.cornerRadius = 5.0;
    [self.view addSubview:_ConstructBfBt];
    
    //施工中
    _ConstructUnBt = [[UIButton alloc]initWithFrame:CGRectMake(40+(SCREEN_WIDTH-80)/3, 45, (SCREEN_WIDTH-80)/3, (SCREEN_HEIGHT/5-70)/2)];
    [_ConstructUnBt setTitle:@"施工中" forState:UIControlStateNormal];
    [_ConstructUnBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_ConstructUnBt addTarget:self action:@selector(ConstructChange:) forControlEvents:UIControlEventTouchDown];
    _ConstructUnBt.layer.cornerRadius = 5.0;
    [self.view addSubview:_ConstructUnBt];
    
    //施工后
    _ConstructAfBt = [[UIButton alloc]initWithFrame:CGRectMake(60+(SCREEN_WIDTH-80)/3*2, 45, (SCREEN_WIDTH-80)/3, (SCREEN_HEIGHT/5-70)/2)];
    [_ConstructAfBt setTitle:@"施工后" forState:UIControlStateNormal];
    [_ConstructAfBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_ConstructAfBt addTarget:self action:@selector(ConstructChange:) forControlEvents:UIControlEventTouchDown];
    _ConstructAfBt.layer.cornerRadius = 5.0;
    [self.view addSubview:_ConstructAfBt];
    
    if (_isflowVC ==YES) {
        if ([_jincBtStr  isEqual: @"施工前"]) {
            _ConstructBfBt.backgroundColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
            _ConstructUnBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
            _ConstructAfBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
            
        }else if ([_jincBtStr  isEqual: @"施工中"]) {
            _ConstructUnBt.backgroundColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
            _ConstructBfBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
            _ConstructAfBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
        }else if ([_jincBtStr  isEqual: @"施工后"]) {
            _ConstructAfBt.backgroundColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
            _ConstructUnBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
            _ConstructBfBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
        }
    }else{
        _jincBtStr = @"施工中";
        _ConstructUnBt.backgroundColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
        _ConstructBfBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
        _ConstructAfBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
    }
    
    //子项
    _ziBt = [[TypeButton alloc]initWithFrame:CGRectMake(20, 60+(SCREEN_HEIGHT/5-70)/2, (SCREEN_WIDTH-80)/3*2, (SCREEN_HEIGHT/5-70)/2)];
    [_ziBt setTitle:@"请选择" forState:UIControlStateNormal];
    [_ziBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_ziBt setImage:[UIImage imageNamed:@"YellowDownArrow"] forState:UIControlStateNormal];
    [_ziBt setTintColor:[UIColor grayColor]];
    _ziBt.layer.masksToBounds = YES;
    _ziBt.layer.cornerRadius = 5.0;
    _ziBt.layer.borderWidth = 1;
    _ziBt.layer.borderColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:0.7].CGColor;
    //顺时针旋转90度
    _ziBt.imageView.transform = CGAffineTransformRotate(_ziBt.imageView.transform, M_PI_2);
    [_ziBt addTarget:self action:@selector(ziChange) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_ziBt];
    
    self.isDonghua = YES;
    self.ziMutabelArray = [NSMutableArray arrayWithObjects: @"基础初验",@"工程进度",@"政策处理",@"请选择", nil];
    
    
    
    //内容label
    UILabel * contentLeb = [[UILabel alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT/5, 45, 35)];
    contentLeb.text = @"内容 :";
    contentLeb.font = [UIFont systemFontOfSize:16.0];
    contentLeb.textColor = [UIColor grayColor];
    [self.view addSubview:contentLeb];
    
    contentView = [[UITextView alloc]initWithFrame:CGRectMake(60, SCREEN_HEIGHT/5, SCREEN_WIDTH-80, SCREEN_HEIGHT/5*2)];
    contentView.font = [UIFont systemFontOfSize:16.0];
    contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:contentView];
    //添加图片选择
    [self configCollectionView];
}
-(void)ViewBack{
    [self.navigationController popViewControllerAnimated:NO];
}

//施工前中后选择
-(void)ConstructChange:(UIButton *)button
{
    if (self.isDonghua == NO) {
        self.ziBt.imageView.transform = CGAffineTransformRotate(self.ziBt.imageView.transform, M_PI_2);
        self.isDonghua = YES;
    }
    [contentView resignFirstResponder];
    if (button == _ConstructBfBt) {
        _jincBtStr = @"施工前";
        _ConstructBfBt.backgroundColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
        _ConstructUnBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
        _ConstructAfBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
    }
    if (button == _ConstructUnBt) {
        _jincBtStr = @"施工中";
        _ConstructUnBt.backgroundColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
        _ConstructBfBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
        _ConstructAfBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
    }
    if (button == _ConstructAfBt) {
        _jincBtStr = @"施工后";
        _ConstructAfBt.backgroundColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
        _ConstructUnBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
        _ConstructBfBt.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
    }
}

//子项选择
-(void)ziChange{
    [self ziTableView];
    [UIView animateWithDuration:0.15 animations:^{
        CGRect typeFrame = _ziTableview.frame;
        typeFrame.size.height = typeFrame.size.height ? 0 : 60;
        
        _ziTableview.frame = typeFrame;
        
    } completion:^(BOOL finished) {

        if (self.isDonghua== YES) {
            if (_ziTableview.frame.size.height !=0 ) {
                _ziBt.imageView.transform = CGAffineTransformRotate(_ziBt.imageView.transform, -M_PI_2);
                self.isDonghua = NO;
            }
        }else
        {
            _ziBt.imageView.transform = CGAffineTransformRotate(_ziBt.imageView.transform, M_PI_2);
            self.isDonghua = YES;
        }
        
    }];
}

//子项tableView
-(UITableView *)ziTableView{
    if (_ziTableview == nil) {
        _ziTableview = [[UITableView alloc]init];
        _ziTableview.frame = CGRectMake(_ziBt.frame.origin.x, _ziBt.frame.origin.y+_ziBt.bounds.size.height, _ziBt.bounds.size.width, 0);
        _ziTableview.delegate= self;
        _ziTableview.dataSource= self;
        [self.view addSubview:_ziTableview];
    }
    return _ziTableview;
}

#pragma tableview的代理和数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ziMutabelArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.text = self.ziMutabelArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [contentView resignFirstResponder];
    [self.ziBt setTitle:self.ziMutabelArray[indexPath.row] forState:UIControlStateNormal];
    
    CGRect typeFrame = self.ziTableview.frame;
    typeFrame.size.height = 0;
    
    self.ziTableview.frame = typeFrame;
    if (self.isDonghua == NO) {
        self.ziBt.imageView.transform = CGAffineTransformRotate(self.ziBt.imageView.transform, M_PI_2);
    }
    self.isDonghua = YES;
    
}
//发帖方法
-(void)Postinvitation
{
    /*
    if (!(titleFile.text>0) || !(contentView.text>0)) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请完善相关发帖信息！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert show];
    }else{
        progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        progressHUD.delegate = self;
        progressHUD.removeFromSuperViewOnHide = YES;
        progressHUD.label.text = @"发布中...";
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults]objectForKey:COOKIE] forHTTPHeaderField:@"cookie"];
        
        if (self.selectedPhotos.count>=1) {
            NSLog(@"%@",self.selectedPhotos);
            for (int i = 0; i<self.selectedPhotos.count; i++) {
                NSDictionary *params = @{@"fid":self.fildId};
                [manager POST:[NSString stringFollowBaseUrl:@"用户发布帖子前上传图片url"] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    UIImage *image = self.selectedPhotos[i];
                    NSData * imageData = UIImageJPEGRepresentation(image, 0.3);
                    [formData appendPartWithFileData:imageData name:@"Filedata" fileName:@"123.png" mimeType:@"image/jpeg"];
                } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:@"code"]isEqual:@0]) {
                        NSDictionary *dic = [responseObject objectForKey:@"data"];
                        //                        [self PostFinallInvital:[dic objectForKey:@"aid"]];
                        [aidArr addObject:[dic objectForKey:@"aid"]];
                        if (aidArr.count == self.selectedPhotos.count) {
                            [self PostFinallInvital:aidArr];
                        }
                    }
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    //                    progressHUD.label.text = @"发布失败，请重试！";
                    //                    [progressHUD hideAnimated:YES afterDelay:2.0];
                }];
            }
        }else{
            
            NSDictionary *params = [NSDictionary dictionary];
            if (self.selectFid) {
                params = @{@"fid":self.fildId,@"typeid":self.selectFid,@"subject":titleFile.text ,@"message":contentView.text};
            }else{
                params = @{@"fid":self.fildId,@"subject":titleFile.text ,@"message":contentView.text};
            }
            
            //            NSDictionary *params = @{@"fid":self.fildId,@"typeid":self.selectFid,@"subject":titleFile.text ,@"message":contentView.text};
            [manager POST:[NSString stringFollowBaseUrl:@"用户发布帖子"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                progressHUD.hidden = YES;
                [self.navigationController popViewControllerAnimated:YES];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                progressHUD.label.text = @"发布失败，请重试！";
                [progressHUD hideAnimated:YES afterDelay:2.0];
            }];
        }
    }
    */
    FlowViewController *flowVC = [[FlowViewController alloc]init];
    flowVC.titleStr = _titleStr;
    [self.navigationController pushViewController:flowVC animated:YES];
    
    
}

-(void)PostFinallInvital:(NSMutableArray *)array
{
    NSMutableString *hehe = [NSMutableString string];
    for (NSString*abc in aidArr) {
        NSString *cdf = [NSString stringWithFormat:@"[attachimg]%@[/attachimg]",abc];
        [hehe appendString:cdf];
    }
    NSString *manage = [NSString stringWithFormat:@"%@%@",contentView.text,hehe];
    NSDictionary *params = [NSDictionary dictionary];
    if (self.selectFid) {
        params = @{@"fid":self.fildId,@"typeid":self.selectFid,@"subject":titleFile.text ,@"message":manage};
    }else{
        params = @{@"fid":self.fildId,@"subject":titleFile.text ,@"message":manage};
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults]objectForKey:COOKIE] forHTTPHeaderField:@"cookie"];
    
    [manager POST:[NSString stringFollowBaseUrl:@"用户上传"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@",responseObject);
        progressHUD.hidden = YES;
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        progressHUD.label.text = @"发布失败，请重试！";
        [progressHUD hideAnimated:YES afterDelay:2.0];
    }];
    
}

//标题文字改变
-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    //    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    //    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
    UITextRange *selectedRange = [textField markedTextRange];
    //获取高亮部分
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        NSString *label = [NSString stringWithFormat:@"%lu/26",(unsigned long)toBeString.length];
        nubLabel.text = label;
        if (toBeString.length > 26) {
            textField.text = [toBeString substringToIndex:26];
            nubLabel.text = @"26/26";
        }
    }
    // 有高亮选择的字符串，则暂不对文字进行统计和限制
    else{
        
    }
}

#pragma mark --图片选择器相关代码
- (void)configCollectionView {
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _margin = 10;
    _itemWh = (SCREEN_WIDTH - (imageCount+1) * _margin) / imageCount;
    layout.itemSize = CGSizeMake(_itemWh, _itemWh);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 64 - _itemWh - 60, SCREEN_WIDTH,_itemWh) collectionViewLayout:layout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.contentInset = UIEdgeInsetsMake(_margin, _margin, _margin, _margin);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    [self.view addSubview:_collectionView];
    _collectionView.bounces = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = NO;
}
#pragma mark UICollectionView代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"AlbumAddBtn.png"];
        cell.deleteBtn.hidden = YES;
    }
    else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    if (indexPath.row == maxCount) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"最多只能选择9张" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *Action1 = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
        }];
        
        [alertController addAction:Action1];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if (indexPath.row == _selectedPhotos.count) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        
        UIAlertAction *Action1 = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            [self takePhoto];
        }];
        UIAlertAction *Action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            [self pushImagePickerController];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
            
        }];
        
        [alertController addAction:Action1];
        [alertController addAction:Action2];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}

#pragma mark - TZImagePickerController

- (void)pushImagePickerController {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxCount-_selectedPhotos.count columnNumber:imageCount delegate:self];
    
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        //        [_selectedPhotos addObjectsFromArray:photos];
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无权限 做一个友好的提示
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *Action1 = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
            
        }];
        
        [alertController addAction:Action1];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
#define push @#clang diagnostic pop
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
#pragma clang diagnostic pop
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
        //        tzImagePickerVc.sortAscendingByModificationDate = self.sortAscendingSwitch.isOn;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
            if (error) { // 如果保存失败，基本是没有相册权限导致的...
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法保存图片" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" preferredStyle:(UIAlertControllerStyleAlert)];
                
                UIAlertAction *Action1 = [UIAlertAction actionWithTitle:@"设置" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
                    
                }];
                
                [alertController addAction:Action1];
                [alertController addAction:cancelAction];
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        [_selectedAssets addObject:assetModel.asset];
                        [_selectedPhotos addObject:image];
                        [_collectionView reloadData];
                    }];
                }];
            }
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}




#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
// - (void)imagePickerControllerDidCancel:(TZImagePickerController *)picker {
// NSLog(@"cancel");
// }

// The picker should dismiss itself; when it dismissed these handle will be called.
// If isOriginalPhoto is YES, user picked the original photo.
// You can get original photo with asset, by the method [[TZImageManager manager] getOriginalPhotoWithAsset:completion:].
// The UIImage Object in photos default width is 828px, you can set it by photoWidth property.
// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    //    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    [_selectedPhotos addObjectsFromArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    //    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
}

// If user picking a video, this callback will be called.
// If system version > iOS8,asset is kind of PHAsset class, else is ALAsset class.
// 如果用户选择了一个视频，下面的handle会被执行
// 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    // open this code to send video / 打开这段代码发送视频
    // [[TZImageManager manager] getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
    // NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
    // Export completed, send video here, send by outputPath or NSData
    // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
    
    // }];
    [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
}

#pragma mark Click Event


- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    //    [_selectedAssets removeObjectAtIndex:sender.tag];
    
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
    }];
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
