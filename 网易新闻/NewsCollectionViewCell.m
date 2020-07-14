//
//  NewsCollectionViewCell.m
//  网易新闻
//
//  Created by Mac on 16/10/6.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "NewsCollectionViewCell.h"
#import "NewsTableViewController.h"

@implementation NewsCollectionViewCell
{
    NewsTableViewController *_newsVC;
}

- (void)awakeFromNib
{
    UIStoryboard *tvSB = [UIStoryboard storyboardWithName:@"NewsTableViewController" bundle:nil];
    
    //根据Storyboard实例化出对应的控制器
    _newsVC = [tvSB instantiateInitialViewController];
    
    _newsVC.tableView.frame = self.contentView.bounds;
    
    [self.contentView addSubview:_newsVC.tableView];
    
    NSLog(@"%@",_newsVC);

}


- (void)setURLString:(NSString *)URLString
{
    _URLString = URLString;
    
    // 把新闻数据地址传递给newsVC
    _newsVC.URLString = URLString;
}

@end
