//
//  UIView+ZMJDateTimePickerView.h
//  ZMJDateTimePickerView
//
//  Created by qx on 2020/1/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZMJDateTimePickerView)

@property (assign, nonatomic) CGFloat zmj_width;

@property (assign, nonatomic) CGFloat zmj_height;

@property (assign, nonatomic) CGFloat zmj_x;

@property (assign, nonatomic) CGFloat zmj_y;

@property (assign, nonatomic) CGFloat zmj_centerX;

@property (assign, nonatomic) CGFloat zmj_centerY;

+ (void)zmj_animationSheetView:(UIView *)view isShow:(BOOL)bl;

+ (void)zmj_animationAlertView:(UIView *)view isShow:(BOOL)bl;

@end

NS_ASSUME_NONNULL_END
