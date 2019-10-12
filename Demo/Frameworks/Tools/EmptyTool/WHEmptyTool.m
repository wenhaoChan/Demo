//
//  WHEmptyTool.m
//  Class1
//
//  Created by zero on 2019/5/19.
//  Copyright © 2019 wonder. All rights reserved.
//

#import "WHEmptyTool.h"

#import <MJRefresh/MJRefresh.h>
#import <UIScrollView+EmptyDataSet.h>

@interface WHEmptyTool()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, copy) NSString* stateImageName;

@property (nonatomic, copy) NSString* emptytitle;

@property (nonatomic, copy) NSString* emptyButtonImageName;

@property (nonatomic, assign) WHEmptyType type;

@end

@implementation WHEmptyTool

#pragma mark - life cycle methods

- (instancetype)initWithScrollView:(UIScrollView *)scrollView emptyTypeP:(WHEmptyType)type
{
    self = [super init];
    if (self) {
        _type = type;
        _scrollView = scrollView;
        _scrollView.emptyDataSetSource = self;
        _scrollView.emptyDataSetDelegate = self;
        [self configeEmptyDataSet];
    }
    return self;
}

#pragma mark - private methods

- (void)configeEmptyDataSet
{
    switch (_type) {
        case WHEmptyTypeNone: {
            [self setStateImageName:@"" emptytitle:@"" emptyButtonImageName:@""];
            break;
        }
        case WHEmptyTypeNormal: {
            [self setStateImageName:@"nodata" emptytitle:@"暫無數據" emptyButtonImageName:@""];
            break;
        }
        case WHEmptyTypeNetwork: {
            [self setStateImageName:@"" emptytitle:@"网络好像不太给力，请稍后再试哦~" emptyButtonImageName:@""];
            break;
        }
    }
}

- (void)setStateImageName:(NSString *)stateImageName emptytitle:(NSString *)emptytitle emptyButtonImageName:(NSString *)emptyButtonImageName
{
    self.stateImageName = stateImageName;
    self.emptytitle = emptytitle;
    self.emptyButtonImageName = emptyButtonImageName;
}

#pragma mark - public methods

- (void)reloadEmptyView
{
    [_scrollView reloadEmptyDataSet];
}

- (void)reloadEmptyViewWithState:(WHEmptyType)state
{
    _type = state;
    [self configeEmptyDataSet];
}

#pragma mark - emptyDataSetDelegate

- (void)emptyDataSetDidAppear:(UIScrollView *)scrollView
{
    scrollView.mj_footer.hidden = YES;
}

- (void)emptyDataSetDidDisappear:(UIScrollView *)scrollView
{
    scrollView.mj_footer.hidden = NO;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    if (self.WDLReloadBlock) {
        self.WDLReloadBlock();
    }
}

#pragma mark - emptyDataSetSource

//- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return 20.0f;
//}


- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return [UIImage imageNamed:self.emptyButtonImageName];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:self.stateImageName];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return .0;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSInteger font = 14.f;
    UIColor* coclor = ColorFromRGB(k333Color);
//    switch (_type) {
//        default:{
//            font ;
//            coclor = CODarkTextColor;
//            break;
//        }
//    }
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:font],
                                 NSForegroundColorAttributeName:coclor,
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:self.emptytitle attributes:attributes];
}


//- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
//{
//    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
//    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraph.alignment = NSTextAlignmentCenter;
//
//    NSString* title = @"";
//
//
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12.f],
//                                 NSForegroundColorAttributeName:ColorFromRGB(0xC8C8C8),
//                                 NSParagraphStyleAttributeName: paragraph};
//
//    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
//}


@end
