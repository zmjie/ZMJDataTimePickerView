//
//  ZMJDataTimeTool.m
//  ZMJDataTimePickerView
//
//  Created by qx on 2020/1/16.
//

#import "ZMJDataTimeTool.h"

#import "ZMJDateTimeModel.h"

@implementation ZMJDataTimeTool

+ (NSArray *)zmj_getDateAllDataSource {
    
    NSCalendar *zmj_calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger zmj_unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *zmj_dateComponent = [zmj_calendar components:zmj_unitFlags fromDate:[NSDate date]];
    
    NSInteger zmj_year = [zmj_dateComponent year];
    NSInteger zmj_month = [zmj_dateComponent month];
    NSInteger zmj_day = [zmj_dateComponent day];
    
    NSMutableArray *zmj_array = [[NSMutableArray alloc] init];
    
    for (int i = 1969; i < zmj_year; i++) {
        
        ZMJDateTimeListModel *zmj_dateTimeListModel0 = [[ZMJDateTimeListModel alloc] init];
        zmj_dateTimeListModel0.name = [NSString stringWithFormat:@"%.2d", i + 1];
        zmj_dateTimeListModel0.child = [[NSMutableArray alloc] init];
        
        [zmj_array addObject:zmj_dateTimeListModel0];
        
        NSInteger zmj_months = 12;
        
        if (i + 1 == zmj_year) {
            
            zmj_months = zmj_month;
        }
        
        for (int j = 0; j < zmj_months; j++) {
            
            ZMJDateTimeListModel *zmj_dateTimeListModel1 = [[ZMJDateTimeListModel alloc] init];
            zmj_dateTimeListModel1.name = [NSString stringWithFormat:@"%.2d", j + 1];
            zmj_dateTimeListModel1.child = [[NSMutableArray alloc] init];
            
            [zmj_dateTimeListModel0.child addObject:zmj_dateTimeListModel1];
            
            NSInteger zmj_days = zmj_day;
            
            if (i + 1 == zmj_year &&
                j + 1 == zmj_month) {}
            else {
                
                switch (j + 1) {
                        
                    case 1:
                    case 3:
                    case 5:
                    case 7:
                    case 8:
                    case 10:
                    case 12: {
                        
                        zmj_days = 31;
                    }
                        break;
                        
                    case 2: {
                        
                        if (((i + 1) % 4 == 0 && (i + 1) % 100 != 0) ||
                            (i + 1) % 400 == 0) {
                            
                            zmj_days = 29;
                            break;
                        }
                        
                        zmj_days = 28;
                    }
                        break;
                        
                    case 4:
                    case 6:
                    case 9:
                    case 11: {
                        
                        zmj_days = 30;
                    }
                        break;
                        
                    default:
                        break;
                }
            }
            
            for (int k = 0; k < zmj_days; k++) {
                
                ZMJDateTimeListModel *zmj_dateTimeListModel2 = [[ZMJDateTimeListModel alloc] init];
                zmj_dateTimeListModel2.name = [NSString stringWithFormat:@"%.2d", k + 1];
                
                [zmj_dateTimeListModel1.child addObject:zmj_dateTimeListModel2];
            }
        }
    }
    
    return zmj_array;
}

+ (NSArray *)zmj_getTimeAllDataSource {
    
    NSCalendar *zmj_calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger zmj_unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute;

    NSDateComponents *zmj_dateComponent = [zmj_calendar components:zmj_unitFlags fromDate:[NSDate date]];

    NSInteger zmj_hour = [zmj_dateComponent hour];
    NSInteger zmj_minute = [zmj_dateComponent minute];
    
    NSMutableArray *zmj_array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < zmj_hour + 1; i++) {
        
        ZMJDateTimeListModel *zmj_dateTimeListModel0 = [[ZMJDateTimeListModel alloc] init];
        zmj_dateTimeListModel0.name = [NSString stringWithFormat:@"%.2d", i];
        zmj_dateTimeListModel0.child = [[NSMutableArray alloc] init];
        
        [zmj_array addObject:zmj_dateTimeListModel0];
        
        NSInteger zmj_minutes = 59;
        
        if (i == zmj_hour) {
            
            zmj_minutes = zmj_minute;
        }
        
        for (int j = 0; j < zmj_minutes + 1; j++) {
            
            ZMJDateTimeListModel *zmj_dateTimeListModel1 = [[ZMJDateTimeListModel alloc] init];
            zmj_dateTimeListModel1.name = [NSString stringWithFormat:@"%.2d", j];
            
            [zmj_dateTimeListModel0.child addObject:zmj_dateTimeListModel1];
        }
    }
    
    return zmj_array;
}

+ (NSInteger)zmj_getDateTimeRowArr:(NSArray *)array zmj_dateTime:(NSString *)dateTime {
    
    NSInteger zmj_row = 0;
    
    __block ZMJDateTimeListModel *zmj_dateTimeListModel0;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[ZMJDateTimeListModel class]]) {
            
            ZMJDateTimeListModel *zmj_dateTimeListModel1 = (ZMJDateTimeListModel *)obj;
            
            if ([zmj_dateTimeListModel1.name isEqualToString:dateTime]) {
                
                zmj_dateTimeListModel0 = zmj_dateTimeListModel1;
                *stop = YES;
            }
        }
    }];
    
    if (zmj_dateTimeListModel0) {
        
        zmj_row = [array indexOfObject:zmj_dateTimeListModel0];
    }
    
    return zmj_row;
}

@end
