//
//  LHCalendarDayModel.m
//  LHCalendar
//
//  Created by lh on 17/1/9.
//  Copyright © 2017年 lh. All rights reserved.
//

#import "LHCalendarDayModel.h"

@implementation LHCalendarDayModel
- (BOOL)isWeekend{
    
    return [self isWeekend:[self.day integerValue] month:[self.dayMonth integerValue] year:[self.dayYear integerValue]];
}

-(NSString *)englishWeekend{
    return [self isEnglishWeekend:[self.day integerValue] month:[self.dayMonth integerValue] year:[self.dayYear integerValue]];
}

/**年,月,日,判断是周几 */
- (NSString *)isEnglishWeekend:(NSInteger)day month:(NSInteger)month year:(NSInteger)year{
    
    if (day == 0) {
        return @"";
    }
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:day-1];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:date];
    NSInteger isWeekendDay = [weekdayComponents weekday];
    switch (isWeekendDay) {
        case 7:{
            return @"Sunday";
        }
            break;
            
        case 6:{
            return @"Saturday";
        }
            break;
        case 5:{
            return @"Friday";
        }
            break;
        case 4:{
            return @"Thursday";
        }
            break;
            
        case 3:{
            return @"Wednesday";
        }
            break;
        case 2:{
            return @"Tuesday";
        }
            break;
        case 1:{
            return @"Monday";
        }
            break;
        default:{
            return @"";
        }
            break;
    }
}



/**根据年 月 日 获取今天是否是周六或周末 */
- (BOOL)isWeekend:(NSInteger)day month:(NSInteger)month year:(NSInteger)year{
    
    if (day == 0) {
        return NO;
    }
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:day-1];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:date];
    NSInteger isWeekendDay = [weekdayComponents weekday];
    if (isWeekendDay == 7 || isWeekendDay == 6) {
        return YES;
    }else{
        return NO;
    }
}

/**英文全拼 */
- (NSString *)englishMonth{
    switch ([self.dayMonth integerValue]) {
        case 12:{
            return @"December";
        }
            break;
        case 11:{
            return @"November";
        }
            break;
        case 10:{
            return @"October";
        }
            break;
        case 9:{
            return @"September";
        }
            break;
        case 8:{
            return @"August";
        }
            break;
        case 7:{
            return @"July";
        }
            break;
        case 6:{
            return @"June";
        }
            break;
        case 5:{
            return @"May";
        }
            break;
        case 4:{
            return @"April";
        }
            break;
        case 3:{
            return @"March";
        }
            break;
        case 2:{
            return @"February";
        }
            break;
        case 1:{
            return @"January";
        }
            break;
        default:{
            return nil;
        }
            break;
    }
}

/**英文缩写 */
- (NSString *)englishMonthShort{
    switch ([self.dayMonth integerValue]) {
        case 12:{
            return @"Dec.";
        }
            break;
        case 11:{
            return @"Nov.";
        }
            break;
        case 10:{
            return @"Oct.";
        }
            break;
        case 9:{
            return @"Sept.";
        }
            break;
        case 8:{
            return @"Aug.";
        }
            break;
        case 7:{
            return @"Jul.";
        }
            break;
        case 6:{
            return @"Jun.";
        }
            break;
        case 5:{
            return @"May";
        }
            break;
        case 4:{
            return @"Apr.";
        }
            break;
        case 3:{
            return @"Mar.";
        }
            break;
        case 2:{
            return @"Feb.";
        }
            break;
        case 1:{
            return @"Jan.";
        }
            break;
        default:{
            return @"";
        }
            break;
    }
}

@end
