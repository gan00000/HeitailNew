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


- (void)setDataModel:(NSArray<HotShootPointModel *> *) model isLeft:(BOOL) isLeft width:(CGFloat)width height:(CGFloat)height
{
    NSMutableArray<HotShootPointModel *> *hitDataModel = [[NSMutableArray alloc] init];
    NSMutableArray<HotShootPointModel *> *notHitDataModel = [[NSMutableArray alloc] init];
    
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
    
    for (HotShootPointModel *pm in model) {//是否命中 1-是 0-否

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
            NSLog(@"HotShootPointModel xValue小于0->%f , %f",xValue,yValue);
        }
       
    }
    
//    [hitVals1 sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        ChartDataEntry *mChartDataEntry1 = obj1;
//        ChartDataEntry *mChartDataEntry2 = obj2;
//        
//        if (mChartDataEntry1.x < mChartDataEntry2.x) {
//            return NSOrderedAscending;//表示两个比较的对象前者小于后置
//        }else if(mChartDataEntry2.x == mChartDataEntry1.x){
//            return NSOrderedSame;
//        }
//        return NSOrderedDescending;
//    }];
//
//    [notHitVals2 sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        ChartDataEntry *mChartDataEntry1 = obj1;
//        ChartDataEntry *mChartDataEntry2 = obj2;
//        
//        if (mChartDataEntry1.x < mChartDataEntry2.x) {
//            return NSOrderedAscending;//表示两个比较的对象前者小于后置
//        }else if(mChartDataEntry2.x == mChartDataEntry1.x){
//            return NSOrderedSame;
//        }
//        return NSOrderedDescending;
//    }];
    
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
//    self.rightChartView.data = data;
//    [self.rightChartView notifyDataSetChanged];
    
//    if (isLeft) {
//        self.leftChartView.data = data;
//        [self.leftChartView notifyDataSetChanged];
//    }else{
//        self.rightChartView.data = data;
//        [self.rightChartView notifyDataSetChanged];
//    }
    
}

@end
