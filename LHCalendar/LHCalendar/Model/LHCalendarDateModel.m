//
//  LHCalendarDateModel.m
//  LHCalendar
//
//  Created by lh on 17/1/9.
//  Copyright © 2017年 lh. All rights reserved.
//

#import "LHCalendarDateModel.h"
#import "LHCalendarDayModel.h"

@interface LHCalendarDateModel()
/**系统的上一个月 */
@property (nonatomic,assign) NSInteger sysLastYear;
@property (nonatomic,assign) NSInteger sysLastMonth;
@property (nonatomic,assign) NSInteger sysLastDayInMonth;
@property (nonatomic,assign) NSInteger sysLastMonthofWeeks;
@property (nonatomic,assign) NSInteger sysLastFirstDayOfthisWeeks;

@property (nonatomic,assign) NSInteger sysCurrentYear;
@property (nonatomic,assign) NSInteger sysCurrentMonth;
@property (nonatomic,assign) NSInteger sysCurrentFirstDayOfThisWeeks;
@property (nonatomic,assign) NSInteger sysCurrentDayInMonth;
@end
@implementation LHCalendarDateModel
- (NSMutableArray *)dayArray{
    if (!_dayArray) {
        _dayArray = [NSMutableArray new];
    }
    return _dayArray;
}

- (instancetype)initWithDate:(NSDate *)date{
    if (self == [super init]) {
        self.monthOfDays = [self totaldaysInMonth:date];
        self.year = [self year:date];
        self.Month = [self month:date];
        self.dayInMonth = [self day:date];
        self.monthOfWeeks = [self weekOfThisMonth:date];
        self.firstDayOfThisWeek = [self firstWeekdayInThisMonth:date];
        [self returnLastMonthInfomation];
        //当前系统对应年月日天
        NSDate *sysDate = [NSDate new];
        
        for (int i = 0; i<self.firstDayOfThisWeek; i++) {
            LHCalendarDayModel *calenDay = [[LHCalendarDayModel alloc]init];
            calenDay.day = @"";
            calenDay.isCurrentDay = NO;
            calenDay.isHide = YES;
            calenDay.dayMonth = [NSString stringWithFormat:@"%ld",self.Month];
            calenDay.dayYear = [NSString stringWithFormat:@"%ld",self.year];
            [self.dayArray addObject:calenDay];
        }
        
        for (int i = 1; i<self.monthOfDays+1; i++) {
            LHCalendarDayModel *calendarDay = [[LHCalendarDayModel alloc]init];
            calendarDay.day = [NSString stringWithFormat:@"%d",i];
            calendarDay.dayYear = [NSString stringWithFormat:@"%ld",self.year];
            calendarDay.dayMonth = [NSString stringWithFormat:@"%ld",self.Month];
            if (self.year == [self year:sysDate] && self.Month == [self month:sysDate]) {//如果是system
                if (i == self.dayInMonth) {
                    calendarDay.isCurrentDay= YES;//显示今天
                }
                if(self.dayInMonth > 7){//当前月日号>7不可选
                    if(i < self.dayInMonth - 7){
                        calendarDay.isHide = YES;
                    }
                }else if (self.dayInMonth < 7) {
                    if (i < self.dayInMonth) {
                        calendarDay.isHide = NO;
                    }
                }
            }
            
            if (self.year == self.sysLastYear && self.Month == self.sysLastMonth) {/**找到上个月 */
                if((( self.monthOfDays+self.sysCurrentDayInMonth) -  7 ) > i ){
                    calendarDay.isHide = YES;
                }
            }
            
            [self.dayArray addObject:calendarDay];
        }
    }
    return self;
}


/**计算当前系统前的一个月的信息 */
-(void)returnLastMonthInfomation{
    NSDate *date = [NSDate new];
    self.sysCurrentFirstDayOfThisWeeks = [self firstWeekdayInThisMonth:date];
    self.sysCurrentDayInMonth = [self day:date];
    
    NSDate *lastDate = [self lastMonth:date];
    self.sysLastYear = [self year:lastDate];
    self.sysLastMonth = [self month:lastDate];
}


- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}


- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}


- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

- (NSInteger)totaldaysInThisMonth:(NSDate *)date{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}

- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}

- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}


- (NSInteger)weekOfThisMonth:(NSDate *)date{
    NSRange rang = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:date];
    return rang.length;
}

@end
