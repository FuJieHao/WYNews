//
//  ChannelModel.h
//  网易新闻
//
//  Created by Mac on 16/10/6.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelModel : NSObject

@property (nonatomic,copy) NSString *tname;
@property (nonatomic,copy) NSString *tid;

+ (NSArray *)channels;

@end
