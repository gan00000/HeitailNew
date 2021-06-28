//
//  BlysaLineChartUtil.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/18.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Charts;

NS_ASSUME_NONNULL_BEGIN

@interface BlysaLineChartUtil : NSObject <ChartViewDelegate>

@property (nonatomic, strong) LineChartView *chartView;

- (void)initChartView;
- (void)setData:(NSMutableArray *)yVals1 data2:(NSMutableArray *)yVals2 yMax:(NSInteger)yMax toCount:(NSInteger)toCount lable1:(NSString *) lable1 lable2:(NSString *) lable2;
@end

NS_ASSUME_NONNULL_END
