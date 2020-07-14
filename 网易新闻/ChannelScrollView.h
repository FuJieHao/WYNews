//
//  ChannelScrollView.h
//  网易新闻
//
//  Created by Mac on 16/10/6.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChannelScrollView,ChannelLabel;
@protocol channelScrollViewDelegate <NSObject>

- (void)channelScrollView:(ChannelScrollView *)view andSelectedLabel:(ChannelLabel *)label;

@end

@interface ChannelScrollView : UIScrollView

@property (nonatomic,weak) id <channelScrollViewDelegate> delegates;

/// 频道标签数组
@property (nonatomic,strong) NSMutableArray *channelLabelsM;

@end
