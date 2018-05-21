//
//  ViewController.m
//  Chart
//
//  Created by 白迪 on 2018/5/21.
//  Copyright © 2018年 coder_di. All rights reserved.
//

#import "ViewController.h"
#import "ChartViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(0, 0, 100, 20);
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor cyanColor];
    [btn setTitle:@"柱状图" forState:0];
    [btn addTarget:self action:@selector(chartAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview: btn];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)chartAction{
    ChartViewController *chartVC = [[ChartViewController alloc]init];
    [self.navigationController pushViewController:chartVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
