//
//  SKJSTableViewCell.m
//  YunHWater
//
//  Created by 李 恒 on 16/12/16.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "SKJSTableViewCell.h"

@implementation SKJSTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self createUI];
        
    }
    return self;
}
-(void)createUI{
    //序号
    _sortLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, (SCREEN_HEIGHT/6*5-60)/15,  (SCREEN_HEIGHT/6*5-60)/15,  (SCREEN_HEIGHT/6*5-60)/15)];
    _sortLabel.layer.masksToBounds = YES;
    _sortLabel.layer.cornerRadius = _sortLabel.frame.size.height/2;
    _sortLabel.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
    _sortLabel.textAlignment = NSTextAlignmentCenter;
    _sortLabel.textColor = [UIColor whiteColor];
    _sortLabel.font = [UIFont systemFontOfSize:_sortLabel.frame.size.height/3*2];
    [self.contentView addSubview:_sortLabel];
    
    //分割线
    UIImageView *separatorView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (SCREEN_HEIGHT/6*5-60)/5-1, SCREEN_WIDTH, 1)];
    separatorView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];
    [self addSubview:separatorView];
    //标题名称
    _proNameLabel = [[UILabel alloc]init];
    _proNameLabel.textColor = [UIColor colorWithRed:89/255.0 green:117/255.0 blue:72/255.0 alpha:1.0];
    _proNameLabel.textAlignment = NSTextAlignmentLeft;
    _proNameLabel.font = [UIFont systemFontOfSize:_sortLabel.frame.size.height/2];
    [self.contentView addSubview:_proNameLabel];
    //投资
    _investNumLabel = [UILabel new];
    _investNumLabel.textColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
    _investNumLabel.textAlignment = NSTextAlignmentLeft;
    _investNumLabel.font = [UIFont systemFontOfSize:_sortLabel.frame.size.height/2];
    [self.contentView addSubview:_investNumLabel];
    //进度
    _scheduleLabel = [UILabel new];
    _scheduleLabel.textColor = [UIColor colorWithRed:89/255.0 green:117/255.0 blue:72/255.0 alpha:1.0];
    _scheduleLabel.textAlignment = NSTextAlignmentRight;
    _scheduleLabel.font = [UIFont systemFontOfSize:_sortLabel.frame.size.height/2];
    [self.contentView addSubview:_scheduleLabel];
    //进度条
    UIImageView *scheduleView1= [UIImageView new];
    scheduleView1.layer.masksToBounds = YES;
    scheduleView1.layer.borderWidth = 1;
    scheduleView1.layer.borderColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0].CGColor;
    [self.contentView addSubview:scheduleView1];
    
    _scheduleView= [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-105,_sortLabel.frame.size.height/2+10+(SCREEN_HEIGHT/6*5-60)/20 , 50, 20)];
    _scheduleView.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
    [self.contentView addSubview:_scheduleView];
    
    
    
    _proNameLabel.sd_layout
    .leftSpaceToView(_sortLabel,20)
    .topSpaceToView(self.contentView,(SCREEN_HEIGHT/6*5-60)/20)
    .heightIs(_sortLabel.frame.size.height/2)
    .widthIs(SCREEN_WIDTH);
    
    _investNumLabel.sd_layout
    .leftSpaceToView(_sortLabel,20)
    .topSpaceToView(_proNameLabel,10)
    .heightIs(_sortLabel.frame.size.height/2)
    .widthIs(SCREEN_WIDTH);
    
    _scheduleLabel.sd_layout
    .topEqualToView(_proNameLabel)
    .rightSpaceToView(self.contentView,5)
    .heightIs(_sortLabel.frame.size.height/2);
    
    scheduleView1.sd_layout
    .topEqualToView(_investNumLabel)
    .rightEqualToView(_scheduleLabel)
    .widthIs(100)
    .heightIs(20);
    
}


@end
