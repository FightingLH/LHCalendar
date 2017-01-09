//
//  LHCalendarDateModel.h
//  LHCalendar
//
//  Created by lh on 17/1/9.
//  Copyright © 2017年 lh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHCalendarDateModel : NSObject
@property (nonatomic,assign) NSInteger year;//今天是哪一年
@property (nonatomic,assign) NSInteger Month;//第几月份
@property (nonatomic,assign) NSInteger dayInMonth;//今天是该月的多少号
@property (nonatomic,assign) NSInteger monthOfDays;//该月有多少天
@property (nonatomic,assign) NSInteger monthOfWeeks;//该月有几个星期
@property (nonatomic,assign) NSInteger firstDayOfThisWeek;//当月第一天是星期几

@property (nonatomic,strong) NSMutableArray *dayArray;//存放每月需要有多少个模型

-(instancetype)initWithDate:(NSDate *)date;
/**
 根据NSDate返回今天是多少号
 */
- (NSInteger)day:(NSDate *)date;

/**
 根据NSDate返回month
 */
- (NSInteger)month:(NSDate *)date;

/**
 根据NSDate返回year
 */
- (NSInteger)year:(NSDate *)date;

/**
 根据NSDate返回这个月的第一天星期几
 */
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;

/**
 根据NSDate返回这个月总共有多少天
 */
- (NSInteger)totaldaysInThisMonth:(NSDate *)date;

/**
 任意选的月份对应的天数
 */
- (NSInteger)totaldaysInMonth:(NSDate *)date;

/**
 上个月
 */
- (NSDate *)lastMonth:(NSDate *)date;

/**
 下一个月
 */
- (NSDate*)nextMonth:(NSDate *)date;

/**该月有几周 */
- (NSInteger)weekOfThisMonth:(NSDate *)date;
@end
