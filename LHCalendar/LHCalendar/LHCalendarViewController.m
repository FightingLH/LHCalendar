//
//  LHCalendarViewController.m
//  LHCalendar
//
//  Created by lh on 17/1/9.
//  Copyright © 2017年 lh. All rights reserved.
//

#import "LHCalendarViewController.h"
#import "LHCalendarDateModel.h"
#import "LHCalendarDayModel.h"
#import "LHCalendarViewLayout.h"
#import "LHCalendarCollectionViewCell.h"
#import "LHCalendarReusableHeaderView.h"

static NSString *kMonthHeader = @"MonthHeader";
static NSString *kDayCell = @"kDayCell";
@interface LHCalendarViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

/**存放显示的月份数组 */
@property (nonatomic,strong) NSMutableArray *monthArray;
/**开始月份到大月份 */
@property (nonatomic,assign) NSInteger startMonth;
@property (nonatomic,assign) NSInteger endMonth;

@end

@implementation LHCalendarViewController

-(NSMutableArray *)monthArray{
    if (!_monthArray) {
        _monthArray = [NSMutableArray new];
    }
    return _monthArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [self colorWithHex:0x1a1e29ff];
    self.navigationItem.title = @"Date";
    /**获取当前的月分开始的十二个月数据 */
    [self initView];
    [self data];
    
}

- (void)data{
    // 当前时间
    LHCalendarDateModel *results = [[LHCalendarDateModel alloc]initWithDate:[NSDate new]];
    [self.monthArray addObject:results];
    NSDate *currentDate = [results nextMonth:[NSDate new]];
    /** 如果当前天数是小于7号，则需要多加上个月的月一共十三个月，否则是十二个月 */
    if (results.dayInMonth < 7) {
        LHCalendarDateModel *lastResult = [[LHCalendarDateModel alloc]initWithDate:[results lastMonth:[NSDate new]]];
        [self.monthArray insertObject:lastResult atIndex:0];
    }
    for (int i = 0; i < 11; i++) {
        LHCalendarDateModel *result = [[LHCalendarDateModel alloc]initWithDate:currentDate];
        ;
        currentDate = [result nextMonth:currentDate];
        [self.monthArray addObject:result];
    }
    [self.collectionView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
}


#pragma mark -initView
- (void)initView{
    
    UIView *weekView = [[UIView alloc]init];
    weekView.frame = CGRectMake(0, 64,[UIScreen mainScreen].bounds.size.width, 35);
    weekView.backgroundColor = [self colorWithHex:0x1a1e29ff];
    [self.view addSubview:weekView];
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, 98, [UIScreen mainScreen].bounds.size.width, 1);
    lineView.backgroundColor = [self colorWithHex:0xffffff19];
    [self.view addSubview:lineView];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width/7.0;
    NSArray *weekDayArray = @[@"SUN.",@"MON.",@"TUE.",@"WED.",@"THUR.",@"FRI.",@"SAT."];
    for (int i = 0; i<7; i++) {
        UILabel *week = [[UILabel alloc]initWithFrame:CGRectMake(i*width, 0, width, 35)];
        week.text = weekDayArray[i];
        week.font = [UIFont systemFontOfSize:14];
        week.textAlignment = NSTextAlignmentCenter;
        week.textColor = [self colorWithHex:0xffffffff];
        [weekView addSubview:week];
    }
    
    LHCalendarViewLayout *layOut = [[LHCalendarViewLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64+35, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height- 64-35) collectionViewLayout:layOut]; //初始化网格视图大小
    [self.collectionView registerClass:[LHCalendarCollectionViewCell class] forCellWithReuseIdentifier:kDayCell];//cell重用设置ID
    [self.collectionView registerClass:[LHCalendarReusableHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kMonthHeader];
    //self.collectionView.bounces = NO;//将网格视图的下拉效果关闭
    self.collectionView.delegate = self;//实现网格视图的delegate
    self.collectionView.dataSource = self;//实现网格视图的dataSource
    self.collectionView.backgroundColor = [self colorWithHex:0x1a1e29ff];
    [self.view addSubview:self.collectionView];
}


#pragma mark - CollectionView代理方法
//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.monthArray.count;
}
//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    LHCalendarDateModel *date = self.monthArray[section];
    return date.dayArray.count;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LHCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDayCell forIndexPath:indexPath];
    cell.backgroundColor = [self colorWithHex:0x1a1e29ff];;
    LHCalendarDateModel *date = self.monthArray[indexPath.section];
    LHCalendarDayModel *curremtDay = date.dayArray[indexPath.row];
    [cell configWithModel:curremtDay withChooseDay:self.dayModel];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        
        LHCalendarReusableHeaderView *monthHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kMonthHeader forIndexPath:indexPath];
        LHCalendarDateModel *date = self.monthArray[indexPath.section];
        LHCalendarDayModel *curremtDay = date.dayArray[indexPath.row];
        [monthHeader configWithModel:curremtDay];
        
        reusableview = monthHeader;
        
        
    }
    return reusableview;
    
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LHCalendarDateModel *date = self.monthArray[indexPath.section];
    LHCalendarDayModel *curremtDay = date.dayArray[indexPath.row];
    if (!curremtDay.isHide) {
        self.resultBlock(curremtDay);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)backHomeController{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIColor *)colorWithHex:(NSInteger)hexValue {
    CGFloat r = (float)(hexValue >> 24 & 0xFF) / 255.0;
    CGFloat g = (float)(hexValue >> 16 & 0xFF) / 255.0;
    CGFloat b = (float)(hexValue >> 8 & 0xFF) / 255.0;
    CGFloat a = (float)(hexValue & 0xFF) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

@end
