//
//  HTCourtHotShootView.m
//  XXXHeiTai
//
//  Created by ganyuanrong on 2021/3/5.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import "HTCourtHotShootView.h"
#import <Masonry.h>
@import Charts;


@interface HTCourtHotShootView()

@property (nonatomic, strong) ScatterChartView *leftChartView;
@property (nonatomic, strong) ScatterChartView *rightChartView;

@end

@implementation HTCourtHotShootView

//- (void)awakeFromNib {
//    [super awakeFromNib];
//}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setView];
        [self initScatterChartView:self.leftChartView];
        [self initScatterChartView:self.rightChartView];
        
//        [self setDataCount];
    }
    return self;
}

- (void)setView
{
    UIView *leftView = [[UIView alloc] init];
    [self addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(self).mas_offset(4);
        make.bottom.mas_equalTo(self).mas_offset(-4);
        make.trailing.mas_equalTo(self.mas_centerX).mas_offset(-2);
//        make.width.mas_equalTo(120);
    }];
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"img_hotshoot_court_left"];
    [leftView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(leftView);
        make.bottom.mas_equalTo(leftView);
        make.trailing.mas_equalTo(leftView);
    }];
    
    _leftChartView = [[ScatterChartView alloc] init];
    [leftView addSubview:_leftChartView];
    [_leftChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(bgView);
        make.bottom.mas_equalTo(bgView);
        make.trailing.mas_equalTo(bgView);
    }];
    
    
    
    UIView *rightView = [[UIView alloc] init];
    rightView.backgroundColor = UIColor.blueColor;
    [self addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(4);
        make.bottom.mas_equalTo(self).mas_offset(-4);
        make.trailing.mas_equalTo(self).mas_offset(-4);
        make.leading.mas_equalTo(self.mas_centerX).mas_offset(2);
    }];
    
    UIImageView *bgView2 = [[UIImageView alloc] init];
    bgView2.image = [UIImage imageNamed:@"img_hotshoot_court_right"];
    [rightView addSubview:bgView2];
    [bgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(rightView);
        make.bottom.mas_equalTo(rightView);
        make.trailing.mas_equalTo(rightView);
    }];
    
    _rightChartView = [[ScatterChartView alloc] init];
    [rightView addSubview:_rightChartView];
    [_rightChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(bgView2);
        make.bottom.mas_equalTo(bgView2);
        make.trailing.mas_equalTo(bgView2);
    }];
}

-(void) initScatterChartView:(ScatterChartView *)mScatterChartView
{
    mScatterChartView.chartDescription.enabled = NO;
    mScatterChartView.drawGridBackgroundEnabled = NO;
    mScatterChartView.dragEnabled = NO;
    [mScatterChartView setScaleEnabled:NO];
//    mScatterChartView.maxVisibleCount = 200;
    mScatterChartView.pinchZoomEnabled = YES;
    
    mScatterChartView.userInteractionEnabled = NO;
   
    mScatterChartView.rightAxis.enabled = NO;
    mScatterChartView.leftAxis.enabled = NO;
    mScatterChartView.legend.enabled = NO;
    
    ChartXAxis *xAxis = mScatterChartView.xAxis;
    xAxis.enabled = NO;
    xAxis.labelPosition = XAxisLabelPositionBottom;
//    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawGridLinesEnabled = NO;

}


- (void)setDataCount:(NSInteger) width
{
    
//    CGFloat width = self.leftChartView.width;
    CGFloat height = 200;//self.leftChartView.height;
    
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
   
    int count = width/2;//floorf(width);
    
    for (int i = 0; i < count; i++)
    {
        double val = (double) (arc4random_uniform(height)) + 3;
        [yVals1 addObject:[[ChartDataEntry alloc] initWithX:(double)i y:val]];
        
        val = (double) (arc4random_uniform(height)) + 3;
        [yVals2 addObject:[[ChartDataEntry alloc] initWithX:(double)i + 0.33 y:val]];
        
    }
    
    ScatterChartDataSet *setLeft = [[ScatterChartDataSet alloc] initWithEntries:yVals1 label:@""];
    [setLeft setScatterShape:ScatterShapeCircle];
//    setLeft.drawIconsEnabled = NO;
//    setLeft.drawValuesEnabled = NO;
    setLeft.scatterShapeHoleRadius = 3.5f;
    
    [setLeft setColor:UIColor.blueColor];
    
    ScatterChartDataSet *setRight = [[ScatterChartDataSet alloc] initWithEntries:yVals2 label:@""];
    [setRight setScatterShape:ScatterShapeCircle];
//    set2.scatterShapeHoleColor = UIColor.blueColor;//ChartColorTemplates.colorful[3];
    setRight.scatterShapeHoleRadius = 3.5f;
    [setRight setColor:UIColor.blueColor];
   
    
    setLeft.scatterShapeSize = 8.0;
    setRight.scatterShapeSize = 8.0;
   
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:setLeft];
  
    ScatterChartData *data = [[ScatterChartData alloc] initWithDataSets:dataSets];
    data.highlightEnabled = NO;
    
    self.leftChartView.data = data;
    self.rightChartView.data = data;
    
    [self.leftChartView notifyDataSetChanged];
    [self.rightChartView notifyDataSetChanged];
}

@end
