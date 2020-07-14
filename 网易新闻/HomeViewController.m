//
//  ViewController.m
//  网易新闻
//
//  Created by Mac on 16/10/6.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "HomeViewController.h"
#import "Masonry.h"
#import "ChannelScrollView.h"
#import "ChannelModel.h"
#import "NewsCollectionViewCell.h"
#import "ChannelLabel.h"

#define ID @"news"

@interface HomeViewController () <UICollectionViewDataSource,UICollectionViewDelegate,channelScrollViewDelegate>

@property (nonatomic,strong) ChannelScrollView *scrollView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *collectionViewLayout;

@end

@implementation HomeViewController
{
    /// 频道标签模型数组
    NSArray *_channels;
    /// 频道标签数组
    NSMutableArray *_channelLabelsM;
}

//实现在滚动的时候进行标签的缩放
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat floatIndexScale = scrollView.contentOffset.x / self.view.bounds.size.width;
    NSInteger currentIndex = (NSInteger)floatIndexScale;
    CGFloat currentPersent = floatIndexScale - currentIndex;
    
    CGFloat rightScale = currentPersent;
    CGFloat leftScale = 1 - currentPersent;
    
    NSInteger leftIndex = currentIndex;
    NSInteger rightIndex = 1 + currentIndex;
    
    ChannelLabel *leftLabel = _channelLabelsM[leftIndex];
    leftLabel.scale = leftScale;
    
    if (rightIndex < _channelLabelsM.count) {
        ChannelLabel *rightLabel = _channelLabelsM[rightIndex];
        rightLabel.scale = rightScale;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取UICollectionView滚动到的索引
    NSInteger index = scrollView.contentOffset.x / self.view.bounds.size.width;
    
    [self.scrollView setContentOffset:[self signLabelCentre:_channelLabelsM[index]] animated:YES];
}

- (void)channelScrollView:(ChannelScrollView *)view andSelectedLabel:(ChannelLabel *)selectedLabel
{
    [self.scrollView setContentOffset:[self signLabelCentre:selectedLabel] animated:YES];
    // 2.把新闻滚动视图滚动到指定的位置
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedLabel.tag inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    
    NSInteger selectedIndex = selectedLabel.tag;
    
    for (NSInteger i = 0; i < _channelLabelsM.count; i++) {
        
        ChannelLabel *label = _channelLabelsM[i];
        if (i == selectedIndex) {
            label.scale = 1.0;
        } else {
            label.scale = 0.0;
        }
    }
}

//滚动到屏幕中心
- (CGPoint)signLabelCentre:(ChannelLabel *)selectedLabel
{
    // 1.2 计算选中标签滚动到居中时,需要的偏移量
    CGFloat offsetX = selectedLabel.center.x - (self.view.bounds.size.width * 0.5);
    // 1.3 设置最大和最小的滚动的临界值
    CGFloat minOffsetX = 0;
    CGFloat maxOffsetX = self.scrollView.contentSize.width - self.view.bounds.size.width;
    // 1.4 判断是否超出了最大和最小滚动范围
    if (offsetX < minOffsetX) {
        offsetX = minOffsetX;
    } else if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    // 1.5 把channelScrollView滚动到指定的位置
    return CGPointMake(offsetX, 0);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.collectionViewLayout.itemSize = self.collectionView.bounds.size;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    // 取出频道标签对应的模型
    ChannelModel *model = _channels[indexPath.item];
    NSString *URLString = [NSString stringWithFormat:@"article/list/%@/0-20.html",model.tid];
    // 把地址传递给谁
    cell.URLString = URLString;
    
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.navigationItem.title = @"网易新闻";
    
    [self setupUI];
    
    _channels = [ChannelModel channels];
 
}

- (void)setupUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView = [[ChannelScrollView alloc]init];
    
    _channelLabelsM = self.scrollView.channelLabelsM;
    
    self.scrollView.delegates = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(64);
        make.left.right.offset(0);
        make.height.equalTo(@44);
    }];
    
    self.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionViewLayout.minimumLineSpacing = 0;
    self.collectionViewLayout.minimumInteritemSpacing = 0;
    self.collectionViewLayout.itemSize = CGSizeZero;
    self.collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
    [self.view addSubview:self.collectionView];

    [self.collectionView registerNib:[UINib nibWithNibName:@"NewsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    
    self.collectionView.backgroundColor = [UIColor greenColor];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.offset(0);
        make.top.offset(108);
    }];
    
}

@end
