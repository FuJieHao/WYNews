//
//  NewsTableViewCell.m
//  网易新闻
//
//  Created by Mac on 16/10/6.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "NewsModel.h"
#import <UIImageView+WebCache.h>

@interface NewsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgsrcImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *replaycountLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgsrcImageViews;

@end

@implementation NewsTableViewCell


- (void)setNewsModel:(NewsModel *)newsModel
{
    _newsModel = newsModel;
    
    // 这个是多图cell的第0个图片
    [self.imgsrcImageView sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    self.titleLabel.text = newsModel.title;
    self.sourceLabel.text = newsModel.source;
    self.replaycountLabel.text = [NSString stringWithFormat:@"%zd",newsModel.replyCount];
    
    // 给多图的另外的两个图片赋值
    if (newsModel.imgextra.count == 2) {
        
        for (NSInteger i = 0; i < self.imgsrcImageViews.count; i++) {
            
            // 获取imageView对象
            UIImageView *imgView = self.imgsrcImageViews[i];
            
            // 取出imgView对应的图片地址
            NSArray *imgsrcArr = newsModel.imgextra;
            NSDictionary *imgsrcDict = imgsrcArr[i];
            NSString *imgsrc = imgsrcDict[@"imgsrc"];
            
            // 给取出的imgView赋值
            [imgView sd_setImageWithURL:[NSURL URLWithString:imgsrc] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        }
    }
}

@end
