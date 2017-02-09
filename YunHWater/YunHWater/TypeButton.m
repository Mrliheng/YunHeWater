//
//  TypeButton.m
//  pengtaxpass
//
//  Created by zhou on 16/4/1.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "TypeButton.h"

@implementation TypeButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect titleRect = self.titleLabel.frame;
    titleRect.origin.x = 0;
    self.titleLabel.frame = titleRect;
    
    CGRect imageRect = self.imageView.frame;
    imageRect.origin.x = self.bounds.size.width - self.imageView.bounds.size.width;
    self.imageView.frame = imageRect;
}
@end
