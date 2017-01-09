//
//  LHCalendarViewController.h
//  LHCalendar
//
//  Created by lh on 17/1/9.
//  Copyright © 2017年 lh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LHCalendarDayModel;
typedef void(^VFCalendarResult)(id model);
@interface LHCalendarViewController : UIViewController
/**
 选择的结果
 */
@property (nonatomic,copy) VFCalendarResult resultBlock;
@property (nonatomic,strong) LHCalendarDayModel *dayModel;
@end
