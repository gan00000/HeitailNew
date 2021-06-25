//
//  YeYeeHTCourtHotShootView.m
//  
//
//  Created by ganyuanrong on 2021/3/5.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import "YeYeeHTCourtHotShootView.h"
#import <Masonry.h>
@import Charts;
#import "UIColor+FFlaliHex.h"


@interface YeYeeHTCourtHotShootView()

@property (nonatomic, strong) UIView *leftPlayGroundView;
@property (nonatomic, strong) UIView *rightPlayGroundView;

@end

@implementation YeYeeHTCourtHotShootView

//- (void)awakeFromNib {
//    [super awakeFromNib];
//}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setView];
//        [self initScatterChartView:self.leftChartView];
//        [self initScatterChartView:self.rightChartView];
        
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
        make.trailing.mas_equalTo(self.mas_centerX).mas_offset(-0.2);
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
    
    _leftPlayGroundView = [[UIView alloc] init];
    [leftView addSubview:_leftPlayGroundView];
    [_leftPlayGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.leading.mas_equalTo(self.mas_centerX).mas_offset(0.2);
    }];
    
    UIImageView *bgView2 = [[UIImageView alloc] init];
    bgView2.image = [UIImage imageNamed:@"img_hotshoot_court_right"];
    [rightView addSubview:bgView2];
    [bgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(rightView);
        make.bottom.mas_equalTo(rightView);
        make.trailing.mas_equalTo(rightView);
    }];
    
    _rightPlayGroundView = [[UIView alloc] init];
    [rightView addSubview:_rightPlayGroundView];
    [_rightPlayGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(bgView2);
        make.bottom.mas_equalTo(bgView2);
        make.trailing.mas_equalTo(bgView2);
    }];
}

- (void)setDataModel:(NSArray<TuTuosHotShootPointModel *> *) model isLeft:(BOOL) isLeft width:(CGFloat)width height:(CGFloat)height
{
    CGFloat xxWidth = _leftPlayGroundView.width;
    CGFloat xxHeight = _leftPlayGroundView.height;
    
    if (xxWidth < 1) {
        xxWidth = (width - 4 - 4 - 1) / 2 ;
    }
    if (xxHeight < 1) {
        xxHeight = 200- 4 - 4;
    }
    
    CGFloat point_cornerRadius = 3;
    if (isLeft) {
        
        for(UIView *subView in [_leftPlayGroundView subviews])
        {
            [subView removeFromSuperview];
        }
        
        for (TuTuosHotShootPointModel *m in model) { //X = 49 Y = 32
            
            
            CGFloat y = [m.xAxis floatValue] * (xxHeight / 50);
            CGFloat x = [m.yAxis floatValue] * (xxWidth / 32);
            
            if (x > xxWidth || y > xxHeight) {
                continue;
            }
            
            UIView *pointView = [self createPoint];
            if ([m.isHit isEqualToString:@"1"]) {
                pointView.backgroundColor = [UIColor colorWithHexString:@"6290d2"];
            }
            pointView.layer.cornerRadius = point_cornerRadius;
            pointView.layer.borderColor = [UIColor colorWithHexString:@"6290d2"].CGColor;
            
            [_leftPlayGroundView addSubview:pointView];
            
            [pointView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.width.mas_equalTo(point_cornerRadius * 2);
                make.centerX.mas_equalTo(_leftPlayGroundView.mas_leading).mas_offset(x);
                make.centerY.mas_equalTo(_leftPlayGroundView.mas_bottom).mas_offset(-y);
            }];
        }
    }else{
        
        for(UIView *subView in [_rightPlayGroundView subviews])
        {
            [subView removeFromSuperview];
        }
        
        for (TuTuosHotShootPointModel *m in model) {
            
            CGFloat y = [m.xAxis floatValue] * (xxHeight / 50);
            CGFloat x = [m.yAxis floatValue] * (xxWidth / 32);
            
            if (x > xxWidth || y > xxHeight) {
                continue;
            }
            
            UIView *pointView = [self createPoint];
            if ([m.isHit isEqualToString:@"1"]) {
                pointView.backgroundColor = [UIColor colorWithHexString:@"e95c3b"];
            }
            pointView.layer.cornerRadius = point_cornerRadius;
            pointView.layer.borderColor = [UIColor colorWithHexString:@"e95c3b"].CGColor;
            
            [_rightPlayGroundView addSubview:pointView];
            
            [pointView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.width.mas_equalTo(point_cornerRadius * 2);
                make.centerX.mas_equalTo(_rightPlayGroundView.mas_trailing).mas_offset(-x);
                make.centerY.mas_equalTo(_rightPlayGroundView.mas_top).mas_offset(y);
            }];
        }
    }
    
}

-(UIView *)createPoint
{
    UIView *point = [[UIView alloc] init];
    point.layer.borderWidth = 1.0;
    //point.layer.borderColor = UIColor.blueColor.CGColor;
    return point;
}

/**
-(void) initScatterChartView:(ScatterChartView *)mScatterChartView
{
    mScatterChartView.chartDescription.enabled = NO;
    mScatterChartView.drawGridBackgroundEnabled = NO;
    mScatterChartView.dragEnabled = NO;
    [mScatterChartView setScaleEnabled:NO];
//    mScatterChartView.maxVisibleCount = 200;
    mScatterChartView.pinchZoomEnabled = YES;
    
    mScatterChartView.userInteractionEnabled = NO;
   
    mScatterChartView.rightAxis.enabled = YES;
    mScatterChartView.leftAxis.enabled = YES;
    mScatterChartView.legend.enabled = NO;
    
    ChartXAxis *xAxis = mScatterChartView.xAxis;
//    xAxis.enabled = NO;
    xAxis.labelPosition = XAxisLabelPositionBottomInside;
//    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawGridLinesEnabled = NO;
    xAxis.xOffset = 0;
    xAxis.yOffset = 0;
    xAxis.drawLabelsEnabled = NO;
}


- (void)setDataModel:(NSArray<TuTuosHotShootPointModel *> *) model isLeft:(BOOL) isLeft width:(CGFloat)width height:(CGFloat)height
{
    NSMutableArray<TuTuosHotShootPointModel *> *hitDataModel = [[NSMutableArray alloc] init];
    NSMutableArray<TuTuosHotShootPointModel *> *notHitDataModel = [[NSMutableArray alloc] init];
    
    NSMutableArray *hitVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *notHitVals2 = [[NSMutableArray alloc] init];
    
    
    CGFloat v_width = self.leftChartView.width;
    CGFloat v_height = self.leftChartView.height;
    
    if (v_width == 0) {
        return;
    }
    
    if (v_width < 1) {
        v_width = (width - 8 - 4)/2;
    }
    double sa_w = v_width/50;
    
    if (v_height < 1) {
        v_height = 200;
    }
    double sa_h = v_height/32;
    
    for (TuTuosHotShootPointModel *pm in model) {//是否命中 1-是 0-否

        double xValue = [pm.xAxis doubleValue] * sa_w;
        double yValue = [pm.yAxis doubleValue] * sa_h;
        if (xValue >= 0 && yValue >= 0) {
            
            if ([pm.isHit isEqualToString:@"1"]) {
                [hitDataModel addObject:pm];
                [hitVals1 addObject:[[ChartDataEntry alloc] initWithX:xValue y:yValue]];
                
            }else{
                [notHitDataModel addObject:pm];
                [notHitVals2 addObject:[[ChartDataEntry alloc] initWithX:xValue y:yValue]];
            }
        }else{
            NSLog(@"TuTuosHotShootPointModel xValue小于0->%f , %f",xValue,yValue);
        }
       
    }
    ScatterChartDataSet *hitDataSet = [[ScatterChartDataSet alloc] initWithEntries:hitVals1 label:@""];
    [hitDataSet setScatterShape:ScatterShapeCircle];
    hitDataSet.scatterShapeHoleColor = UIColor.blueColor;
    hitDataSet.scatterShapeHoleRadius = 2.5f;
    [hitDataSet setColor:UIColor.blueColor];
    
    ScatterChartDataSet *notHitDataSet = [[ScatterChartDataSet alloc] initWithEntries:notHitVals2 label:@""];
    [notHitDataSet setScatterShape:ScatterShapeCircle];
    //notHitDataSet.scatterShapeHoleColor = UIColor.blueColor;
    notHitDataSet.scatterShapeHoleRadius = 2.5f;
    [notHitDataSet setColor:UIColor.blueColor];
   
    
    hitDataSet.scatterShapeSize = 6.0;
    notHitDataSet.scatterShapeSize = 6.0;
   
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:hitDataSet];
    [dataSets addObject:notHitDataSet];
  
    ScatterChartData *data = [[ScatterChartData alloc] initWithDataSets:dataSets];
    data.highlightEnabled = NO;
    
    self.leftChartView.data = data;
    [self.leftChartView notifyDataSetChanged];
    
}*/

@end
