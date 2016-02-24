//
//  XQChartView.m
//  Chart
//
//  Created by Xia_Q on 16/2/22.
//  Copyright © 2016年 asiainfo. All rights reserved.
//

#import "XQChartView.h"

static const CGFloat XLabelH = 10.f;//y轴的lable的高度
static const CGFloat xLineW = 1.f;

@interface XQChartView ()
{
    //颜色渐变
    CAGradientLayer *gradient;
    NSArray *_xarr;
    NSArray *_yarr;
}

@property (nonatomic, assign) CGFloat xLabelWidth;//x轴lable的宽度

@end


@implementation XQChartView

+ (Class)layerClass{
    
    return [CAShapeLayer class];
}

- (void)setXLabels:(NSArray *)xLabels
{
    _xLabels = xLabels;
    
    NSInteger num = 0;//
    
    if (xLabels.count<=1) {
        num = 1;
    } else {
        num = xLabels.count;
    }
    
    
    _xLabelWidth=50;
    
    // x轴的标度
    for (NSInteger i=0; i<num; i++) {
        
        CGRect lbF = CGRectMake(i*_xLabelWidth-25, self.frame.size.height-XLabelH, _xLabelWidth, XLabelH);
        UILabel *lb = [self lbWithFrame:lbF];
        
        lb.text =  xLabels[i];
        [self addSubview:lb];
    }
    
    // x轴的分割线条
    
    for (NSInteger i=0; i<num*5; i++) {
        CAShapeLayer *shapeLayer =[CAShapeLayer layer];
        //创建贝塞尔曲线
        UIBezierPath *path = [UIBezierPath bezierPath];
        //设置初始线段的起点
        [path moveToPoint:CGPointMake(i*10, XLabelH)];
        //将线连接到终点
        [path addLineToPoint:CGPointMake(i*10, self.frame.size.height-XLabelH)];
        [path closePath];
        //从贝塞尔曲线获取到形状
        shapeLayer.path = path.CGPath;
        
        // 边缘线的颜色

        if (i%5!=0) {
            shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
        }else{
            shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.5] CGColor];
        }
        
        
        //y线的宽度
        shapeLayer.lineWidth = 0.5f;
        [self.layer addSublayer:shapeLayer];
    }
    
    
    
}


- (void)setYLabels:(NSArray *)yLabels
{
    _yLabels = yLabels;
    NSInteger num = 0;
    if (yLabels.count<=1) {
        num = 1;
    } else {
        num = yLabels.count;
    }
    

    
    // y轴的分割线条
    
    for (NSInteger i=0; i<(num+1)*5; i++) {
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, XLabelH+i*10)];
        [path addLineToPoint:CGPointMake(self.frame.size.width*(num+1) ,XLabelH+i*10)];
        
        [path closePath];
        shapeLayer.path = path.CGPath;
        
        if (i%5!=0) {
            shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
            shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
        }else{
            shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.5] CGColor];
            shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
        }
        
        shapeLayer.lineWidth = 0.5f;
        [self.layer addSublayer:shapeLayer];
        
    }
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        _xLabelWidth = 20.f;
        
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        for (int i=0; i<=36; i++) {
            NSString *y=[NSString stringWithFormat:@"%d",i];
            [arr addObject:y];
        }
        
        self.xLabels=[NSArray arrayWithArray:arr];
        self.yLabels=@[@"30",@"40",@"50",@"60",@"70",@"80",@"90",@"100",@"110",@"120"];

        _yUpDatas=@[@"40",@"47",@"58",@"69",@"75",@"89",@"100",@"110",@"115"];
        _yDownDatas=@[@"35",@"40",@"45",@"55",@"60",@"65",@"85",@"96",@"100"];
        
        _xDatas=@[@"0",@"3",@"6",@"9",@"12",@"15",@"18",@"21",@"24"];
        
        self.clipsToBounds = YES;
        
        [self configGradient];
        
  
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    //    [super drawRect:rect];
    
    
    /*
     strokeColor :边缘线的颜色
     fillColor :闭环填充的颜色
     path :从贝塞尔曲线获取到形状
     */
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor=[UIColor clearColor].CGColor;
    layer.strokeColor=[UIColor blueColor].CGColor;
    layer.path=[self strokeChartWithSize:self.frame.size].CGPath;
    layer.path=[self pathBottomLineWithSize:self.frame.size].CGPath;
    [self.layer addSublayer:layer];
    
}


//计算围边，颜色填充
- (UIBezierPath *)strokeChartWithSize:(CGSize)size
{
    
    UIBezierPath *progressLine = [UIBezierPath bezierPath];
    // 设置描边宽度（为了让描边看上去更清楚）
    [progressLine setLineWidth:xLineW];
    
    NSInteger p=self.yUpDatas.count;
    
    //形成闭环
    for (NSInteger i=0; i<p; i++) {
        
        NSString *valueStr = _yUpDatas[i];
        
        float xdata=[_xDatas[i] floatValue];
     
        CGPoint point = CGPointMake(xdata*50, 460-([valueStr floatValue]-30)*5);
        if (i==0) {
            [progressLine moveToPoint:point];
        }
        
        [progressLine addLineToPoint:point];
    }
    
    float lastValue=[_yDownDatas[p-1] floatValue];
    float xdata=[_xDatas[p-1] floatValue];

    CGPoint rightLastPoint=CGPointMake(xdata*50, 460-(lastValue -30)*5);

    [progressLine addLineToPoint:rightLastPoint];
    
    if (p>=1) {
        for (NSInteger i=p-1; i>=0; i--) {
            NSString *valueStr=_yDownDatas[i];
            float xdata=[_xDatas[i] floatValue];
            CGPoint point = CGPointMake(xdata*50.0, 460-([valueStr floatValue]-30)*5);

            [progressLine addLineToPoint:point];
        }
    }
    float firstValue=[_yUpDatas[0] floatValue];
    CGPoint firstPoint=CGPointMake(0, 460-(firstValue-30)*5);

    [progressLine addLineToPoint:firstPoint];
    
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = progressLine.CGPath;
    //设置渐变颜色的范围
    gradient.mask=maskLayer;
//
    return progressLine;
}

//画绿线
- (UIBezierPath *)pathBottomLineWithSize:(CGSize)size
{
    
    UIBezierPath *progressLine = [UIBezierPath bezierPath];
    [progressLine setLineWidth:2.0];
    
    for (NSInteger i=0; i<_xarr.count; i++) {
        //取到相应的每一个值
        NSString *valueStr = _yarr[i];
        
        CGFloat xdata=[_xarr[i] floatValue];
        CGPoint point = CGPointMake(xdata*50.0, 460-([valueStr floatValue]-30)*5.0);

        [self addPoint:point index:i value:[valueStr floatValue]];
        
        if (i==0) {
            [progressLine moveToPoint:point];
        }
        
        [progressLine addLineToPoint:point];
    }
    
    return progressLine;
}



- (void)configGradient
{
    
    
    NSArray *fillColors=@[[[UIColor orangeColor]colorWithAlphaComponent:0.5],[[UIColor orangeColor]colorWithAlphaComponent:0.5]];
    if(fillColors.count){
        
        NSMutableArray *colors=[[NSMutableArray alloc] initWithCapacity:fillColors.count];
        
        for (UIColor* color in fillColors) {
            if ([color isKindOfClass:[UIColor class]]) {
                [colors addObject:(id)[color CGColor]];
            } else {
                [colors addObject:(id)color];
            }
        }
        fillColors=colors;
        //初始化
        gradient = [CAGradientLayer layer];
        //与showView的frame一致
        gradient.frame = self.bounds;
        //闭环填充的颜色
        gradient.colors = fillColors;
        [self.layer addSublayer:gradient];
        
    }
    
    //setNeedsDisplay会调用自动调用drawRect方法
    [self setNeedsDisplay];
}


- (CAShapeLayer *)shaperLayer
{
    
    CAShapeLayer *chartLine = [CAShapeLayer layer];
    chartLine.fillColor = [UIColor whiteColor].CGColor;
    chartLine.strokeColor = [UIColor redColor].CGColor;
    chartLine.lineWidth = xLineW;
    [self.layer addSublayer:chartLine];
    return chartLine;
}




- (void)addPoint:(CGPoint)point index:(NSInteger)index value:(CGFloat)value
{
    
    CGRect frame = CGRectMake(5, 5, 4, 4);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.center = point;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 2.f;
    view.backgroundColor = [UIColor redColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = view.backgroundColor;
    label.text = [NSString stringWithFormat:@"%ld",(long)value];
    CGFloat ww = [self widthOfLabel:label.text fontSize:10.f]+4;
    label.frame = CGRectMake(point.x-ww/2.0, point.y-8*2, ww, 12);
    label.layer.cornerRadius = 12/2;
    label.layer.masksToBounds = YES;
    [self addSubview:label];
    [self addSubview:view];
}


- (UILabel *)lbWithFrame:(CGRect)frame
{
    
    UILabel *lb = [[UILabel alloc] initWithFrame:frame];
    [lb setLineBreakMode:NSLineBreakByWordWrapping];
    [lb setMinimumScaleFactor:5.0f];
    [lb setNumberOfLines:1];
    [lb setFont:[UIFont boldSystemFontOfSize:9.0f]];
    [lb setTextColor:[UIColor grayColor]];
    lb.backgroundColor = [UIColor clearColor];
    [lb setTextAlignment:NSTextAlignmentCenter];
    return lb;
}


- (CGFloat)widthOfLabel:(NSString *)strText
               fontSize:(CGFloat)fontSize;
{
    
    CGSize size;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine|
    NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    NSDictionary *attribute = @{NSFontAttributeName:font};
    size = [strText boundingRectWithSize:CGSizeMake(0, MAXFLOAT)
                                 options:options
                              attributes:attribute context:nil].size;
    
    return size.width;
}



@end
