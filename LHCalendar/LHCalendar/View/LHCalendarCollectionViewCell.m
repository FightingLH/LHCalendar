//
//  LHCalendarCollectionViewCell.m
//  LHCalendar
//
//  Created by lh on 17/1/9.
//  Copyright © 2017年 lh. All rights reserved.
//

#import "LHCalendarCollectionViewCell.h"

@implementation LHCalendarCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [self colorWithHex:0x1a1e29ff];
        [self initView];
    }
    return self;
}
- (void)initView{
    //选中时显示的图片
    _imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, self.bounds.size.width, self.bounds.size.width)];
    _imgview.backgroundColor = [UIColor clearColor];
    _imgview.layer.cornerRadius = _imgview.frame.size.height/2;
    //imgview.layer.borderColor = [UIColor orangeColor].CGColor;
    _imgview.layer.masksToBounds = YES;
    [self addSubview:_imgview];
    //公历日期
    _day_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, self.bounds.size.width, 20)];
    _day_lab.textAlignment = NSTextAlignmentCenter;
    _day_lab.textColor = [UIColor whiteColor];
    _day_lab.font = [UIFont boldSystemFontOfSize:17];
    [self addSubview:_day_lab];
    //
    _day_title = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_day_lab.frame), self.bounds.size.width, 10)];
    _day_title.font = [UIFont systemFontOfSize:8];
    _day_title.textColor = [self colorWithHex:0xffffffff];
    _day_title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_day_title];
    
    //价格
    _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_day_lab.frame),  self.bounds.size.width,  10)];
    _priceLabel.font = [UIFont systemFontOfSize:8];
    _priceLabel.textColor = [self colorWithHex:0xffffffff];
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    _priceLabel.text = @"¥761";
    [self addSubview:_priceLabel];
}


- (void)configWithModel:(LHCalendarDayModel *)model withChooseDay:(LHCalendarDayModel *)chooseDay{
    _imgview.backgroundColor = [self colorWithHex:0x3499dcff];
    _day_lab.text = [NSString stringWithFormat:@"%@",model.day];
    
    if(model.isCurrentDay){
        if (chooseDay && !([model.day isEqualToString:chooseDay.day] && [model.dayYear isEqualToString:chooseDay.dayYear] && [model.dayMonth isEqualToString:chooseDay.dayMonth])) {//如果选中了其他日期(需要现实today)
            _imgview.hidden = YES;
            _day_title.text = @"TODAY";
            _day_title.hidden = NO;
        }else{
            _imgview.backgroundColor = [self colorWithHex:0x3499dcff];
            _day_title.text = @"TODAY";
            _day_title.hidden = NO;
            _imgview.hidden = NO;
        }
    }else if([model.day isEqualToString:chooseDay.day] && [model.dayYear isEqualToString:chooseDay.dayYear] && [model.dayMonth isEqualToString:chooseDay.dayMonth]){
        _imgview.backgroundColor = [self colorWithHex:0x3499dcff];
        _imgview.hidden = NO;
        _day_title.hidden = YES;
    }else{
        _imgview.hidden = YES;
        _day_title.hidden = YES;
    }
    if(model.isHide){//如果七天前不显示
        _day_lab.textColor = [self colorWithHex:0xffffff19];
    }else{
        _day_lab.textColor = [self colorWithHex:0xffffffff];
    }
    if (model.isWeekend) {
        //        _day_lab.textColor = COLOR_WITH_HEX(0xffffff19);
    }
    
}

- (UIColor *)colorWithHex:(NSInteger)hexValue {
    CGFloat r = (float)(hexValue >> 24 & 0xFF) / 255.0;
    CGFloat g = (float)(hexValue >> 16 & 0xFF) / 255.0;
    CGFloat b = (float)(hexValue >> 8 & 0xFF) / 255.0;
    CGFloat a = (float)(hexValue & 0xFF) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}
@end
