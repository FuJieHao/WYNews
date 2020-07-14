//
//  NewsTableViewController.m
//  网易新闻
//
//  Created by Mac on 16/10/6.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsModel.h"
#import "FJNetworkTool.h"
#import <YYModel.h>
#import "NewsTableViewCell.h"

@interface NewsTableViewController ()

@end

@implementation NewsTableViewController
{
    /// 数据源数组
    NSArray *_newsList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

/// 新闻控制器拿到新闻数据的地址
- (void)setURLString:(NSString *)URLString
{
    _URLString = URLString;
    
    // 拿着地址去发送网络请求
    [self loadNewsData];
}

/// 新闻控制器加载新闻数据的主方法
- (void)loadNewsData
{
    [[FJNetworkTool sharedNetworkTool] GETWithURLString:_URLString success:^(NSDictionary *responseObject) {
        
        // 动态的获取字典的第一个key
        NSString *key = responseObject.keyEnumerator.nextObject;
        // 取出字典数组
        NSArray *newsList = responseObject[key];
        // 使用YYModel把字典数组转成模型数组
        // 参数1 : 传入模型的类型
        // 参数2 : 字典数组
        _newsList = [NSArray yy_modelArrayWithClass:[NewsModel class] json:newsList];
        
        // 刷新列表
        [self.tableView reloadData];
        
    } faile:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier;
    
    NewsModel *news = _newsList[indexPath.row];
    
    if (news.imgType) {
        identifier = @"BigCell";
    } else if (news.imgextra.count == 2) {
        identifier = @"ImagesCell";
    } else {
        identifier = @"BaseCell";
    }
    
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.newsModel = news;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellH;
    
    NewsModel *news = _newsList[indexPath.row];
    
    if (news.imgType) {
        cellH = 180;
    } else if (news.imgextra.count == 2) {
        cellH = 130;
    } else {
        cellH = 80;
    }
    
    return cellH;
}


@end
