//
//  DatePickerController.h
//  RealmDemo
//
//  Created by Mac on 2017/12/11.
//  Copyright © 2017年 com.luohaifang. All rights reserved.
//

#import <UIKit/UIKit.h>
//年、月、日 时间选择器
typedef void(^TimePicker)(NSDate *date);
@interface DatePickerController : UIViewController

//时间选择完毕回调
@property (nonatomic, copy) TimePicker timePicker;
//用户当前需要显示的时间
@property (nonatomic, strong) NSDate *selectDate;


@end
