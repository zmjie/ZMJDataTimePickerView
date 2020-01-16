//
//  ZMJDataTimeTool.h
//  ZMJDataTimePickerView
//
//  Created by qx on 2020/1/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMJDataTimeTool : NSObject

+ (NSArray *)zmj_getDateAllDataSource;

+ (NSArray *)zmj_getTimeAllDataSource;

+ (NSInteger)zmj_getDateTimeRowArr:(NSArray *)array zmj_dateTime:(NSString *)dateTime;

@end

NS_ASSUME_NONNULL_END
