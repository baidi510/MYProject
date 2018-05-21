//
//  TXHRulerScrollView.m
//  PrettyRuler
//
//  Created by GXY on 15/12/11.
//  Copyright © 2015年 Tangxianhai. All rights reserved.
//

#import "TXHRulerScrollView.h"

@implementation TXHRulerScrollView

- (void)setRulerValue:(CGFloat)rulerValue {
    _rulerValue = rulerValue;
}

- (void)drawRuler {
    
    CGMutablePathRef pathRef1 = CGPathCreateMutable();
    CGMutablePathRef pathRef2 = CGPathCreateMutable();
    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.strokeColor = [UIColor lightGrayColor].CGColor;
    shapeLayer1.fillColor = [UIColor clearColor].CGColor;
    shapeLayer1.lineWidth = 1.f;
    shapeLayer1.lineCap = kCALineCapButt;
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.strokeColor = [UIColor grayColor].CGColor;
    shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    shapeLayer2.lineWidth = 1.f;
    shapeLayer2.lineCap = kCALineCapButt;
    
    for (NSInteger i = self.rulerMinValue - 1; i <= self.rulerCount; i++) {
        UILabel *rule = [[UILabel alloc] init];
        rule.textColor = [UIColor blackColor];
        CGSize textSize = [rule.text sizeWithAttributes:@{ NSFontAttributeName : rule.font }];
#warning TODO 限制显示最大值最小值
        if (i > self.rulerMinValue - 1) {
            rule.text = [NSString stringWithFormat:@"%.0f",i * [self.rulerAverage floatValue]];
            if (i % 10 == 0) {
                CGPathMoveToPoint(pathRef2, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i , DISTANCETOPANDBOTTOM);
                CGPathAddLineToPoint(pathRef2, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i, self.rulerHeight - DISTANCETOPANDBOTTOM - textSize.height);
                rule.frame = CGRectMake(DISTANCELEFTANDRIGHT + DISTANCEVALUE * i - textSize.width / 2, self.rulerHeight - DISTANCETOPANDBOTTOM - textSize.height, 0, 0);
                [rule sizeToFit];
                [self addSubview:rule];
            }
            else if (i % 5 == 0) {
                CGPathMoveToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i , DISTANCETOPANDBOTTOM + 10);
                CGPathAddLineToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i, self.rulerHeight - DISTANCETOPANDBOTTOM - textSize.height - 10);
            }
            else
            {
                CGPathMoveToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i , DISTANCETOPANDBOTTOM + 20);
                CGPathAddLineToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i, self.rulerHeight - DISTANCETOPANDBOTTOM - textSize.height - 20);
            }
        }
    }
    
    shapeLayer1.path = pathRef1;
    shapeLayer2.path = pathRef2;
    
    [self.layer addSublayer:shapeLayer1];
    [self.layer addSublayer:shapeLayer2];
    
    self.frame = CGRectMake(0, 0, self.rulerWidth, self.rulerHeight);
    
    // 开启最小模式
    if (_mode) {
        UIEdgeInsets edge = UIEdgeInsetsMake(0, self.rulerWidth / 2.f - DISTANCELEFTANDRIGHT, 0, self.rulerWidth / 2.f - DISTANCELEFTANDRIGHT);
        self.contentInset = edge;
        self.contentOffset = CGPointMake(DISTANCEVALUE * (self.rulerValue / [self.rulerAverage floatValue]) - self.rulerWidth + (self.rulerWidth / 2.f + DISTANCELEFTANDRIGHT), 0);
    }
    else
    {
        self.contentOffset = CGPointMake(DISTANCEVALUE * (self.rulerValue / [self.rulerAverage floatValue]) - self.rulerWidth / 2.f + DISTANCELEFTANDRIGHT, 0);
    }
    
    self.contentSize = CGSizeMake(self.rulerCount * DISTANCEVALUE + DISTANCELEFTANDRIGHT * 2.f, self.rulerHeight);
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com