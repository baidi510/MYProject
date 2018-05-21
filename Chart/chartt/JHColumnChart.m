//
//  JHColumnChart.m
//  JHChartDemo
//
//  Created by BaiDi on 16/12/20.
//

#import "JHColumnChart.h"

@interface JHColumnChart ()

//峰值
@property (nonatomic,assign) CGFloat maxHeight;

//背景图
@property (nonatomic,strong)UIView *BGScrollView;

//横向最大值
@property (nonatomic,assign) CGFloat maxWidth;

//所有的柱状图数组
@property (nonatomic,strong)NSMutableArray * showViewArr;

@property (nonatomic,assign) CGFloat perHeight;

@property (nonatomic, strong)NSString *a,*b;
@property (nonatomic, assign)float aValue;
@property (nonatomic, assign)float bValue;
//标记是否是被选中的情况下
@property (nonatomic, assign)BOOL isClick;

@end

@implementation JHColumnChart


-(NSMutableArray *)showViewArr{
    
    
    if (!_showViewArr) {
        _showViewArr = [NSMutableArray array];
    }
    
    return _showViewArr;
    
}

-(UIScrollView *)BGScrollView{
    
    if (!_BGScrollView) {

        _BGScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
//        _BGScrollView.showsHorizontalScrollIndicator = NO;
        _bgVewBackgoundColor = _bgVewBackgoundColor;
//        _BGScrollView.pagingEnabled = YES;
        [self addSubview:_BGScrollView];
        
    }
    
    return _BGScrollView;
    
    
}


-(void)setBgVewBackgoundColor:(UIColor *)bgVewBackgoundColor{
    
    _bgVewBackgoundColor = bgVewBackgoundColor;
    self.BGScrollView.backgroundColor = _bgVewBackgoundColor;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    
    if (self = [super initWithFrame:frame]) {

        _needXandYLine = YES;
       
    }
    return self;
}


-(void)setValueArr:(NSArray<NSArray *> *)valueArr{
    
    
    _valueArr = valueArr;
  
    
    CGFloat max = 0;
 
    for (NSArray *arr in _valueArr) {
        
        for (id number in arr) {
            CGFloat currentNumber = [NSString stringWithFormat:@"%@",number].floatValue;
            if (currentNumber>max) {
                max = currentNumber;
            }
        }
    }
    
    _maxHeight = max + 20;
    _perHeight = CGRectGetHeight(self.frame)/_maxHeight;
   
}

-(void)showAnimation{
    
    [self clear];

    _columnWidth = (_columnWidth<=0?30:_columnWidth);
    if (_valueArr.count == 0) {
        _typeSpace = (_typeSpace<=0?15:_typeSpace);
        _maxWidth = _valueArr.count * _typeSpace + _typeSpace + 40;
    }else{
        NSInteger count = _valueArr.count * [_valueArr[0] count];
        _typeSpace = (_typeSpace<=0?15:_typeSpace);
        _maxWidth = count * _columnWidth + _valueArr.count * _typeSpace + _typeSpace + 40;
    }

//    self.BGScrollView.contentSize = CGSizeMake(_maxWidth, 0);
    self.BGScrollView.backgroundColor = _bgVewBackgoundColor;
    
    /*        动画展示         */
    for (NSInteger i = 0; i<_valueArr.count; i++) {
        
        NSArray *arr = _valueArr[i];
        for (NSInteger j = 0; j<arr.count; j++) {
            
            //为了在下面的隐藏判断用
            NSString *textLayerValue = [NSString stringWithFormat:@"%@",arr[j]];
            float layerValue = [textLayerValue floatValue];
            
            CGFloat height = [arr[j] floatValue] *_perHeight;
            
//            UIButton *itemsView = [UIButton buttonWithType:(UIButtonTypeCustom)];
            UIView *itemsView = [UIView new];
            [self.showViewArr addObject:itemsView];
            itemsView.frame = CGRectMake((i * arr.count + j)*_columnWidth + i*_typeSpace+_originSize.x + _typeSpace, CGRectGetHeight(self.frame) - _originSize.y, _columnWidth, 0);

            itemsView.backgroundColor = (UIColor *)[UIColor whiteColor];
            
            [UIView animateWithDuration:1 animations:^{
                
            itemsView.frame = CGRectMake((i * arr.count + j)*_columnWidth + i*_typeSpace+_originSize.x + _typeSpace, CGRectGetHeight(self.frame) - height - _originSize.y -1, _columnWidth, height);
            } completion:^(BOOL finished) {
/*        动画结束后添加提示文字         */
                if (finished) {
                        UILabel *textLable = [[UILabel alloc]init];
                        textLable.tag = 20000 + i;
                        NSString *str = [NSString stringWithFormat:@"%@",arr[j]];
                        
                        CGSize size = [str boundingRectWithSize:CGSizeMake(_columnWidth, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9]} context:nil].size;
                        
                        textLable.frame = CGRectMake((i * arr.count + j)*_columnWidth + i*_typeSpace+_originSize.x + _typeSpace - 10, CGRectGetHeight(self.frame) - height - _originSize.y -3 - size.width - 10, _columnWidth + 20, size.height + 5);
                        //柱状图上的数据显示
                    if ([_jingJieXianArr[0] isEqual:@7.8] || [_jingJieXianArr[0] isEqual:@25]) {
                        textLable.text = str;
                    }else{
                        float n = [str floatValue];
                        NSString *m = [NSString stringWithFormat:@"%.0f",n];
                        if ([m isEqualToString:@"0"]) {
                            m = @"";
                        }
                        textLable.text = m;
                    }
                    
                        textLable.textColor = [UIColor whiteColor];
                
                        textLable.font = [UIFont systemFontOfSize:12.0];
                        
                        textLable.textAlignment = NSTextAlignmentCenter;
//有两条警戒线的时候，判断数据是否超出了或者是低于警戒线  显示数据，其余的点击再显示
                        _a = [NSString stringWithFormat:@"%@",self.jingJieXianArr[0]];
                        _b = [NSString stringWithFormat:@"%@",self.jingJieXianArr[1]];
                   
                    _aValue = [_a floatValue];
                    _bValue = [_b floatValue];
                            if (layerValue < _aValue && layerValue > _bValue ){
                                textLable.hidden = YES;
                            }else{
                                textLable.hidden = NO;
                        }
                    
                        [_BGScrollView addSubview:textLable];
                    }
                
            }];
            
            //切圆角
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:itemsView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = itemsView.bounds;
            maskLayer.path = maskPath.CGPath;
            itemsView.layer.mask = maskLayer;
 
//当单柱或者是双柱时  添加不同的手势事件
            itemsView.tag = 10000 + i;
                //添加手势
                UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handelPan:)];
                [itemsView addGestureRecognizer:singleTap];
                singleTap.delegate = self;
                singleTap.cancelsTouchesInView = NO;

           [self.BGScrollView addSubview:itemsView];
            
        }
        
    }

    
    
}

//画虚线
- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 10, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame) - 10, 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

-(void)clear{
    
    for (UIView *subV in self.showViewArr) {
        [subV removeFromSuperview];
    }
    // 传进来一个数组，画几条警戒线
    for (int i = 0; i < self.jingJieXianArr.count; i++) {
        NSString *n =[NSString stringWithFormat:@"%@",self.jingJieXianArr[i]];
        CGFloat m = [n floatValue];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20,self.BGScrollView.frame.size.height - self.BGScrollView.frame.size.height * m / _maxHeight - _originSize.y, self.BGScrollView.frame.size.width - 20, 1)];
        //设置虚线的颜色等。
        [self drawDashLine:lineView lineLength:5 lineSpacing:1 lineColor:[UIColor whiteColor]];
        [self.BGScrollView.superview addSubview:lineView];
        UILabel *yLable = [[UILabel alloc]initWithFrame:CGRectMake(0, self.BGScrollView.frame.size.height - self.BGScrollView.frame.size.height * m / _maxHeight - _originSize.y - 7.5, 30, 15)];
        yLable.text = n;
        //设置显示警戒线数值的颜色
        yLable.font = [UIFont systemFontOfSize:10];
        yLable.textColor = [UIColor whiteColor];
        yLable.textAlignment = NSTextAlignmentCenter;
        [self.BGScrollView.superview addSubview:yLable];
    }
    UIView *shixianView = [[UIView alloc]initWithFrame:CGRectMake(0, self.BGScrollView.frame.size.height - 30 - 1, self.BGScrollView.frame.size.width, 1)];
    [self drawDashLine:shixianView lineLength:5 lineSpacing:0 lineColor:[UIColor whiteColor]];
    [self.BGScrollView.superview addSubview:shixianView];
}

//手势的触发事件，轻拍时让其显示数据
-(void)handelPan:(UIGestureRecognizer *)sender{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    UIView *tapView = singleTap.view;
    long tagLable = [singleTap view].tag;
    UILabel *lable = [self viewWithTag:tagLable + 10000];
    
//当为血糖等
    //添加 字典，将label的值通过key值设置传递
    if (tapView.backgroundColor != [UIColor grayColor]) {
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",tagLable],@"tag", @"1",@"isSelected",nil];
//        NSLog(@"%@",dict);
        //创建通知
        NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dict];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }else{
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",tagLable],@"tag", @"0",@"isSelected", nil];
        //创建通知
        NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dict];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
    
        _a = [NSString stringWithFormat:@"%@",self.jingJieXianArr[0]];
        _b = [NSString stringWithFormat:@"%@",self.jingJieXianArr[1]];
        _aValue = [_a integerValue];
        _bValue = [_b integerValue];
        NSString *value = lable.text;
        NSInteger value1 = [value integerValue];
        
        for (int i = 10000; i < (_valueArr.count + 10000); i++) {
            if ((int)tagLable == i && (tapView.backgroundColor == [UIColor whiteColor])) {
                lable.hidden = NO;
                UIView *view = (UIView*)[_BGScrollView viewWithTag:i];
                view.backgroundColor = [UIColor grayColor];
                view.alpha = 0.5;
            }else if ((int)tagLable == i && (tapView.backgroundColor == [UIColor grayColor]) && (value1 < _aValue && value1 > _bValue )){
                lable.hidden = YES;
             //   UIView *view = (UIView*)[_BGScrollView viewWithTag:i];
                tapView.backgroundColor = [UIColor whiteColor];
                tapView.alpha = 1.0;
            }else if ((int)tagLable == i && (tapView.backgroundColor == [UIColor grayColor]) && (value1 > _aValue || value1 < _bValue )){
                lable.hidden = NO;
                //   UIView *view = (UIView*)[_BGScrollView viewWithTag:i];
                tapView.backgroundColor = [UIColor whiteColor];
                tapView.alpha = 1.0;
            }
            else{
                UIView *view = (UIView*)[_BGScrollView viewWithTag:i];
                view.backgroundColor = [UIColor whiteColor];
                view.alpha = 1.0;
                long tagLable = view.tag;
                UILabel *lable = [self viewWithTag:tagLable + 10000];
                NSString *value = lable.text;
                NSInteger value1 = [value integerValue];
                if (value1 < _aValue && value1 > _bValue) {
                    lable.hidden = YES;
                }else if (value1 > _aValue || value1 < _bValue ){
                    lable.hidden = NO;
                }
            }
          
        }
    
}

@end
