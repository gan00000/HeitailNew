//
//  HTScoreViewCell.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/18.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import "HTScoreViewCell.h"
#import "LineChartUtil.h"
#import <Masonry.h>
#import "UIColor+Hex.h"

@interface HTScoreViewCell()
@property (weak, nonatomic) IBOutlet UIView *chartContentView;
@property (weak, nonatomic) IBOutlet LineChartView *lineChartView;
@property (weak, nonatomic) IBOutlet UIView *chartBgView;

@property (nonatomic,strong) LineChartUtil *mLineChartUtil;
@property (nonatomic) BOOL isToViewAdd;

@end
@implementation HTScoreViewCell

- (void)addQuarterBgView:(BOOL)isTo {
    
    int screen_w = SCREEN_WIDTH;
    int xWidth = (screen_w - 28 - 10) / 4;
    
    if (isTo) {
        if (self.isToViewAdd) {
            return;
        }
        self.isToViewAdd = YES;
        xWidth = (screen_w - 28 - 10) / (48 + 5) * 12;
        for(UIView *view in [self.chartBgView subviews])
        {
            [view removeFromSuperview];
        }
    }
   
    self.chartBgView.backgroundColor = [UIColor whiteColor];
    UIView *firstViwe = [[UIView alloc] init];
    firstViwe.backgroundColor = [UIColor colorWithHexString:@"#c0c0c0" alpha: 0.35];
    [self.chartBgView addSubview:firstViwe];
    [firstViwe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.chartBgView).mas_offset(28);
        make.top.mas_equalTo(self.chartBgView).mas_offset(18);
        make.bottom.mas_equalTo(self.chartBgView).mas_offset(-20);
        make.width.mas_equalTo(xWidth);
    }];
    
    
    UIView *secondViwe = [[UIView alloc] init];
    secondViwe.backgroundColor = [UIColor colorWithHexString:@"#c0c0c0" alpha: 0.35];
    [self.chartBgView addSubview:secondViwe];
    [secondViwe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(firstViwe.mas_trailing).mas_offset(xWidth);
        make.top.mas_equalTo(firstViwe);
        make.bottom.mas_equalTo(firstViwe);
        make.width.mas_equalTo(xWidth);
    }];
    
    if (isTo) {
        UIView *toView = [[UIView alloc] init];
        toView.backgroundColor = [UIColor colorWithHexString:@"#c0c0c0" alpha: 0.35];
        [self.chartBgView addSubview:toView];
        [toView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(secondViwe.mas_trailing).mas_offset(xWidth);
            make.top.mas_equalTo(firstViwe);
            make.bottom.mas_equalTo(firstViwe);
            make.trailing.mas_equalTo(self.chartBgView).mas_offset(-10);
        }];
        
        UILabel *labelto = [[UILabel alloc] init];
        labelto.textAlignment = NSTextAlignmentCenter;
        labelto.text = @"加時";
        labelto.font = [UIFont systemFontOfSize:10];
        labelto.textColor = [UIColor grayColor];
        [self.chartBgView addSubview:labelto];
        [labelto mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(toView);
            make.top.mas_equalTo(toView.mas_bottom);
            make.bottom.mas_equalTo(self.chartBgView.mas_bottom);
            make.trailing.mas_equalTo(toView);
        }];
    }
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"第一節";
    label1.font = [UIFont systemFontOfSize:10];
    label1.textColor = [UIColor grayColor];
    [self.chartBgView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(firstViwe);
        make.top.mas_equalTo(firstViwe.mas_bottom);
        make.bottom.mas_equalTo(self.chartBgView.mas_bottom);
        make.trailing.mas_equalTo(firstViwe);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @"第二節";
    label2.font = [UIFont systemFontOfSize:10];
    label2.textColor = [UIColor grayColor];
    [self.chartBgView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(label1.mas_trailing);
        make.top.mas_equalTo(label1);
        make.bottom.mas_equalTo(label1);
        make.width.mas_equalTo(label1);
    }];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = @"第三節";
    label3.font = [UIFont systemFontOfSize:10];
    label3.textColor = [UIColor grayColor];
    [self.chartBgView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(label2.mas_trailing);
        make.top.mas_equalTo(label1);
        make.bottom.mas_equalTo(label1);
        make.width.mas_equalTo(label1);
    }];
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.textAlignment = NSTextAlignmentCenter;
    label4.text = @"第四節";
    label4.font = [UIFont systemFontOfSize:10];
    label4.textColor = [UIColor grayColor];
    [self.chartBgView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(label3.mas_trailing);
        make.top.mas_equalTo(label1);
        make.bottom.mas_equalTo(label1);
        make.width.mas_equalTo(label1);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _mLineChartUtil = [[LineChartUtil alloc]init];
    _mLineChartUtil.chartView = self.lineChartView;
    [_mLineChartUtil initChartView];
    
    [self addQuarterBgView:NO];
    self.isToViewAdd = NO;
}

- (void)setMatchSummaryModel:(SkyBallHetiRedHTMatchSummaryModel *)summaryModel liveFeedModel:(NSArray<SkyBallHetiRedHTMatchLiveFeedModel *> *)liveFeedModel
{
    if (!liveFeedModel || liveFeedModel.count < 1) {
        return;
    }
    BOOL inProgress = NO;
    if ([summaryModel.scheduleStatus isEqualToString:@"Final"]) {
        //已结束
       
    } else if ([summaryModel.scheduleStatus isEqualToString:@"InProgress"]) {
       //进行中
        inProgress = YES;
        if ([summaryModel.quarter isEqualToString:@"OT"]) {
            //加时
        }

    } else if ([summaryModel.scheduleStatus isEqualToString:@"Canceled"]) {
        // @"已取消";
    } else  {
       //@"未開始";
       
    }
    
    NSArray<SkyBallHetiRedHTMatchLiveFeedModel *> *c_liveFeedModel = [liveFeedModel copy];
    if (inProgress) {//进行中数据顺序翻转
        [c_liveFeedModel reverseObjectEnumerator];
    }
    
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    int yMax = 0;
    for (SkyBallHetiRedHTMatchLiveFeedModel *feedMode in c_liveFeedModel) {
        
        int seconds = [feedMode.seconds intValue];
        int minutes = [feedMode.minutes intValue];
        int quarter = [feedMode.quarter intValue];
        int homePts = [feedMode.homePts intValue];
        int awayPts = [feedMode.awayPts intValue];
        
//        BJLog(@"quarter = %ld",quarter);
        int tempSeconds = 0;
        if (quarter > 4) {
            BJLog(@"quarter > 4 计算加时");//此处只做了一节的加时处理
            int playSeconds = 5 * 60 - (seconds + minutes * 60) + (4 * 12 * 60); //x 数据使用秒
            if (playSeconds >= tempSeconds) {//防止数据突然不正常突然变小出现图标异常
                [yVals1 addObject:[[ChartDataEntry alloc] initWithX:playSeconds y: awayPts]];
                [yVals2 addObject:[[ChartDataEntry alloc] initWithX:playSeconds y: homePts]];
                tempSeconds = playSeconds;
            }
        }else{
           
            int playSeconds = 12 * 60 - (seconds + minutes * 60) + ((quarter - 1) * 12 * 60); //x 数据使用秒
            if (playSeconds >= tempSeconds) {
                [yVals1 addObject:[[ChartDataEntry alloc] initWithX:playSeconds y: awayPts]];
                [yVals2 addObject:[[ChartDataEntry alloc] initWithX:playSeconds y: homePts]];
                tempSeconds = playSeconds;
            }
        }
       
    }
    
    SkyBallHetiRedHTMatchLiveFeedModel *last_feedMode = c_liveFeedModel.lastObject;
    int lasthomePts = [last_feedMode.homePts intValue];
    int lastawayPts = [last_feedMode.awayPts intValue];
    NSUInteger toCount = last_feedMode.toCount;
    yMax = lasthomePts > lastawayPts ? lasthomePts : lastawayPts;
       
////            double mult = range;
//            double val = (double) (arc4random_uniform(range));
//            [yVals2 addObject:[[ChartDataEntry alloc] initWithX:i y:i + 2]];
//        }
    
    
    if (toCount > 0) {
        [self addQuarterBgView:YES];
    }
    
    int m = yMax/30;
    yMax = (m + 1) * 30;
    [_mLineChartUtil setData:yVals1 data2:yVals2 yMax:yMax toCount:toCount lable1:summaryModel.awayName lable2:summaryModel.homeName];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
