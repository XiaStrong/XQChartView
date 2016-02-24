//
//  XQChartView.h
//  Chart
//
//  Created by Xia_Q on 16/2/22.
//  Copyright © 2016年 asiainfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XQChartView : UIView

@property (nonatomic, copy) NSArray *xLabels;//x轴的lable数组
@property (nonatomic, copy) NSArray *yLabels;//y轴的lable数组

@property (nonatomic,strong)NSArray *yUpDatas;//y轴的上数据数组
@property (nonatomic,strong)NSArray *yDownDatas;//y轴的下数据数组
@property (nonatomic,strong)NSArray *xDatas;//x轴坐标

@property (nonatomic,strong)NSArray *xarr;//做曲线的x轴数据源
@property (nonatomic,strong)NSArray *yarr;//做曲线的y轴数据源
@end
