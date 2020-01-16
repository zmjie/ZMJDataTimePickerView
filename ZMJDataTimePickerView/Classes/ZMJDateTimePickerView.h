//
//  ZMJDateTimePickerView.h
//  ZMJDateTimePickerView
//
//  Created by qx on 2020/1/15.
//

#import <UIKit/UIKit.h>

#import "ZMJDateTimeModel.h"

NS_ASSUME_NONNULL_BEGIN

@class ZMJDateTimePickerView;

typedef NS_ENUM(NSUInteger, ZMJDateTimePickerViewStyle) {
    ZMJDateTimePickerViewSheet,
    ZMJDateTimePickerViewAlert,
};

@protocol zmj_dateTimePickerViewDelegate <NSObject>

@optional

- (void)zmj_dateTimePickerView:(ZMJDateTimePickerView *)dateTimePickerView zmj_year:(nullable NSString *)year zmj_month:(nullable NSString *)month zmj_day:(nullable NSString *)day;

- (void)zmj_dateTimePickerView:(ZMJDateTimePickerView *)dateTimePickerView zmj_hour:(nullable NSString *)hour zmj_minute:(nullable NSString *)minute;

@end

@interface ZMJDateTimePickerView : UIView

- (instancetype)initWithFrame:(CGRect)frame zmj_style:(ZMJDateTimePickerViewStyle)style zmj_year:(nullable NSString *)year zmj_month:(nullable NSString *)month zmj_day:(nullable NSString *)day;

- (instancetype)initWithFrame:(CGRect)frame zmj_style:(ZMJDateTimePickerViewStyle)style zmj_hour:(nullable NSString *)hour zmj_minute:(nullable NSString *)minute;

@property (weak, nonatomic) id<zmj_dateTimePickerViewDelegate>zmj_delegate;

- (void)zmj_show;
- (void)zmj_showInView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
