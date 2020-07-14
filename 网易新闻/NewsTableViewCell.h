//
//  NewsTableViewCell.h
//  网易新闻
//
//  Created by Mac on 16/10/6.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel;
@interface NewsTableViewCell : UITableViewCell

@property (nonatomic,strong) NewsModel *newsModel;

@end
