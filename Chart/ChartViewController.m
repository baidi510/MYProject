//
//  ChartViewController.m
//  Chart
//
//  Created by 白迪 on 2018/5/21.
//  Copyright © 2018年 coder_di. All rights reserved.
//

#import "ChartViewController.h"
#import "JHColumnChart.h"

@interface ChartViewController ()

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
    
}

-(void)setUI{
    //柱状图
    JHColumnChart *column = [[JHColumnChart alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300)];
    column.backgroundColor = [UIColor redColor];
    column.valueArr =  @[
                         @[@10],
                         @[@20],
                         @[@8],
                         @[@50],
                         @[@22],
                         @[@34],
                         @[@9],
                         @[@22],
                         @[@34]
                         ];
    
    column.originSize = CGPointMake(30, 30);
    //画警戒线
    column.jingJieXianArr = @[@50,@20];
    //设置每个柱的宽度 默认显示8个
    column.columnWidth = 20;
    column.typeSpace = 20;
    column.bgVewBackgoundColor = [UIColor clearColor];
    //开始动画
    [column showAnimation];
    [self.view addSubview:column];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
