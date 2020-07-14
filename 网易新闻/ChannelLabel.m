//
//  ChannelLabel.m
//  网易新闻
//
//  Created by Mac on 16/10/6.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "ChannelLabel.h"

@implementation ChannelLabel

- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0];
    
    //设置缩放的最小和最大比例
    CGFloat minScale = 1.0;
    CGFloat maxScale = 1.3;
    
    scale = minScale + (maxScale - minScale) * scale;
    
    //不缩放，原始的大小
    self.transform = CGAffineTransformMakeScale(scale, scale);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:16];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

@end
