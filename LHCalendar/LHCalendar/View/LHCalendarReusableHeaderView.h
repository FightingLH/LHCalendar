//
//  LHCalendarReusableHeaderView.h
//  LHCalendar
//
//  Created by lh on 17/1/9.
//  Copyright © 2017年 lh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHCalendarDayModel.h"
@interface LHCalendarReusableHeaderView : UICollectionReusableView
- (void)configWithModel:(LHCalendarDayModel*)model;
@end
