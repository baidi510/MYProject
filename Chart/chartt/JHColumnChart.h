//
//  JHColumnChart.h
//  JHChartDemo
//
//  Created by BaiDi on 16/12/20.
//

#import "JHChart.h"


@interface JHColumnChart : JHChart<UIGestureRecognizerDelegate>

//峰值
//@property (nonatomic,assign) CGFloat maxHeight1;

//柱状图数组的颜色
@property (nonatomic, strong) NSArray<NSArray *> * columnBGcolorsArr;

//y轴的值
@property (nonatomic, strong) NSArray<NSArray *> * valueArr;

//整个大柱状图的背景颜色
@property (nonatomic, strong) UIColor  * bgVewBackgoundColor;

//列间距，非连续的默认是5
@property (nonatomic, assign) CGFloat typeSpace;

//圆柱宽度
@property (nonatomic, assign) CGFloat columnWidth;

//是否需要x轴y轴
@property (nonatomic, assign) BOOL needXandYLine;

//y轴虚线指导颜色
@property (nonatomic, strong) UIColor * dashColor;

//左下脚距离x，y的起点
@property (nonatomic, assign) CGPoint originSize;

//外面传过来的线的值，转变成在屏幕的位置传过来
@property (nonatomic, strong)NSArray *jingJieXianArr;

//盛放是空腹餐后的数组  跟数据一对一   放到另一个数组里
@property (nonatomic, strong)NSArray *isKongArr;

@end
