//
//  DateTimePickerController.m
//  RealmDemo
//
//  Created by Mac on 2017/12/11.
//  Copyright © 2017年 com.luohaifang. All rights reserved.
//

#import "DateTimePickerController.h"
#import "WheelView.h"

@interface DateTimePickerController ()<WheelViewDelegate> {
    int _selectYear;//用户选择的年
    int _selectMonth;//用户选择的月
    int _selectDay;//用户选择的日
    int _selectHour;//用户选择的小时
    int _selectMinute;//用户选择的分钟
    
    WheelView *_yearWheelView;//年滚轮
    WheelView *_monthWheelView;//月滚轮
    WheelView *_dayWheelView;//日滚轮
    WheelView *_hourWheelView;//时滚轮
    WheelView *_minuteWheelView;//分滚轮
}
@property (weak, nonatomic) IBOutlet UIView *bottomView;//下面视图
@property (weak, nonatomic) IBOutlet UILabel *topTimeLabel;//上面显示时间的标签

@end

@implementation DateTimePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(!_selectDate) _selectDate = [NSDate new];
    _selectYear = (int)_selectDate.year;
    _selectMonth = (int)_selectDate.month;
    _selectDay = (int)_selectDate.day;
    _selectHour = (int)_selectDate.hour;
    _selectMinute = (int)_selectDate.minute;
    //年
    _yearWheelView = [[WheelView alloc] initWithFrame:CGRectMake(11.5, 51, (MAIN_SCREEN_WIDTH - 23) / 5, 284 - 52 - 44)];
    _yearWheelView.minValue = 1970;
    _yearWheelView.maxValue = 2500;
    _yearWheelView.intervalValue = 1;
    _yearWheelView.delegate = self;
    [_yearWheelView setValue:_selectYear];
    [_bottomView addSubview:_yearWheelView];
    //月
    _monthWheelView = [[WheelView alloc] initWithFrame:CGRectMake((MAIN_SCREEN_WIDTH - 23) / 5 + 11.5, 51, (MAIN_SCREEN_WIDTH - 23) / 5, 284 - 52 - 44)];
    _monthWheelView.minValue = 1;
    _monthWheelView.maxValue = 12;
    _monthWheelView.intervalValue = 1;
    _monthWheelView.delegate = self;
    [_monthWheelView setValue:_selectMonth];
    [_bottomView addSubview:_monthWheelView];
    //日
    _dayWheelView = [[WheelView alloc] initWithFrame:CGRectMake((MAIN_SCREEN_WIDTH - 23) / 5 * 2 + 11.5 - 10, 51, (MAIN_SCREEN_WIDTH - 23) / 5 + 20, 284 - 52 - 44)];
    _dayWheelView.minValue = 1;
    _dayWheelView.maxValue = 30;
    _dayWheelView.intervalValue = 1;
    _dayWheelView.delegate = self;
    [_dayWheelView setValue:_selectDay];
    [_bottomView addSubview:_dayWheelView];
    //时
    _hourWheelView = [[WheelView alloc] initWithFrame:CGRectMake((MAIN_SCREEN_WIDTH - 23) / 5 * 3 + 11.5, 51, (MAIN_SCREEN_WIDTH - 23) / 5, 284 - 52 - 44)];
    _hourWheelView.minValue = 0;
    _hourWheelView.maxValue = 23;
    _hourWheelView.intervalValue = 1;
    _hourWheelView.delegate = self;
    [_hourWheelView setValue:_selectHour];
    [_bottomView addSubview:_hourWheelView];
    //分
    _minuteWheelView = [[WheelView alloc] initWithFrame:CGRectMake((MAIN_SCREEN_WIDTH - 23) / 5 * 4 + 11.5, 51, (MAIN_SCREEN_WIDTH - 23) / 5, 284 - 52 - 44)];
    _minuteWheelView.minValue = 0;
    _minuteWheelView.maxValue = 59;
    _minuteWheelView.intervalValue = 1;
    _minuteWheelView.delegate = self;
    [_minuteWheelView setValue:_selectMinute];
    [_bottomView addSubview:_minuteWheelView];
    //创建那些线条
    for (int index = 1; index <= 4; index ++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50 + index * _hourWheelView.frame.size.height / 5, MAIN_SCREEN_WIDTH, 1)];
        lineView.backgroundColor = [UIColor colorFromHexCode:@"#eeeeee"];
        [_bottomView addSubview:lineView];
    }
    // Do any additional setup after loading the view from its nib.
}
#pragma mark -- WheelViewDelegate
//值改变了 把自己穿出去，方便外部区分，毕竟会创建很多WheelView对象
- (void)wheelValueDidChange:(int)value wheelView:(WheelView*)wheelView {
    if(wheelView == _yearWheelView)
        _selectYear = value;
    if(wheelView == _monthWheelView)
        _selectMonth = value;
    if(wheelView == _dayWheelView)
        _selectDay = value;
    if(wheelView == _hourWheelView)
        _selectHour = value;
    if(wheelView == _minuteWheelView)
        _selectMinute = value;
    //如果是年月，需要处理
    if(wheelView == _yearWheelView || wheelView == _monthWheelView) {
        //判断当前月有多少天
        NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate * currentDate = [NSDate dateWithFormat:[NSString stringWithFormat:@"%d-%02d-10 10:00:00",_selectYear,_selectMonth]];
        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                       inUnit: NSCalendarUnitMonth forDate:currentDate];
        //判断日是不是超过了最大的天数
        int maxDays = (int)range.length;
        if(_selectDay > maxDays)
            _selectDay = maxDays;
        [_dayWheelView setValue:_selectDay];
    }
    //设置上面时间标签的值
    _topTimeLabel.text = [NSString stringWithFormat:@"%d年%02d月%02d日 %02d:%02d",_selectYear,_selectMonth,_selectDay,_selectHour,_selectMinute];
}
//配置标签内容
- (void)wheelLabelConfig:(UILabel*)label value:(int)value wheelView:(WheelView*)wheelView {
    //年
    if(wheelView == _yearWheelView) {
       label.text = [NSString stringWithFormat:@"%d年",value];
        if(value == _selectYear) {
            label.textColor = [UIColor colorFromHexCode:@"#5eb6f3"];
        } else {
            label.textColor = [UIColor colorFromHexCode:@"#9fa8b5"];
        }
    }
    //月
    if(wheelView == _monthWheelView) {
       label.text = [NSString stringWithFormat:@"%02d月",value];
        if(value == _selectMonth) {
            label.textColor = [UIColor colorFromHexCode:@"#5eb6f3"];
        } else {
            label.textColor = [UIColor colorFromHexCode:@"#9fa8b5"];
        }
    }
    //日
    if(wheelView == _dayWheelView) {
        //时间
        NSMutableAttributedString *dateString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%02d日·",value]];
        [dateString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, dateString.length)];
        //周几
        NSDate *currDate = [NSDate dateWithFormat:[NSString stringWithFormat:@"%d-%02d-%02d 10:00:00",_selectYear,_selectMonth,value]];
        NSMutableAttributedString *weekString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"周%@",[currDate weekdayStr]]];
        [weekString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, weekString.length)];
        
        [dateString appendAttributedString:weekString];
        label.attributedText = dateString;
        if(value == _selectDay) {
            label.textColor = [UIColor colorFromHexCode:@"#5eb6f3"];
        } else {
            label.textColor = [UIColor colorFromHexCode:@"#9fa8b5"];
        }
    }
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
    
    [_yearWheelView setValue:_selectYear];
    [_monthWheelView setValue:_selectMonth];
    [_dayWheelView setValue:_selectDay];
    [_hourWheelView setValue:_selectHour];
    [_minuteWheelView setValue:_selectMinute];
    //设置上面时间标签的值
    _topTimeLabel.text = [NSString stringWithFormat:@"%d年%02d月%02d日 %02d:%02d",_selectYear,_selectMonth,_selectDay,_selectHour,_selectMinute];
}
@end
