//
//  TimePickerController.m
//  RealmDemo
//
//  Created by Mac on 2017/12/11.
//  Copyright © 2017年 com.luohaifang. All rights reserved.
//

#import "TimePickerController.h"
#import "WheelView.h"

@interface TimePickerController ()<WheelViewDelegate> {
    int _selectHour;//用户选择的小时
    int _selectMinute;//用户选择的分钟
    WheelView *_hourWheelView;//时滚轮
    WheelView *_minuteWheelView;//分滚轮
    
    
    int _selectYear;//用户选择的年
    int _selectMonth;//用户选择的月
    int _selectDay;//用户选择的日
}
@property (weak, nonatomic) IBOutlet UIView *bottomView;//下面视图
@property (weak, nonatomic) IBOutlet UILabel *topTimeLabel;//上面显示时间的标签

@end

@implementation TimePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(!_selectDate) _selectDate = [NSDate new];
    _selectYear = (int)_selectDate.year;
    _selectMonth = (int)_selectDate.month;
    _selectDay = (int)_selectDate.day;
    _selectHour = (int)_selectDate.hour;
    _selectMinute = (int)_selectDate.minute;
    //设置上面时间标签的值
    _topTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",_selectHour,_selectMinute];
    //创建选择器
    _hourWheelView = [[WheelView alloc] initWithFrame:CGRectMake(11.5, 51, (MAIN_SCREEN_WIDTH - 59 - 23) / 2.f, 284 - 52 - 44)];
    _hourWheelView.minValue = 0;
    _hourWheelView.maxValue = 23;
    _hourWheelView.intervalValue = 1;
    _hourWheelView.delegate = self;
    [_hourWheelView setValue:_selectHour];
    [_bottomView addSubview:_hourWheelView];
    _minuteWheelView = [[WheelView alloc] initWithFrame:CGRectMake(59 + CGRectGetMaxX(_hourWheelView.frame), 51, (MAIN_SCREEN_WIDTH - 59 - 23) / 2.f, 284 - 52 - 44)];
    _minuteWheelView.minValue = 0;
    _minuteWheelView.maxValue = 59;
    _minuteWheelView.intervalValue = 1;
    _minuteWheelView.delegate = self;
    [_minuteWheelView setValue:_selectMinute];
    [_bottomView addSubview:_minuteWheelView];
    //创建那些线条
    for (int index = 1; index <= 4; index ++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, index * _hourWheelView.frame.size.height / 5, _hourWheelView.frame.size.width, 1)];
        lineView.backgroundColor = [UIColor colorFromHexCode:@"#eeeeee"];
        [_hourWheelView addSubview:lineView];
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, index * _minuteWheelView.frame.size.height / 5, _minuteWheelView.frame.size.width, 1)];
        lineView1.backgroundColor = [UIColor colorFromHexCode:@"#eeeeee"];
        [_minuteWheelView addSubview:lineView1];
    }
    // Do any additional setup after loading the view from its nib.
}
#pragma mark -- WheelViewDelegate
//值改变了 把自己穿出去，方便外部区分，毕竟会创建很多WheelView对象
- (void)wheelValueDidChange:(int)value wheelView:(WheelView*)wheelView {
    if(wheelView == _hourWheelView)
        _selectHour = value;
    if(wheelView == _minuteWheelView)
        _selectMinute = value;
    //设置上面时间标签的值
    _topTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",_selectHour,_selectMinute];
}
//配置标签内容
- (void)wheelLabelConfig:(UILabel*)label value:(int)value wheelView:(WheelView*)wheelView {
    //小时
    if(wheelView == _hourWheelView) {
       label.text = [NSString stringWithFormat:@"%02d",value];
        if(value == _selectHour) {
            label.textColor = [UIColor colorFromHexCode:@"#5eb6f3"];
        } else {
            label.textColor = [UIColor colorFromHexCode:@"#9fa8b5"];
        }
    }
    //分钟
    if(wheelView == _minuteWheelView) {
        label.text = [NSString stringWithFormat:@"%02d",value];
        if(value == _selectMinute) {
            label.textColor = [UIColor colorFromHexCode:@"#5eb6f3"];
        } else {
            label.textColor = [UIColor colorFromHexCode:@"#9fa8b5"];
        }
    }
}
//确认按钮被点击
- (IBAction)sureClick:(id)sender {
    //yyyy-MM-dd HH:mm:ss
    if(!self.timePicker)
        return;
    NSDate *selectDate = [NSDate dateWithFormat:[NSString stringWithFormat:@"%d-%02d-%02d %02d:%02d:00",_selectYear,_selectMonth,_selectDay,_selectHour,_selectMinute]];
    self.timePicker(selectDate);
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)cancleClick:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)todayClick:(id)sender {
    _selectDate = [NSDate new];
    _selectYear = (int)_selectDate.year;
    _selectMonth = (int)_selectDate.month;
    _selectDay = (int)_selectDate.day;
    _selectHour = (int)_selectDate.hour;
    _selectMinute = (int)_selectDate.minute;
    
    [_hourWheelView setValue:_selectHour];
    [_minuteWheelView setValue:_selectMinute];
    //设置上面时间标签的值
    _topTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",_selectHour,_selectMinute];
}

@end
