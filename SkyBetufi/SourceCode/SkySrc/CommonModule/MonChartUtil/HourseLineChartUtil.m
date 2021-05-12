//
//  HourseLineChartUtil.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/18.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import "HourseLineChartUtil.h"
#import "UIColor+KMonkeyGlodBuleHex.h"

@implementation HourseLineChartUtil 

- (void)initChartView
{
   
    _chartView.delegate = self;
    
    _chartView.chartDescription.enabled = NO;
    
    _chartView.dragEnabled = NO;
    [_chartView setScaleEnabled:NO];
    _chartView.drawGridBackgroundEnabled = NO;
    _chartView.pinchZoomEnabled = NO;
    
    _chartView.backgroundColor = [UIColor clearColor];
    
    ChartLegend *l = _chartView.legend;
    l.form = ChartLegendFormSquare;
    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
//    l.textColor = UIColor.whiteColor;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    l.verticalAlignment = ChartLegendVerticalAlignmentTop;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.drawLabelsEnabled = NO;
//    xAxis.labelFont = [UIFont systemFontOfSize:11.f];
//    xAxis.labelTextColor = UIColor.whiteColor;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.drawAxisLineEnabled = YES;
    xAxis.axisMaximum = 48 * 60;
    xAxis.granularity = 1.0;
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
//    leftAxis.labelTextColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
    leftAxis.axisMaximum = 120.0;
    leftAxis.axisMinimum = 0.0;
//    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.drawZeroLineEnabled = NO;
//    leftAxis.granularityEnabled = YES;
    leftAxis.granularity = 30.0;
    leftAxis.drawAxisLineEnabled = YES;
    
    ChartYAxis *rightAxis = _chartView.rightAxis;
//    rightAxis.labelTextColor = UIColor.redColor;
    rightAxis.drawLabelsEnabled = NO;
    rightAxis.axisMaximum = 120.0;
    rightAxis.axisMinimum = 0.0;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.granularityEnabled = NO;
    rightAxis.drawAxisLineEnabled = YES;
    
    [_chartView animateWithXAxisDuration:1.5];//动画延时
}

- (void)setData:(NSMutableArray *)yVals1 data2:(NSMutableArray *)yVals2 yMax:(NSInteger)yMax toCount:(NSInteger)toCount lable1:(NSString *) lable1 lable2:(NSString *) lable2
{

    if (toCount > 0){
        int gameSeconds = 48 * 60 + 5 * 60 * toCount;
        ChartXAxis *xAxis = _chartView.xAxis;
        xAxis.axisMaximum = gameSeconds;
    }
   

    ChartYAxis *leftAxis = _chartView.leftAxis;
    //CGFloat labelXOffset = leftAxis.labelXOffset;
    
    if (yMax < 120) {
        leftAxis.axisMaximum = 120;
    }else{
        leftAxis.axisMaximum = yMax;
    }
    
    LineChartDataSet *set1 = nil, *set2 = nil;
    
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
        set2 = (LineChartDataSet *)_chartView.data.dataSets[1];
        
        [set1 replaceEntries:yVals1];
        [set2 replaceEntries:yVals2];
       
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc] initWithEntries:yVals1 label:lable1];
//        set1.axisDependency = AxisDependencyLeft;
        [set1 setColor:[UIColor colorWithHexString:@"608FD4"]];
        [set1 setCircleColor: [UIColor colorWithHexString:@"608FD4"]];
        set1.lineWidth = 2.2;
        set1.circleRadius = 2.0;
        
//        set1.fillAlpha = 65/255.0;
//        set1.fillColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
//        set1.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        set1.drawCircleHoleEnabled = YES;
        set1.drawValuesEnabled = NO;
        set1.drawCirclesEnabled = NO;
        set1.mode = LineChartModeCubicBezier;
        
        set2 = [[LineChartDataSet alloc] initWithEntries:yVals2 label:lable2];
//        set2.axisDependency = AxisDependencyRight;
        [set2 setColor: [UIColor colorWithHexString:@"F35930"]];
        [set2 setCircleColor: [UIColor colorWithHexString:@"F35930"]];
        set2.lineWidth = 2.2;
        set2.circleRadius = 2.0;
//        set2.fillAlpha = 65/255.0;
//        set2.fillColor = UIColor.redColor;
//        set2.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        set2.drawCircleHoleEnabled = NO;
        set2.drawValuesEnabled = NO;
        set2.drawCirclesEnabled = NO;
        set2.mode = LineChartModeCubicBezier;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        [dataSets addObject:set2];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueTextColor:UIColor.whiteColor];
        [data setValueFont:[UIFont systemFontOfSize:9.f]];
        
        _chartView.data = data;
        [_chartView notifyDataSetChanged];
    }
}


#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
    
//    [_chartView centerViewToAnimatedWithXValue:entry.x yValue:entry.y axis:[_chartView.data getDataSetByIndex:highlight.dataSetIndex].axisDependency duration:1.0];
    //[_chartView moveViewToAnimatedWithXValue:entry.x yValue:entry.y axis:[_chartView.data getDataSetByIndex:dataSetIndex].axisDependency duration:1.0];
    //[_chartView zoomAndCenterViewAnimatedWithScaleX:1.8 scaleY:1.8 xValue:entry.x yValue:entry.y axis:[_chartView.data getDataSetByIndex:dataSetIndex].axisDependency duration:1.0];

}
@end
