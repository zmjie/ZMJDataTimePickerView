//
//  ZMJViewController.m
//  ZMJDataTimePickerView
//
//  Created by zmjie on 01/15/2020.
//  Copyright (c) 2020 zmjie. All rights reserved.
//

#import "ZMJViewController.h"

#import <ZMJDataTimePickerView/ZMJDateTimePickerView.h>

@interface ZMJViewController () <zmj_dateTimePickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *zmj_tapBtn1;
@property (weak, nonatomic) IBOutlet UIButton *zmj_tapBtn2;
@property (weak, nonatomic) IBOutlet UIButton *zmj_tapBtn3;
@property (weak, nonatomic) IBOutlet UIButton *zmj_tapBtn4;

@property (weak, nonatomic) IBOutlet UILabel *zmj_titleLabel1;
@property (weak, nonatomic) IBOutlet UILabel *zmj_titleLabel2;

@property (copy, nonatomic) NSString *zmj_year;
@property (copy, nonatomic) NSString *zmj_month;
@property (copy, nonatomic) NSString *zmj_day;
@property (copy, nonatomic) NSString *zmj_hour;
@property (copy, nonatomic) NSString *zmj_minute;

@end

@implementation ZMJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)zmj_btnAction:(UIButton *)sender {
    
    if ([sender isEqual:_zmj_tapBtn1]) {
        
        ZMJDateTimePickerView *zmj_dateTimePickerView = [[ZMJDateTimePickerView alloc] initWithFrame:self.view.bounds zmj_style:ZMJDateTimePickerViewSheet zmj_year:_zmj_year zmj_month:_zmj_month zmj_day:_zmj_day];
        zmj_dateTimePickerView.zmj_delegate = self;
        [zmj_dateTimePickerView zmj_show];
        return;
    }
    
    if ([sender isEqual:_zmj_tapBtn2]) {
        
        ZMJDateTimePickerView *zmj_dateTimePickerView = [[ZMJDateTimePickerView alloc] initWithFrame:self.view.bounds zmj_style:ZMJDateTimePickerViewAlert zmj_year:_zmj_year zmj_month:_zmj_month zmj_day:_zmj_day];
        zmj_dateTimePickerView.zmj_delegate = self;
        [zmj_dateTimePickerView zmj_show];
        return;
    }
    
    if ([sender isEqual:_zmj_tapBtn3]) {
        
        ZMJDateTimePickerView *zmj_dateTimePickerView = [[ZMJDateTimePickerView alloc] initWithFrame:self.view.bounds zmj_style:ZMJDateTimePickerViewSheet zmj_hour:_zmj_hour zmj_minute:_zmj_minute];
        zmj_dateTimePickerView.zmj_delegate = self;
        [zmj_dateTimePickerView zmj_show];
        return;
    }
    
    if ([sender isEqual:_zmj_tapBtn4]) {
        
        ZMJDateTimePickerView *zmj_dateTimePickerView = [[ZMJDateTimePickerView alloc] initWithFrame:self.view.bounds zmj_style:ZMJDateTimePickerViewAlert zmj_hour:_zmj_hour zmj_minute:_zmj_minute];
        zmj_dateTimePickerView.zmj_delegate = self;
        [zmj_dateTimePickerView zmj_show];
    }
}

- (void)zmj_dateTimePickerView:(ZMJDateTimePickerView *)dateTimePickerView zmj_year:(NSString *)year zmj_month:(NSString *)month zmj_day:(NSString *)day {
    
    _zmj_year = year;
    _zmj_month = month;
    _zmj_day = day;
    
    _zmj_titleLabel1.text = [NSString stringWithFormat:@"%@-%@-%@", _zmj_year, _zmj_month, _zmj_day];
}

- (void)zmj_dateTimePickerView:(ZMJDateTimePickerView *)dateTimePickerView zmj_hour:(NSString *)hour zmj_minute:(NSString *)minute {
    
    _zmj_hour = hour;
    _zmj_minute = minute;
    
    _zmj_titleLabel2.text = [NSString stringWithFormat:@"%@:%@", _zmj_hour, _zmj_minute];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
