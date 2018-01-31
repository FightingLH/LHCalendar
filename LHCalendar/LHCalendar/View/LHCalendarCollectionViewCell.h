//
//  LHCalendarCollectionViewCell.h
//  LHCalendar
//
//  Created by lh on 17/1/9.
//  Copyright © 2017年 lh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHCalendarDayModel.h"
@interface LHCalendarCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)  UILabel *day_lab;//显示公历
@property (nonatomic,strong)  UILabel *day_title;//显示
@property (nonatomic,strong)  UIImageView *imgview;
@property (nonatomic,strong)  UILabel     *priceLabel;
-(void)configWithModel:(LHCalendarDayModel *)model withChooseDay:(LHCalendarDayModel *)chooseDay;
@end
