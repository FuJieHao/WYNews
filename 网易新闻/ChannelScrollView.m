//
//  ChannelScrollView.m
//  网易新闻
//
//  Created by Mac on 16/10/6.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "ChannelScrollView.h"
#import "ChannelModel.h"
#import "ChannelLabel.h"

@implementation ChannelScrollView

- (instancetype)init
{
    if (self = [super init]) {
        
        self.channelLabelsM = [NSMutableArray array];
        
        self.backgroundColor = [UIColor grayColor];
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI
{
    NSArray *arr = [ChannelModel channels];
    
    CGFloat labelW = 80.0;
    
    self.contentSize = CGSizeMake(labelW * arr.count, 0);
    
    for (NSInteger i = 0; i < arr.count; i++) {
        
        ChannelLabel *label = [[ChannelLabel alloc] init];
        [self addSubview:label];
        
        CGFloat labelX = labelW * i;
        
        label.frame = CGRectMake(labelX, 0, labelW, 44);
        
        ChannelModel *model = arr[i];
        
        label.text = model.tname;
        
        // 需要给label增加点击事件(点击手势)
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapClick:)];
        // 给label添加点击手势
        [label addGestureRecognizer:tap];
        // 开启label的交互
        label.userInteractionEnabled = YES;
        // 设置tag : 告诉底部的滚动视图,当前需要滚动到哪个item
        label.tag = i;
        
        [self.channelLabelsM addObject:label];
        
        //默认把0个Lable设置成最大
        if (i == 0) {
            label.scale = 1.0;
        }
    }
}

- (void)labelTapClick:(UITapGestureRecognizer *)recognizer
{
    // 1.把选中的标签居中
    
    // 1.1 拿到选中的标签
    ChannelLabel *selectedLabel = (ChannelLabel *)recognizer.view;
    // 1.2 计算选中标签滚动到居中时,需要的偏移量
    if ([self.delegates respondsToSelector:@selector(channelScrollView:andSelectedLabel:)]) {
        [self.delegates channelScrollView:self andSelectedLabel:selectedLabel];
    }
}


@end
