//
//  ViewController.m
//  LHCalendar
//
//  Created by lh on 17/1/9.
//  Copyright © 2017年 lh. All rights reserved.
//

#import "ViewController.h"
#import "LHCalendarViewController.h"
#import "LHCalendarDayModel.h"
@interface ViewController ()
@property (nonatomic,strong) LHCalendarDayModel *dayModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"日历选择" style:UIBarButtonItemStylePlain target:self action:@selector(chooseCalendar)];
}
#pragma mark - 选择日历
- (void)chooseCalendar{
    LHCalendarViewController *calendar = [[LHCalendarViewController alloc]init];
    calendar.resultBlock = ^(id model){
        if (model) {
            NSLog(@"%@",model);
        }
    };
    calendar.dayModel = self.dayModel;
    [self.navigationController pushViewController:calendar animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
