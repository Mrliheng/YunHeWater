//
//  CZFlowLayout.m
//  自定义流水布局
//
//  Created by apple on 16/4/23.
//  Copyright © 2016年 cz.cn. All rights reserved.
//

#import "CZFlowLayout.h"

@interface CZFlowLayout ()

@property (nonatomic, strong) NSArray<UICollectionViewLayoutAttributes *> *attributes;

@end

@implementation CZFlowLayout


//懒加载数组
- (NSArray<UICollectionViewLayoutAttributes *> *)attributes
{
    if (_attributes == nil) {
        
        _attributes = [NSArray array];
    }

    return _attributes;
}


- (void)prepareLayout{

    [super prepareLayout];
    
    CGFloat marginW = self.minimumInteritemSpacing;
    CGFloat marginH = self.minimumLineSpacing;
    

    
    //获取cell的总数
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
//    NSLog(@"%ld",count);
    
    
    //设置尺寸
    
    //两个大视图宽度
    
    CGFloat contentW = self.collectionView.frame.size.width;
    CGFloat contentH = self.collectionView.frame.size.height;
    
    
    CGFloat CviewH = contentH/5*3;
    CGFloat viewJ = contentW/30;
    
    CGFloat viewY = contentH/25*8;
    
    CGFloat viewW = (contentW-viewJ*2)/2;
    CGFloat viewH = (CviewH-viewJ*4)/3;
    //大视图的宽度 及高度
    CGFloat bigViewW = contentW * 0.5;
//    CGFloat bigViewH = bigViewW;
    
    
    //小视图的宽度 及高度
    CGFloat smallViewW = (bigViewW - marginW) * 0.5;
    CGFloat smallViewH = smallViewW;
    
    //中视图的宽度 及高度
//    CGFloat midViewW = bigViewW;
//    CGFloat midViewH = smallViewH;
    
    
    
    
    //创建临时数组 盛放布局属性
    
    NSMutableArray *tempAtt = [NSMutableArray array];
    
    //计算组的总高度
    
//    CGFloat groupH = 3 * (marginH + smallViewH);
    
    
    //进行for  次数为 cell的个数  创建 att对象  并且放在对应的数组里面
    for (int i = 0; i < count; i ++) {
   
        //计算对应的组数
        
//        int groupIndex = i / 7;
        
    
        //得到对应cell在这一组中的标号
        int index = i % 6;
        
        //计算每一个cell的布局
        
        CGFloat itemW;
        CGFloat itemH;
        CGFloat itemX;
        CGFloat itemY;
        
        switch (index) {
            case 0:
                itemX = viewJ/2;
                itemY = viewY;
                itemW = viewW;
                itemH = viewH;
                break;
            case 1:
                itemX = viewW+viewJ/2*3;
                itemY =viewY;
                itemW = viewW;
                itemH = viewH;
                break;
            case 2:
                itemX = viewJ/2;
                itemY = viewH+viewY+viewJ;
                itemW = viewW;
                itemH = viewH;
                break;
            case 3:
                itemX = viewW+viewJ/2*3;
                itemY = viewH+viewY+viewJ;
                itemW = viewW;
                itemH = viewH;
                break;
            case 4:
                itemX = viewJ/2;
                itemY = viewH*2+viewY+viewJ*2;
                itemW = viewW;
                itemH = viewH;
                break;
                
            case 5:
                itemX = viewW+viewJ/2*3;
                itemY = viewH*2+viewY+viewJ*2;
                itemW = viewW;
                itemH = viewH;
                break;

            default:
                break;
        }
        
        
        //创建布局属性 设置对应cell的frame
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        att.frame = CGRectMake(itemX , itemY , itemW, itemH);
        
        [tempAtt addObject:att];
        
    }
    
    self.attributes = [tempAtt copy];
    
    
    //计算itemsize
    //目的:让collectionView正好能滚动到最底部  比较不好理解
    CGFloat itemSizeW;
    CGFloat itemSizeH;
    
    //计算一共的组数
    int totalGroupCount = (int)count / 16; //有时会有多余的
    
    //计算除去整租剩几个
    
    int yushu = count % 16;
    
    CGFloat totalH;
    CGFloat b;
    CGFloat c;
    
    if (yushu == 0) {
        
        //总高度 =   6 * (marginH + smallViewH) * totalGroupCount
        //有效高度  内容的高度为 6 * smallViewH * totalGroupCount
        
        //有一组 3 个间隙  6
        //有两组 7 个间隙  12
        //有三组  11 个间隙  18
        //
        totalH  =   6 *  smallViewH  * totalGroupCount  + marginH * (totalGroupCount * 2 + 1);
   
        b = 4 * totalGroupCount;
    
    }else if (yushu == 1){
        //33
        //2组         8个间隙
        //13

        totalH  =   6 *  smallViewH  * totalGroupCount +  smallViewH  +  (2 * totalGroupCount + 1) * marginH ;
        b = 4 * totalGroupCount + 1;
        
    }else if (yushu == 2 || yushu == 3  || yushu == 4){
        
        //50个
        //3组  加1个   12个间隙
        //20
        
        //34
        //2组         8个间隙
        //14
        
        totalH  =   6 *  smallViewH  * totalGroupCount +  2 * smallViewH  + (2 * totalGroupCount + 2) * marginH ;
  
        b = 4 * totalGroupCount + 1;
        
    }else if(yushu == 5){
        
        //53个
        //3组  加1个   13个间隙
        //20
        
        //37
        //2组         9个间隙
        //14

        totalH  =   6 *  smallViewH  * totalGroupCount +  2 * smallViewH  + (2 * totalGroupCount + 1) * marginH ;
        
        b = 4 * totalGroupCount + 2;
    
    }else if (yushu == 6 || yushu == 7 || yushu == 8){
    
        //54个
        //3组  加1个   13个间隙
        //21
        
        //38
        //2组         9个间隙
        //15

        totalH  =   6 *  smallViewH  * totalGroupCount +  3 * smallViewH  + (2 * totalGroupCount + 2) * marginH ;
        
        b = 4 * totalGroupCount + 2;
    }else if(yushu == 9 || yushu == 10 || yushu == 11 || yushu == 12){
        
        //57个
        //3组        14个间隙
        //23
        
        //41
        //2组         10个间隙
        //17

        totalH  =   6 *  smallViewH  * totalGroupCount +  5 * smallViewH  + (2 * totalGroupCount + 3) * marginH ;
        b = 4 * totalGroupCount + 3;
    }else{
        
        //61个
        //3组        15个间隙
        //24
        
        //45
        //2组         11个间隙
        //18
    
        totalH  =   6 *  smallViewH  * totalGroupCount +  6 * smallViewH  + (2 * totalGroupCount + 3) * marginH ;
        
        b = 4 * totalGroupCount + 4;
    }
    
    itemSizeW = smallViewW;
    c = totalH / b ;
    
    itemSizeH =  c ;
    
    self.itemSize =CGSizeMake(itemSizeW, itemSizeH);

}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{

    return self.attributes;
}

@end
