//
//  BarChartUtil.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/8/24.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Charts;

NS_ASSUME_NONNULL_BEGIN

@interface BarChartUtil : NSObject

- (instancetype)initWithChart:(BarChartView *)barChartView;

- (void)setData:(NSMutableArray *)barChartArray maxValue:(int)maxValue;

@end

NS_ASSUME_NONNULL_END
