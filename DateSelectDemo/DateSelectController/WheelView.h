//
//  WheelView.h
//  RealmDemo
//
//  Created by Mac on 2017/12/11.
//  Copyright © 2017年 com.luohaifang. All rights reserved.
//

#import <UIKit/UIKit.h>
//可以无限滚动的选择器，传入最大最小值
@class WheelView;
@protocol WheelViewDelegate <NSObject>
//当前值被选中了 把自身传出去方便外部区分，毕竟会创建很多WheelView对象
- (void)wheelValueDidChange:(int)value wheelView:(WheelView*)wheelView;
//配置标签内容
- (void)wheelLabelConfig:(UILabel*)label value:(int)value wheelView:(WheelView*)wheelView;
@end

@interface WheelView : UIView

@property (nonatomic, assign) int maxValue;//最大值
@property (nonatomic, assign) int minValue;//最小值
@property (nonatomic, assign) int intervalValue;//间隔值
@property (nonatomic,   weak) id<WheelViewDelegate> delegate;//代理
//设置当前的值
- (void)setValue:(int)value;

@end
