//
//  NewsModel.h
//  网易新闻
//
//  Created by Mac on 16/10/6.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

/// 新闻标题
@property (copy, nonatomic) NSString *title;
/// 新闻来源
@property (copy, nonatomic) NSString *source;
/// 新闻回复量
@property (assign, nonatomic) NSInteger replyCount;
/// 图片的地址
@property (copy, nonatomic) NSString *imgsrc;
/// 判断是否是大图
@property (assign, nonatomic) BOOL imgType;
/// 判断是否是多图
@property (strong, nonatomic) NSArray *imgextra;

@end
