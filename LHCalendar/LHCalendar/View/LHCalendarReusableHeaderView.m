//
//  LHCalendarReusableHeaderView.m
//  LHCalendar
//
//  Created by lh on 17/1/9.
//  Copyright © 2017年 lh. All rights reserved.
//

#import "LHCalendarReusableHeaderView.h"
@interface LHCalendarReusableHeaderView()
@property (nonatomic,strong) UILabel *monthLabel;
@property (nonatomic,strong) UILabel *yearLabel;
@end
@implementation LHCalendarReusableHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [self colorWithHex:0x1a1e29ff];
        [self initView];
    }
    return self;
}

- (void)initView{
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(30, 69, [UIScreen mainScreen].bounds.size.width - 30, 1);
    lineView.backgroundColor = [self colorWithHex:0xffffff19];
    [self addSubview:lineView];
    
    UILabel *monthView = [[UILabel alloc]init];
    monthView.frame = CGRectMake(30, 30, 150, 30);
    monthView.font = [UIFont systemFontOfSize:30];
    monthView.textColor = [self colorWithHex:0xffffffff];
    monthView.textAlignment = NSTextAlignmentLeft;
    [self addSubview:monthView];
    self.monthLabel = monthView;
    
    UILabel *yearView = [[UILabel alloc]init];
    yearView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 20 -100, 40, 100, 20);
    yearView.font = [UIFont systemFontOfSize:20];
    yearView.textColor = [self colorWithHex:0xffffff19];
    yearView.textAlignment = NSTextAlignmentRight;
    [self addSubview:yearView];
    self.yearLabel = yearView;
}

- (void)configWithModel:(LHCalendarDayModel*)model{
    self.monthLabel.text = model.englishMonth;
    self.yearLabel.text = model.dayYear;
}
- (UIColor *)colorWithHex:(NSInteger)hexValue {
    CGFloat r = (float)(hexValue >> 24 & 0xFF) / 255.0;
    CGFloat g = (float)(hexValue >> 16 & 0xFF) / 255.0;
    CGFloat b = (float)(hexValue >> 8 & 0xFF) / 255.0;
    CGFloat a = (float)(hexValue & 0xFF) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}
@end
