//
//  ViewController.m
//  Chart
//
//  Created by Xia_Q on 16/2/22.
//  Copyright © 2016年 asiainfo. All rights reserved.
//

#import "ViewController.h"

#define XQHeight [UIScreen mainScreen].bounds.size.height
#define XQWidht [UIScreen mainScreen].bounds.size.width


@interface ViewController ()

{
    CGFloat backViewHeight;
    CGFloat backViewwidth;
}

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    backViewHeight=9*50+20;
    backViewwidth=30*50+50;
    
    UIView  *bgview=[[UIView alloc]initWithFrame:CGRectMake(0, 20, XQWidht,backViewHeight)];
    [self.view addSubview:bgview];
    
    UIScrollView *scr=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, XQWidht,backViewHeight)];
    scr.scrollEnabled=YES;
    scr.showsHorizontalScrollIndicator=NO;
    scr.contentSize=CGSizeMake(backViewwidth, 0);
    [bgview addSubview:scr];
    
    _chartView = [[XQChartView alloc] initWithFrame:CGRectMake(50, 0,  backViewwidth-50 , backViewHeight)];
    _chartView.xarr=@[@"0",@"1",@"2",@"3"];
    _chartView.yarr=@[@"36",@"40",@"42",@"43"];
    _chartView.backgroundColor = [UIColor whiteColor];
    [scr addSubview:self.chartView];
    
    _lableView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, backViewHeight-10)];
    _lableView.backgroundColor=[UIColor whiteColor];
    [bgview addSubview:_lableView];

    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(49, 10, 1, backViewHeight-20)];
    lineView.backgroundColor=[[UIColor lightGrayColor]colorWithAlphaComponent:0.5];
    [_lableView addSubview:lineView];
    
    NSArray *lableArr=@[@"30",@"40",@"50",@"60",@"70",@"80",@"90",@"100",@"110",@"120"];
    
    CGFloat levelHeight = (backViewHeight - 10*2)/(lableArr.count-1);
    
    for (NSInteger i=0; i<lableArr.count; i++) {
        CGRect lbF = CGRectMake(0, backViewHeight-i*levelHeight-10*2, 49, 10);
        UILabel *lb = [self lbWithFrame:lbF];
        lb.text =  lableArr[i];
        
        [_lableView addSubview:lb];
    }


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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
