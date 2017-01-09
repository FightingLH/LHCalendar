//
//  LHCalendarDayModel.h
//  LHCalendar
//
//  Created by lh on 17/1/9.
//  Copyright © 2017年 lh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHCalendarDayModel : NSObject
@property (nonatomic,copy) NSString *day;//具体的显示的天
@property (nonatomic,assign) NSString *dayYear;//当天对应的当年
@property (nonatomic,assign) NSString *dayMonth;//天对应的月


@property (nonatomic,copy) NSString *festival;//具体显示的节日
@property (nonatomic,assign) BOOL isHide;//是否是可选
@property (nonatomic,assign) BOOL isCurrentDay;//是否是当前天

@property (nonatomic,assign) BOOL isWeekend;//是否是周六周日

@property (nonatomic,copy) NSString *englishMonth;//英文月份
@property (nonatomic,copy) NSString *englishMonthShort;//英文月份简写
@property (nonatomic,copy) NSString *englishWeekend;//当天对应的是周几
@end
