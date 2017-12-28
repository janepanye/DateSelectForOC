//
//  ViewController.m
//  DateSelectDemo
//
//  Created by Mac on 2017/12/28.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "TimePickerController.h"
#import "DatePickerController.h"
#import "DateTimePickerController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"时间选择器";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(50, 50, 200, 50);
        [button setTitle:@"时分选择器" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(timeClicke:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(50, 150, 200, 50);
        [button setTitle:@"年月日选择器" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(dateClicke:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(50, 250, 200, 50);
        [button setTitle:@"年月日时分选择器" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(datetimeClicke:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}
- (void)timeClicke:(UIButton*)button {
    TimePickerController *select = [TimePickerController new];
    select.selectDate = [NSDate new];
    select.timePicker = ^(NSDate *date) {
        
    };
    select.providesPresentationContextTransitionStyle = YES;
    select.definesPresentationContext = YES;
    select.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:select animated:NO completion:nil];
}
- (void)dateClicke:(UIButton*)button {
    DatePickerController *select = [DatePickerController new];
    select.selectDate = [NSDate new];
    select.timePicker = ^(NSDate *date) {
        
    };
    select.providesPresentationContextTransitionStyle = YES;
    select.definesPresentationContext = YES;
    select.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:select animated:NO completion:nil];
}
- (void)datetimeClicke:(UIButton*)button {
    DateTimePickerController *select = [DateTimePickerController new];
    select.selectDate = [NSDate new];
    select.timePicker = ^(NSDate *date) {
        
    };
    select.providesPresentationContextTransitionStyle = YES;
    select.definesPresentationContext = YES;
    select.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:select animated:NO completion:nil];
}


@end
