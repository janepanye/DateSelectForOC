//
//  WheelView.m
//  RealmDemo
//
//  Created by Mac on 2017/12/11.
//  Copyright © 2017年 com.luohaifang. All rights reserved.
//

#import "WheelView.h"
//显示5行
@interface WheelView ()<UIScrollViewDelegate> {
    int _selectValue;//当前选中的值
    CGFloat _cellHeight;//每一行的高度
    UIScrollView *_scrollView;//滚动视图
    NSMutableArray<UILabel*> *_labelArr;//显示内容的标签
}

@end

@implementation WheelView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _labelArr = [@[] mutableCopy];
        //每一行的高度
        _cellHeight = frame.size.height / 5;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(frame.size.width, _cellHeight * 7);
        _scrollView.contentOffset = CGPointMake(0, _cellHeight);
        [self addSubview:_scrollView];
        //给滚动视图添加子视图
        for (int index = 0; index < 7; index ++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, index * _cellHeight, frame.size.width, _cellHeight)];
            label.textColor = [UIColor colorFromHexCode:@"#eeeeee"];
            label.tag = 2000 + index;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:15];
            [_scrollView addSubview:label];
        }
    }
    return self;
}
//设置当前的值
- (void)setValue:(int)value {
    _selectValue = value;
    //通知外部 值变了
    if(self.delegate && [self.delegate respondsToSelector:@selector(wheelValueDidChange:wheelView:)]) {
        [self.delegate wheelValueDidChange:_selectValue wheelView:self];
    }
    //中间的值
    UILabel *label = [_scrollView viewWithTag:2003];
    //通知外部 配置标签
    if(self.delegate && [self.delegate respondsToSelector:@selector(wheelLabelConfig:value:wheelView:)]) {
        [self.delegate wheelLabelConfig:label value:_selectValue wheelView:self];
    }
    //左边的值
    int leftValue = _selectValue;
    for (int tag = 2002;tag >= 2000;tag --) {
        UILabel *label = [_scrollView viewWithTag:tag];
        //得到当前应该显示的值
        leftValue = leftValue - _intervalValue;
        if(leftValue < _minValue)
            leftValue = _maxValue;
        //通知外部 配置标签
        if(self.delegate && [self.delegate respondsToSelector:@selector(wheelLabelConfig:value:wheelView:)]) {
            [self.delegate wheelLabelConfig:label value:leftValue wheelView:self];
        }
    }
    //右边的值
    int rightValue = _selectValue;
    for (int tag = 2004;tag <= 2006;tag ++) {
        UILabel *label = [_scrollView viewWithTag:tag];
        //得到当前应该显示的值
        rightValue = rightValue + _intervalValue;
        if(rightValue > _maxValue)
            rightValue = _minValue;
        //通知外部 配置标签
        if(self.delegate && [self.delegate respondsToSelector:@selector(wheelLabelConfig:value:wheelView:)]) {
            [self.delegate wheelLabelConfig:label value:rightValue wheelView:self];
        }
    }
    _scrollView.contentOffset = CGPointMake(0, _cellHeight);
}
#pragma mark -- UIScrollViewDelegate
//正在滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int currValue = 0;
    if(scrollView.contentOffset.y <= 0) {
        currValue = _selectValue - _intervalValue;
        if(currValue < _minValue)
            currValue = _maxValue;
        [self setValue:currValue];
    }
    if(scrollView.contentOffset.y >= 2 * _cellHeight) {
        currValue = _selectValue + _intervalValue;
        if(currValue > _maxValue)
            currValue = _minValue;
        [self setValue:currValue];
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scrollViewDidEndScrollingAnimation) object:nil];
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation) withObject:nil afterDelay:0.1];
}
//滚动停止 包括有动画、没有动画
- (void)scrollViewDidEndScrollingAnimation {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scrollViewDidEndScrollingAnimation:) object:nil];
    [_scrollView setContentOffset:CGPointMake(0, _cellHeight) animated:YES];
}
@end
