//
//  ZMJDateTimePickerView.m
//  ZMJDateTimePickerView
//
//  Created by qx on 2020/1/15.
//

#import "ZMJDateTimePickerView.h"

#import "ZMJDateTimePickerView_Macro.h"

#import "ZMJDataTimeTool.h"

#import <Masonry/Masonry.h>

#import "UIView+ZMJDateTimePickerView.h"
#import "UIColor+ZMJDataTimePickerView.h"

typedef NS_ENUM(NSUInteger, ZMJDateTimePickerViewType) {
    ZMJDateTimePickerView_yyMMdd,
    ZMJDateTimePickerView_HHmmss,
};

@interface ZMJDateTimePickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UIView *zmj_darkBgView;
@property (strong, nonatomic) UIView *zmj_whiteBgView;

@property (strong, nonatomic) UILabel *zmj_titleLabel;

@property (strong, nonatomic) UIButton *zmj_cancelBtn;
@property (strong, nonatomic) UIButton *zmj_determineBtn;

@property (strong, nonatomic) UIPickerView *zmj_pickerView;

@property (strong, nonatomic) NSMutableArray *zmj_dataSourceArr1;
@property (strong, nonatomic) NSMutableArray *zmj_dataSourceArr2;

@property (assign, nonatomic) BOOL zmj_isShow;
@property (assign, nonatomic) BOOL zmj_isHidden;

@property (assign, nonatomic) ZMJDateTimePickerViewStyle zmj_style;
@property (assign, nonatomic) ZMJDateTimePickerViewType zmj_type;

@property (copy, nonatomic) NSString *zmj_year;
@property (copy, nonatomic) NSString *zmj_month;
@property (copy, nonatomic) NSString *zmj_day;
@property (copy, nonatomic) NSString *zmj_hour;
@property (copy, nonatomic) NSString *zmj_minute;

@end

@implementation ZMJDateTimePickerView

- (instancetype)initWithFrame:(CGRect)frame zmj_style:(ZMJDateTimePickerViewStyle)style zmj_year:(nullable NSString *)year zmj_month:(nullable NSString *)month zmj_day:(nullable NSString *)day {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        
        _zmj_style = style;
        _zmj_type = ZMJDateTimePickerView_yyMMdd;
        _zmj_year = year;
        _zmj_month = month;
        _zmj_day = day;
        
        [self zmj_initView];
        [self zmj_initData];
        [self zmj_makeSubViewsConstraints];
        
        [self layoutIfNeeded];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame zmj_style:(ZMJDateTimePickerViewStyle)style zmj_hour:(nullable NSString *)hour zmj_minute:(nullable NSString *)minute {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        
        _zmj_style = style;
        _zmj_type = ZMJDateTimePickerView_HHmmss;
        _zmj_hour = hour;
        _zmj_minute = minute;
        
        [self zmj_initView];
        [self zmj_initData];
        [self zmj_makeSubViewsConstraints];
        
        [self layoutIfNeeded];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_zmj_whiteBgView.zmj_width == 0) {
        return;
    }
    
    if (_zmj_whiteBgView.zmj_height > 0) {
        
        _zmj_whiteBgView.layer.cornerRadius = zmj_size(10);
        _zmj_whiteBgView.clipsToBounds = YES;
    }
}

- (void)zmj_show {
    
    [self zmj_showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)zmj_showInView:(UIView *)view {
    
    if (_zmj_isShow) {
        return;
    }
    
    _zmj_isShow = YES;
    
    [UIView animateWithDuration:0.6f animations:^{
        
        self.zmj_darkBgView.alpha = 0.5f;
        
    }completion:^(BOOL finished) {
        
        self.zmj_isShow = NO;
    }];
    [view addSubview:self];
    
    switch (_zmj_style) {
            
        case ZMJDateTimePickerViewSheet: {
            
            [self.class zmj_animationSheetView:_zmj_whiteBgView isShow:YES];
        }
            break;
            
        case ZMJDateTimePickerViewAlert: {
            
            [self.class zmj_animationAlertView:_zmj_whiteBgView isShow:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)zmj_dismissBtn:(UIButton *)btn {
    
    if (_zmj_isHidden) {
        return;
    }
    
    _zmj_isHidden = YES;
    
    [UIView animateWithDuration:0.6f animations:^{
        
        self.zmj_darkBgView.alpha = 0.0f;
        
    }completion:^(BOOL finished) {
        
        self.zmj_isHidden = NO;
        
        if ([btn isEqual:self.zmj_determineBtn]) {
            
            ZMJDateTimeListModel *zmj_dateTimeListModel0;
            
            if ([self.zmj_dataSourceArr2[0] count] > [self.zmj_pickerView selectedRowInComponent:0]) {
                
                zmj_dateTimeListModel0 = self.zmj_dataSourceArr2[0][[self.zmj_pickerView selectedRowInComponent:0]];
            }
            
            ZMJDateTimeListModel *zmj_dateTimeListModel1;
            
            if ([self.zmj_dataSourceArr2[1] count] > [self.zmj_pickerView selectedRowInComponent:1]) {
                
                zmj_dateTimeListModel1 = self.zmj_dataSourceArr2[1][[self.zmj_pickerView selectedRowInComponent:1]];
            }
            
            switch (self.zmj_type) {
                    
                case ZMJDateTimePickerView_yyMMdd: {
                    
                    ZMJDateTimeListModel *zmj_dateTimeListModel2;
                    
                    if ([self.zmj_dataSourceArr2[2] count] > [self.zmj_pickerView selectedRowInComponent:2]) {
                        
                        zmj_dateTimeListModel2 = self.zmj_dataSourceArr2[2][[self.zmj_pickerView selectedRowInComponent:2]];
                    }
                    
                    if ([self.zmj_delegate respondsToSelector:@selector(zmj_dateTimePickerView:zmj_year:zmj_month:zmj_day:)]) {

                        [self.zmj_delegate zmj_dateTimePickerView:self zmj_year:zmj_dateTimeListModel0.name zmj_month:zmj_dateTimeListModel1.name zmj_day:zmj_dateTimeListModel2.name];
                    }
                }
                    break;
                    
                case ZMJDateTimePickerView_HHmmss: {
                    
                    if ([self.zmj_delegate respondsToSelector:@selector(zmj_dateTimePickerView:zmj_hour:zmj_minute:)]) {

                        [self.zmj_delegate zmj_dateTimePickerView:self zmj_hour:zmj_dateTimeListModel0.name zmj_minute:zmj_dateTimeListModel1.name];
                    }
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        [self removeFromSuperview];
    }];
    
    switch (_zmj_style) {
            
        case ZMJDateTimePickerViewSheet: {
            
            [self.class zmj_animationSheetView:_zmj_whiteBgView isShow:NO];
        }
            break;
            
        case ZMJDateTimePickerViewAlert: {
            
            [self.class zmj_animationAlertView:_zmj_whiteBgView isShow:NO];
        }
            break;
            
        default:
            break;
    }
}

- (void)zmj_initView {
    
    [self addSubview:self.zmj_darkBgView];
    [self addSubview:self.zmj_whiteBgView];
    
    [_zmj_whiteBgView addSubview:self.zmj_titleLabel];
    [_zmj_whiteBgView addSubview:self.zmj_cancelBtn];
    [_zmj_whiteBgView addSubview:self.zmj_determineBtn];
    [_zmj_whiteBgView addSubview:self.zmj_pickerView];
}

- (void)zmj_initData {
    
    NSCalendar *zmj_calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger zmj_unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    
    NSDateComponents *zmj_dateComponent = [zmj_calendar components:zmj_unitFlags fromDate:[NSDate date]];
    
    NSInteger zmj_year = [zmj_dateComponent year];
    NSInteger zmj_month = [zmj_dateComponent month];
    NSInteger zmj_day = [zmj_dateComponent day];
    NSInteger zmj_hour = [zmj_dateComponent hour];
    NSInteger zmj_minute = [zmj_dateComponent minute];
    
    switch (_zmj_type) {
            
        case ZMJDateTimePickerView_yyMMdd: {
            
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                
                [self.zmj_dataSourceArr1 addObjectsFromArray:[ZMJDataTimeTool zmj_getDateAllDataSource]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (self.zmj_dataSourceArr1.count > 0) {
                        
                        [self.zmj_dataSourceArr2 addObject:self.zmj_dataSourceArr1];
                    }
                    
                    if (self.zmj_dataSourceArr2.count > 0) {
                        
                        NSInteger zmj_row = [ZMJDataTimeTool zmj_getDateTimeRowArr:self.zmj_dataSourceArr2[0] zmj_dateTime:self.zmj_year ? : [NSString stringWithFormat:@"%.2ld", zmj_year]];
                        
                        ZMJDateTimeListModel *zmj_dateTimeListModel = self.zmj_dataSourceArr2[0][zmj_row];
                        [self.zmj_dataSourceArr2 addObject:zmj_dateTimeListModel.child];
                    }
                    
                    if (self.zmj_dataSourceArr2.count > 1) {
                        
                        NSInteger zmj_row = [ZMJDataTimeTool zmj_getDateTimeRowArr:self.zmj_dataSourceArr2[1] zmj_dateTime:self.zmj_month ? : [NSString stringWithFormat:@"%.2ld", zmj_month]];
                        
                        ZMJDateTimeListModel *zmj_dateTimeListModel = self.zmj_dataSourceArr2[1][zmj_row];
                        [self.zmj_dataSourceArr2 addObject:zmj_dateTimeListModel.child];
                    }
                    
                    [self.zmj_pickerView reloadAllComponents];
                    
                    ZMJDateTimeListModel *zmj_dateTimeListModel0;
                    
                    if ([self.zmj_dataSourceArr2[0] count] > 0) {
                        
                        NSInteger zmj_row = [ZMJDataTimeTool zmj_getDateTimeRowArr:self.zmj_dataSourceArr2[0] zmj_dateTime:self.zmj_year ? : [NSString stringWithFormat:@"%ld", zmj_year]];
                        
                        zmj_dateTimeListModel0 = self.zmj_dataSourceArr2[0][zmj_row];
                        
                        [self.zmj_pickerView selectRow:zmj_row inComponent:0 animated:NO];
                    }
                    
                    ZMJDateTimeListModel *zmj_dateTimeListModel1;
                    
                    if (zmj_dateTimeListModel0.child.count > 0) {
                        
                        NSInteger zmj_row = [ZMJDataTimeTool zmj_getDateTimeRowArr:zmj_dateTimeListModel0.child zmj_dateTime:self.zmj_month ? : [NSString stringWithFormat:@"%.2ld", zmj_month]];
                        
                        zmj_dateTimeListModel1 = zmj_dateTimeListModel0.child[zmj_row];
                        
                        [self.zmj_pickerView selectRow:zmj_row inComponent:1 animated:NO];
                    }
                    
                    ZMJDateTimeListModel *zmj_dateTimeListModel2;

                    if (zmj_dateTimeListModel1.child.count > 0) {

                        NSInteger zmj_row = [ZMJDataTimeTool zmj_getDateTimeRowArr:zmj_dateTimeListModel1.child zmj_dateTime:self.zmj_day ? : [NSString stringWithFormat:@"%.2ld", zmj_day]];

                        zmj_dateTimeListModel2 = zmj_dateTimeListModel1.child[zmj_row];

                        [self.zmj_pickerView selectRow:zmj_row inComponent:2 animated:NO];
                    }

                    self.zmj_titleLabel.text = [NSString stringWithFormat:@"%@-%@-%@",
                                                zmj_dateTimeListModel0 ? zmj_dateTimeListModel0.name : @"",
                                                zmj_dateTimeListModel1 ? zmj_dateTimeListModel1.name : @"",
                                                zmj_dateTimeListModel2 ? zmj_dateTimeListModel2.name : @""];
                });
            });
        }
            break;
            
        case ZMJDateTimePickerView_HHmmss: {
            
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                
                [self.zmj_dataSourceArr1 addObjectsFromArray:[ZMJDataTimeTool zmj_getTimeAllDataSource]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (self.zmj_dataSourceArr1.count > 0) {
                        
                        [self.zmj_dataSourceArr2 addObject:self.zmj_dataSourceArr1];
                    }
                    
                    if (self.zmj_dataSourceArr2.count > 0) {
                        
                        NSInteger zmj_row = [ZMJDataTimeTool zmj_getDateTimeRowArr:self.zmj_dataSourceArr2[0] zmj_dateTime:self.zmj_hour ? : [NSString stringWithFormat:@"%.2ld", zmj_hour]];
                        
                        ZMJDateTimeListModel *zmj_dateTimeListModel = self.zmj_dataSourceArr2[0][zmj_row];
                        [self.zmj_dataSourceArr2 addObject:zmj_dateTimeListModel.child];
                    }
                    
                    [self.zmj_pickerView reloadAllComponents];
                    
                    ZMJDateTimeListModel *zmj_dateTimeListModel0;
                    
                    if ([self.zmj_dataSourceArr2[0] count] > 0) {
                        
                        NSInteger zmj_row = [ZMJDataTimeTool zmj_getDateTimeRowArr:self.zmj_dataSourceArr2[0] zmj_dateTime:self.zmj_hour ? : [NSString stringWithFormat:@"%ld", zmj_hour]];
                        
                        zmj_dateTimeListModel0 = self.zmj_dataSourceArr2[0][zmj_row];
                        
                        [self.zmj_pickerView selectRow:zmj_row inComponent:0 animated:NO];
                    }
                    
                    ZMJDateTimeListModel *zmj_dateTimeListModel1;
                    
                    if (zmj_dateTimeListModel0.child.count > 0) {
                        
                        NSInteger zmj_row = [ZMJDataTimeTool zmj_getDateTimeRowArr:zmj_dateTimeListModel0.child zmj_dateTime:self.zmj_minute ? : [NSString stringWithFormat:@"%.2ld", zmj_minute]];
                        
                        zmj_dateTimeListModel1 = zmj_dateTimeListModel0.child[zmj_row];
                        
                        [self.zmj_pickerView selectRow:zmj_row inComponent:1 animated:NO];
                    }

                    self.zmj_titleLabel.text = [NSString stringWithFormat:@"%@:%@",
                                                zmj_dateTimeListModel0 ? zmj_dateTimeListModel0.name : @"",
                                                zmj_dateTimeListModel1 ? zmj_dateTimeListModel1.name : @""];
                });
            });
        }
            break;
            
        default:
            break;
    }
}

- (void)zmj_makeSubViewsConstraints {
    
    [_zmj_darkBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    switch (_zmj_style) {
            
        case ZMJDateTimePickerViewSheet: {
            
            [_zmj_whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.trailing.equalTo(self);
                make.bottom.equalTo(self.mas_bottom).offset(zmj_size(50));
            }];
            
            [_zmj_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.centerX.equalTo(self.zmj_whiteBgView);
                make.height.mas_equalTo(zmj_size(50));
            }];
            
            [_zmj_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.leading.equalTo(self.zmj_whiteBgView);
                make.trailing.equalTo(self.zmj_titleLabel.mas_leading);
                make.width.mas_equalTo(zmj_size(80));
                make.height.equalTo(self.zmj_titleLabel);
            }];
            
            [_zmj_determineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.trailing.equalTo(self.zmj_whiteBgView);
                make.leading.equalTo(self.zmj_titleLabel.mas_trailing);
                make.width.equalTo(self.zmj_cancelBtn);
                make.height.equalTo(self.zmj_titleLabel);
            }];
            
            [_zmj_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.zmj_titleLabel.mas_bottom);
                make.leading.trailing.equalTo(self);
                make.bottom.equalTo(self.zmj_whiteBgView.mas_bottom).offset(-zmj_size(45));
                make.height.mas_equalTo(zmj_size(265));
            }];
        }
            break;
            
        case ZMJDateTimePickerViewAlert: {
            
            [_zmj_whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.leading.equalTo(self).offset(zmj_size(20));
                make.trailing.equalTo(self).offset(-zmj_size(20));
            }];
            
            [_zmj_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.leading.trailing.equalTo(self.zmj_whiteBgView);
                make.height.mas_equalTo(zmj_size(50));
            }];
            
            [_zmj_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.zmj_titleLabel.mas_bottom);
                make.leading.trailing.equalTo(self.zmj_whiteBgView);
                make.height.mas_equalTo(zmj_size(220));
            }];
            
            [_zmj_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.zmj_pickerView.mas_bottom);
                make.leading.bottom.equalTo(self.zmj_whiteBgView);
                make.height.mas_equalTo(zmj_size(60));
            }];
            
            [_zmj_determineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.zmj_cancelBtn);
                make.leading.equalTo(self.zmj_cancelBtn.mas_trailing).offset(1.0f);
                make.trailing.equalTo(self.zmj_whiteBgView);
                make.width.height.equalTo(self.zmj_cancelBtn);
            }];
        }
            break;
            
        default:
            break;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return _zmj_dataSourceArr2.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [_zmj_dataSourceArr2[component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSArray *zmj_array = _zmj_dataSourceArr2[component];
    
    if (row < zmj_array.count) {
        
        ZMJDateTimeListModel *zmj_dateTimeListModel = _zmj_dataSourceArr2[component][row];
        
        return zmj_dateTimeListModel.name;
    }
    return @"";
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *zmj_titleLabel = (UILabel*)view;
    
    if (!zmj_titleLabel) {
        
        zmj_titleLabel = [[UILabel alloc] init];
        zmj_titleLabel.textAlignment = NSTextAlignmentCenter;
        zmj_titleLabel.backgroundColor = [UIColor zmj_dynamicColor:[UIColor clearColor] zmj_darkColor:[UIColor clearColor]];
        zmj_titleLabel.font = zmj_pingFangSCRegularSize((zmj_defaultFontSize + 4));
    }
    
    zmj_titleLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return zmj_titleLabel;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return zmj_size(50);
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    switch (component) {
            
        case 0:{
            
            ZMJDateTimeListModel *zmj_dateTimeListModel1 = self.zmj_dataSourceArr2[0][row];
            [_zmj_dataSourceArr2 replaceObjectAtIndex:1 withObject:zmj_dateTimeListModel1.child];
            
            [pickerView reloadComponent:1];
            
            [pickerView selectRow:0 inComponent:1 animated:NO];
            
            switch (_zmj_type) {
                    
                case ZMJDateTimePickerView_yyMMdd: {
                    
                    ZMJDateTimeListModel *zmj_dateTimeListModel2 = zmj_dateTimeListModel1.child[0];
                    [_zmj_dataSourceArr2 replaceObjectAtIndex:2 withObject:zmj_dateTimeListModel2.child];
                    
                    [pickerView reloadComponent:2];
                    
                    [pickerView selectRow:0 inComponent:2 animated:NO];
                }
                    break;
                    
                case ZMJDateTimePickerView_HHmmss:break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 1:{
            
            switch (_zmj_type) {
                    
                case ZMJDateTimePickerView_yyMMdd: {
                    
                    ZMJDateTimeListModel *zmj_dateTimeListModel = self.zmj_dataSourceArr2[1][row];
                    [_zmj_dataSourceArr2 replaceObjectAtIndex:2 withObject:zmj_dateTimeListModel.child];
                    
                    [pickerView reloadComponent:2];
                    
                    [pickerView selectRow:0 inComponent:2 animated:NO];
                }
                    break;
                    
                case ZMJDateTimePickerView_HHmmss:break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    ZMJDateTimeListModel *zmj_dateTimeListModel0 = _zmj_dataSourceArr2[0][[pickerView selectedRowInComponent:0]];

    ZMJDateTimeListModel *zmj_dateTimeListModel1;

    if ([_zmj_dataSourceArr2[1] count] > [pickerView selectedRowInComponent:1]) {

        zmj_dateTimeListModel1 = _zmj_dataSourceArr2[1][[pickerView selectedRowInComponent:1]];
    }
    
    switch (_zmj_type) {
            
        case ZMJDateTimePickerView_yyMMdd: {
            
            ZMJDateTimeListModel *zmj_dateTimeListModel2;

            if ([_zmj_dataSourceArr2[2] count] > [pickerView selectedRowInComponent:2]) {

                zmj_dateTimeListModel2 = _zmj_dataSourceArr2[2][[pickerView selectedRowInComponent:2]];
            }

            _zmj_titleLabel.text = [NSString stringWithFormat:@"%@-%@-%@",
                                    zmj_dateTimeListModel0 ? zmj_dateTimeListModel0.name : @"",
                                    zmj_dateTimeListModel1 ? zmj_dateTimeListModel1.name : @"",
                                    zmj_dateTimeListModel2 ? zmj_dateTimeListModel2.name : @""];
        }
            break;
            
        case ZMJDateTimePickerView_HHmmss: {
            
            _zmj_titleLabel.text = [NSString stringWithFormat:@"%@:%@",
                                    zmj_dateTimeListModel0 ? zmj_dateTimeListModel0.name : @"",
                                    zmj_dateTimeListModel1 ? zmj_dateTimeListModel1.name : @""];
        }
            break;
            
        default:
            break;
    }
}

- (UIView *)zmj_darkBgView {
    if (!_zmj_darkBgView) {
        _zmj_darkBgView = [[UIView alloc] init];
        _zmj_darkBgView.backgroundColor = [UIColor zmj_dynamicColor:[UIColor blackColor] zmj_darkColor:[UIColor blackColor]];
        _zmj_darkBgView.alpha = 0.0f;
    }
    return _zmj_darkBgView;
}

- (UIView *)zmj_whiteBgView {
    if (!_zmj_whiteBgView) {
        _zmj_whiteBgView = [[UIView alloc] init];
        _zmj_whiteBgView.backgroundColor = [UIColor zmj_dynamicColor:zmj_color(240, 239, 245) zmj_darkColor:zmj_color(240, 239, 245)];
    }
    return _zmj_whiteBgView;
}

- (UILabel *)zmj_titleLabel {
    if (!_zmj_titleLabel) {
        _zmj_titleLabel = [[UILabel alloc] init];
        _zmj_titleLabel.textAlignment = NSTextAlignmentCenter;
        _zmj_titleLabel.font = zmj_pingFangSCRegularSize((zmj_defaultFontSize + 2));
        _zmj_titleLabel.backgroundColor = [UIColor zmj_dynamicColor:[UIColor whiteColor] zmj_darkColor:[UIColor whiteColor]];
    }
    return _zmj_titleLabel;
}

- (UIButton *)zmj_cancelBtn {
    if (!_zmj_cancelBtn) {
        _zmj_cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_zmj_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _zmj_cancelBtn.titleLabel.font = zmj_pingFangSCRegularSize((zmj_defaultFontSize + 4));
        _zmj_cancelBtn.backgroundColor = [UIColor zmj_dynamicColor:[UIColor whiteColor] zmj_darkColor:[UIColor whiteColor]];
        [_zmj_cancelBtn addTarget:self action:@selector(zmj_btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        switch (_zmj_style) {
                
            case ZMJDateTimePickerViewSheet: {
                
                _zmj_cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [_zmj_cancelBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, zmj_size(15), 0, 0)];
            }
                break;
                
            case ZMJDateTimePickerViewAlert:break;
                
            default:
                break;
        }
    }
    return _zmj_cancelBtn;
}

- (UIButton *)zmj_determineBtn {
    if (!_zmj_determineBtn) {
        _zmj_determineBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_zmj_determineBtn setTitle:@"确定" forState:UIControlStateNormal];
        _zmj_determineBtn.titleLabel.font = zmj_pingFangSCRegularSize((zmj_defaultFontSize + 4));
        _zmj_determineBtn.backgroundColor = [UIColor zmj_dynamicColor:[UIColor whiteColor] zmj_darkColor:[UIColor whiteColor]];
        [_zmj_determineBtn addTarget:self action:@selector(zmj_btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        switch (_zmj_style) {
                
            case ZMJDateTimePickerViewSheet: {
                
                _zmj_determineBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                [_zmj_determineBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, zmj_size(15))];
            }
                break;
                
            case ZMJDateTimePickerViewAlert:break;
                
            default:
                break;
        }
    }
    return _zmj_determineBtn;
}

- (UIPickerView *)zmj_pickerView {
    if (!_zmj_pickerView) {
        _zmj_pickerView = [[UIPickerView alloc] init];
        _zmj_pickerView.delegate = self;
        _zmj_pickerView.dataSource = self;
        _zmj_pickerView.backgroundColor = [UIColor zmj_dynamicColor:zmj_color(240, 239, 245) zmj_darkColor:zmj_color(240, 239, 245)];
    }
    return _zmj_pickerView;
}

- (NSMutableArray *)zmj_dataSourceArr1 {
    if (!_zmj_dataSourceArr1) {
        _zmj_dataSourceArr1 = [[NSMutableArray alloc] init];
    }
    return _zmj_dataSourceArr1;
}

- (NSMutableArray *)zmj_dataSourceArr2 {
    if (!_zmj_dataSourceArr2) {
        _zmj_dataSourceArr2 = [[NSMutableArray alloc] init];
    }
    return _zmj_dataSourceArr2;
}

- (void)zmj_btnAction:(UIButton *)btn {
    
    [self zmj_dismissBtn:btn];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (_zmj_isShow ||
        _zmj_isHidden) {
        return;
    }
    
    UITouch *touch = touches.anyObject;
    
    if (!CGRectContainsPoint(_zmj_whiteBgView.frame, [touch locationInView:self])) {
        
        [self zmj_dismissBtn:_zmj_cancelBtn];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
