//
//  DemoVC9Cell.m
//  SDAutoLayout 测试 Demo
//
//  Created by gsd on 15/12/23.
//  Copyright © 2015年 gsd. All rights reserved.
//

#import "DemoVC9Cell.h"

#import "Demo9Model.h"

#import "UIView+SDAutoLayout.h"

#import "SDWeiXinPhotoContainerView.h"

@implementation DemoVC9Cell
{
    UIImageView *_iconView;
    UILabel *_nameLable;
    UILabel *_contentLabel;
    SDWeiXinPhotoContainerView *_picContainerView;
    UILabel *_timeLabel;
    UILabel *_styleLabel;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _iconView = [UIImageView new];
    
    _nameLable = [UILabel new];
    _nameLable.font = [UIFont systemFontOfSize:14];
    _nameLable.textColor = [UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:0.9];
    
    _styleLabel= [UILabel new];
    _styleLabel.font = [UIFont systemFontOfSize:14];
    _styleLabel.textColor = [UIColor whiteColor];
    _styleLabel.backgroundColor = [UIColor colorWithRed:36/255.0 green:137/255.0 blue:209/255.0 alpha:1.0];
    _styleLabel.layer.masksToBounds = YES;
    _styleLabel.layer.cornerRadius = 5.0;
    
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:15];
    
    _picContainerView = [SDWeiXinPhotoContainerView new];
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = [UIColor lightGrayColor];
    
    NSArray *views = @[_iconView, _nameLable,_styleLabel, _contentLabel, _picContainerView, _timeLabel];
    
    [views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.contentView addSubview:obj];
    }];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    _iconView.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin + 5)
    .widthIs(40)
    .heightIs(40);
    
    _nameLable.sd_layout
    .leftSpaceToView(_iconView, margin)
    .topEqualToView(_iconView)
    .heightIs(18);
    [_nameLable setSingleLineAutoResizeWithMaxWidth:200];
    
    _styleLabel.sd_layout
    .leftSpaceToView(_iconView, margin)
    .topSpaceToView(_nameLable,5)
    .heightIs(20);
    [_styleLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _contentLabel.sd_layout
    .leftEqualToView(_styleLabel)
    .topSpaceToView(_styleLabel, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
    
    _picContainerView.sd_layout
    .leftEqualToView(_contentLabel);
    
    _timeLabel.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_picContainerView, margin)
    .heightIs(15)
    .autoHeightRatio(0);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    [self setupAutoHeightWithBottomView:_timeLabel bottomMargin:margin + 5];
    
}


- (void)setModel:(Demo9Model *)model
{
    _model = model;
    
    _iconView.image = [UIImage imageNamed:model.iconName];
    _nameLable.text = model.name;
    _styleLabel.text= model.styleStr;
    _contentLabel.text = model.content;
    _picContainerView.picPathStringsArray = model.picNamesArray;
    CGFloat picContainerTopMargin = 0;
    if (model.picNamesArray.count) {
        picContainerTopMargin = 10;
    }
    _picContainerView.sd_layout.topSpaceToView(_contentLabel, picContainerTopMargin);
    _timeLabel.text = @"2016-12-21  11:24";
    
}

@end
