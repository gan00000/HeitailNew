//
//  NSNiceBarChartUtil.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/8/24.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import "NSNiceBarChartUtil.h"
#import "UIColor+FFlaliHex.h"
#import "KSasxBarChartUtilValueFormat.h"

@implementation NSNiceBarChartUtil
{
    BarChartView *_chartView;
}

- (instancetype)initWithChart:(BarChartView *)barChartView
{
    self = [super init];
    if (self) {
        _chartView = barChartView;
        [self initChart];
    }
    return self;
}

-(void)initChart
{
    
    _chartView.drawBarShadowEnabled = NO;
    _chartView.maxVisibleCount = 20;
    _chartView.drawValueAboveBarEnabled = YES;
    _chartView.dragEnabled = NO;
    _chartView.userInteractionEnabled = NO;
    //_chartView.drawMarkers = NO;
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.enabled = NO;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawGridLinesEnabled = NO;
    xAxis.granularity = 1.0; // only intervals of 1 day
    //xAxis.labelCount = 7;
    //xAxis.valueFormatter = [[DayAxisValueFormatter alloc] initForChart:_chartView];
    
//    NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];
//    leftAxisFormatter.minimumFractionDigits = 0;
//    leftAxisFormatter.maximumFractionDigits = 1;
//    leftAxisFormatter.negativeSuffix = @" $";
//    leftAxisFormatter.positiveSuffix = @" $";
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.enabled = NO;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
//    leftAxis.labelCount = 8;
//    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.spaceTop = 0.15;
    leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartYAxis *rightAxis = _chartView.rightAxis;
    rightAxis.enabled = NO;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
    rightAxis.labelCount = 8;
    rightAxis.valueFormatter = leftAxis.valueFormatter;
    rightAxis.spaceTop = 0.15;
    rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartLegend *l = _chartView.legend;
    l.enabled = NO;
//    l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
//    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
//    l.orientation = ChartLegendOrientationHorizontal;
//    l.drawInside = NO;
//    l.form = ChartLegendFormSquare;
//    l.formSize = 9.0;
//    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
//    l.xEntrySpace = 4.0;

}

- (void)setData:(NSMutableArray *)barChartArray maxValue:(int)maxValue
{
//    double start = 1.0;
//
//    NSMutableArray *yVals = [[NSMutableArray alloc] init];
//
//    for (int i = start; i < start + count + 1; i++)
//    {
//        double mult = (range + 1);
//        double val = (double) (arc4random_uniform(mult));
//        if (arc4random_uniform(100) < 25) {
//            [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val icon: [UIImage imageNamed:@"icon"]]];
//        } else {
//            [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val]];
//        }
//    }
//
    if (maxValue > 0) {
        _chartView.maxVisibleCount = maxValue + 8;
    }
    BarChartDataSet *set1 = nil;
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (BarChartDataSet *)_chartView.data.dataSets[0];
        [set1 replaceEntries: barChartArray];
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[BarChartDataSet alloc] initWithEntries:barChartArray label:@""];
        [set1 setColors:ChartColorTemplates.material];
        set1.drawIconsEnabled = NO;
        set1.drawValuesEnabled = YES;
        [set1 setColors:@[[UIColor colorWithHexString:@"#608FD4"], [UIColor colorWithHexString:@"#F35930"]]];
        set1.valueFormatter = [[KSasxBarChartUtilValueFormat alloc] init];
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.f]];
        
        data.barWidth = 1.2f;
        
        _chartView.data = data;
    }
}

@end
