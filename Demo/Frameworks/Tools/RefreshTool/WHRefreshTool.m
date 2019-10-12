//
//  WHRefreshTool.m
//  Demo
//
//  Created by zero on 2019/2/27.
//  Copyright © 2019 zero. All rights reserved.
//

#import "WHRefreshTool.h"

#import <MJRefresh/MJRefresh.h>

@interface WHRefreshTool()

//下拉时候触发的block
@property (nonatomic, copy) void(^dropDownRefreshBlock)(void);

//上拉时候触发的block
@property (nonatomic, copy) void(^upDropRefreshBlock)(void);

@property (nonatomic, strong) UIScrollView* scrollerView;

@end

@implementation WHRefreshTool

- (instancetype)init {
    if (self = [super init]) {
        //        //此gif为逐帧动画由多张图片组成
        //        NSArray* imgs = @[];
        //        //闲置状态下的gif(就是拖动的时候变化的gif)
        //        _idleImages = imgs;
        //
        //        //已经到达偏移量的gif(就是已经到达偏移量的时候的gif)
        //        _pullingImages = imgs;
        //
        //        //正在刷新的时候的gif
        //        _refreshingImages = imgs;
    }
    return self;
}


- (void)normalModelRefresh:(UIScrollView *)scrollerView
               refreshType:(WHRefreshType)refreshType
              firstRefresh:(BOOL)firstRefresh
             timeLabHidden:(BOOL)timeLabHidden
            stateLabHidden:(BOOL)stateLabHidden
             dropDownBlock:(void(^)(void))dropDownBlock
               upDropBlock:(void(^)(void))upDropBlock
{    
    _scrollerView = scrollerView;
    
    if (refreshType == WHRefreshTypeDropDown) { //只支持下拉
        // 将block传入
        self.dropDownRefreshBlock = dropDownBlock;
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropDownBlockAction)];
        // 是否隐藏上次更新的时间
        header.lastUpdatedTimeLabel.hidden = timeLabHidden;
        // 是否隐藏刷新状态label
        header.stateLabel.hidden = stateLabHidden;
        // tableView.mj_header接收header
        _scrollerView.mj_header = header;
        //首次进来是否需要刷新
        if (firstRefresh) {
            [scrollerView.mj_header beginRefreshing];
        }
        //透明度渐变
        scrollerView.mj_header.automaticallyChangeAlpha = YES;
    } else if (refreshType == WHRefreshTypeUpDrop) { //只支持上拉
        //传入block
        self.upDropRefreshBlock = upDropBlock;
        //初始化并指定方法
        scrollerView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upDropBlockAction)];
        //指定数据加载完毕的文字
        [(MJRefreshAutoNormalFooter *)scrollerView.mj_footer setTitle:@"到底了~" forState:MJRefreshStateNoMoreData];
    } else if (refreshType == WHRefreshTypeDouble) { //上拉和下拉都持支持
        //下拉
        //将block传入
        self.dropDownRefreshBlock = dropDownBlock;
        //初始化
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropDownBlockAction)];
        //是否隐藏上次更新的时间
        header.lastUpdatedTimeLabel.hidden = timeLabHidden;
        //是否隐藏刷新状态label
        header.stateLabel.hidden = stateLabHidden;
        //tableView.mj_header接收header
        scrollerView.mj_header = header;
        //首次进来是否需要刷新
        if (firstRefresh) {
            [scrollerView.mj_header beginRefreshing];
        }
        //透明度渐变
        scrollerView.mj_header.automaticallyChangeAlpha = YES;
        //上拉
        //将block传入
        self.upDropRefreshBlock = upDropBlock;
        //初始化并指定方法
        scrollerView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upDropBlockAction)];
        //指定数据加载完毕的文字
        [(MJRefreshAutoNormalFooter *)scrollerView.mj_footer setTitle:@"到底了~" forState:MJRefreshStateNoMoreData];
    }
}


//下拉时候触发的block
- (void)dropDownBlockAction {
    if (_dropDownRefreshBlock) {
        _dropDownRefreshBlock();
        [_scrollerView.mj_footer resetNoMoreData];
    }
}


//上拉时候触发的block
- (void)upDropBlockAction {
    if (_upDropRefreshBlock) {
        _upDropRefreshBlock();
    }
}


- (void)beginRefreshing
{
    [_scrollerView.mj_header beginRefreshing];
}


- (void)endRefresh
{
    [_scrollerView.mj_header endRefreshing];
    [_scrollerView.mj_footer endRefreshing];
}

- (void)nomoreDataWithTitle:(NSString *)title
{
    [(MJRefreshAutoNormalFooter *)_scrollerView.mj_footer setTitle:title forState:MJRefreshStateNoMoreData];
    [_scrollerView.mj_footer endRefreshingWithNoMoreData];
}

- (void)endRefreshingWithNoMoreData
{
    [_scrollerView.mj_header endRefreshing];
    [_scrollerView.mj_footer endRefreshingWithNoMoreData];
}

@end
