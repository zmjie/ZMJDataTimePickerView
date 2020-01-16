//
//  ZMJDateTimeModel.h
//  ZMJDataTimePickerView
//
//  Created by qx on 2020/1/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMJDateTimeModel : NSObject

@end

@interface ZMJDateTimeListModel : NSObject

@property (copy, nonatomic) NSString *name;

@property (strong, nonatomic) NSMutableArray *child;

@end

NS_ASSUME_NONNULL_END
