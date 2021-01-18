//
//  GlodBuleBarChartUtilValueFormat.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/8/26.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import "GlodBuleBarChartUtilValueFormat.h"

@implementation GlodBuleBarChartUtilValueFormat



- (NSString * _Nonnull)stringForValue:(double)value entry:(ChartDataEntry * _Nonnull)entry dataSetIndex:(NSInteger)dataSetIndex viewPortHandler:(ChartViewPortHandler * _Nullable)viewPortHandler {
    
    return [NSString stringWithFormat:@"%d",(int) value];
}

@end
