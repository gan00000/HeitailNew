//
//  NSNiceHTHotShootCellTableViewCell.m
//  
//
//  Created by ganyuanrong on 2021/3/5.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import "NSNiceHTHotShootCellTableViewCell.h"
#import "FFlaliGamaAlertView.h"
#import "UIView+BByasViewController.h"
#import "MMoogHTMatchSummaryRequest.h"
#import "UIImageView+FFlaliHT.h"

@interface NSNiceHTHotShootCellTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *selectQuartView;
@property (weak, nonatomic) IBOutlet UILabel *selectQuartLabel;

@property (copy, nonatomic) NSString * quartId;
@property (copy, nonatomic) NSString * awayPlayerId;
@property (copy, nonatomic) NSString * homePlayerId;

@property (copy, nonatomic) NSString * game_id;

@property (nonatomic, strong) NSArray *quartArray;
@property (nonatomic, strong) NSMutableArray *awayPlayerArray;
@property (nonatomic, strong) NSMutableArray *homePlayerArray;

@property (nonatomic, strong) NSMutableArray *awayPlayerArrayIds;
@property (nonatomic, strong) NSMutableArray *homePlayerArrayIds;

@property (weak, nonatomic) IBOutlet UIImageView *leftTeamIcon;
@property (weak, nonatomic) IBOutlet UILabel *leftTeamPlayerName;

@property (weak, nonatomic) IBOutlet UIImageView *rightTeamIcon;

@property (weak, nonatomic) IBOutlet UILabel *rightTeamPlayerName;

@property (weak, nonatomic) IBOutlet UIView *leftTeamPlayerSelectView;
@property (weak, nonatomic) IBOutlet UIView *rightTeamPlayerSelectView;

@property (nonatomic, strong)NSArray<TuTuosHotShootPointModel *> *hotShootPointModel_away_temp;
@property (nonatomic, strong)NSArray<TuTuosHotShootPointModel *> *hotShootPointModel_home_temp;

@property (weak, nonatomic) IBOutlet UILabel *hotPointDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftPtsLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightPtsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *teamIcon;

@end

@implementation NSNiceHTHotShootCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentView.backgroundColor = UIColor.whiteColor;
    self.quartArray = @[@"全場比賽",@"第一節",@"第二節",@"第三節",@"第四節"];
    self.awayPlayerArray = [NSMutableArray arrayWithArray:@[@"全部球員"]];
    self.homePlayerArray = [NSMutableArray arrayWithArray:@[@"全部球員"]];
    
    self.awayPlayerArrayIds = [NSMutableArray arrayWithArray:@[@""]];
    self.homePlayerArrayIds = [NSMutableArray arrayWithArray:@[@""]];
    
    [self.selectQuartView setViewTapGestureWithTarget:self action:@selector(clickSelectQuartView)];
    
    [self.leftTeamPlayerSelectView setViewTapGestureWithTarget:self action:@selector(selectLeftPlayer)];
    [self.rightTeamPlayerSelectView setViewTapGestureWithTarget:self action:@selector(selectRightPlayer)];
    
    self.quartId = @"";
    self.awayPlayerId = @"";
    self.homePlayerId = @"";
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateHotShootDataModel:(NSArray<TuTuosHotShootPointModel *> *) model isLeft:(BOOL) isLeft width:(CGFloat)width height:(CGFloat)height
{
    
    [self refreshHomeShootPoint];
    [self refreshAwayShootPoint];
    
//    if (isLeft) {
//
//        if (!_hotShootPointModel_away_temp) {
//            [self.hotShootView setDataModel:model isLeft:isLeft width:width height:height];
//            self.leftPtsLabel.text = [self setHitRate:model];
//        }else{
//            [self.hotShootView setDataModel:_hotShootPointModel_away_temp isLeft:YES width:width height:height];
//            self.leftPtsLabel.text = [self setHitRate:_hotShootPointModel_away_temp];
//        }
//
//    }else{
//
//        if (!_hotShootPointModel_home_temp) {
//            [self.hotShootView setDataModel:model isLeft:isLeft width:width height:height];
//            self.rightPtsLabel.text = [self setHitRate:model];
//        }else{
//            [self.hotShootView setDataModel:_hotShootPointModel_home_temp isLeft:NO width:width height:height];
//            self.rightPtsLabel.text = [self setHitRate:_hotShootPointModel_home_temp];
//        }
//
//    }

}


-(void) updateMatchInfoWiithSummaryModel:(KSasxHTMatchSummaryModel *)summaryModel matchCompareModel:(BByasHTMatchCompareModel *)matchCompareModel gameId:(NSString*)gameId
{
    
    [self.leftTeamIcon sd_setImageWithURL:[NSURL URLWithString:summaryModel.awayLogo]];
    
    [self.rightTeamIcon sd_setImageWithURL:[NSURL URLWithString:summaryModel.homeLogo]];
    
    self.game_id = gameId;
    
    [self.teamIcon th_setImageWithURL:summaryModel.homeLogo placeholderImage:nil];
    
    NSString *gameStatus = @"";
    if ([summaryModel.scheduleStatus isEqualToString:@"Final"]) {
        gameStatus = @"已結束";
       
    } else if ([summaryModel.scheduleStatus isEqualToString:@"InProgress"]) {
        gameStatus = [NSString stringWithFormat:@"第%@節", summaryModel.quarter];
    }
    
    self.hotPointDesLabel.text = [NSString stringWithFormat:@"%@ %@-%@ %@ %@ %@",summaryModel.awayName,summaryModel.away_pts,summaryModel.home_pts,summaryModel.homeName,gameStatus,summaryModel.date];
    
    if (_awayPlayerArrayIds.count > 1) {
        return;
    }
    for (UUaksHTMatchDetailsModel *m in matchCompareModel.awayTeamDetails) {
        [_awayPlayerArray addObject:m.name];
        [_awayPlayerArrayIds addObject:m.playerId];
    }
    
    if (_homePlayerArrayIds.count > 1) {
        return;
    }
    for (UUaksHTMatchDetailsModel *m in matchCompareModel.homeTeamDetails) {
        [_homePlayerArray addObject:m.name];
        [_homePlayerArrayIds addObject:m.playerId];
    }

}

-(void)clickSelectQuartView{
    [FFlaliGamaAlertView showActionSheetWithTitle:nil
                                    message:nil
                              callbackBlock:^(NSInteger btnIndex) {
        
                            NSLog(@"callbackBlock=%d", btnIndex);
                            if (btnIndex > 0) {
                                self.selectQuartLabel.text = self.quartArray[btnIndex - 1];
                            }
                            self.quartId = @(btnIndex - 1).stringValue;
                            if (self.quartId == 0) {
                                self.quartId = @"";
                            }
        [self refreshHomeShootPoint];
        [self refreshAwayShootPoint];
        
                        }
                     destructiveButtonTitle:nil
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:[NSArray arrayWithArray:self.quartArray]
                               ];
}

-(void)selectLeftPlayer
{
    [FFlaliGamaAlertView showActionSheetWithTitle:nil
                                    message:nil
                              callbackBlock:^(NSInteger btnIndex) {
        NSLog(@"callbackBlock=%d", btnIndex);
        
        if (btnIndex > 0) {
            self.leftTeamPlayerName.text = self.awayPlayerArray[btnIndex - 1];
            self.awayPlayerId = self.awayPlayerArrayIds[btnIndex - 1];
        }
        [self refreshAwayShootPoint];
                              }
                     destructiveButtonTitle:nil
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:_awayPlayerArray];
}

-(void)selectRightPlayer
{
    [FFlaliGamaAlertView showActionSheetWithTitle:nil
                                    message:nil
                              callbackBlock:^(NSInteger btnIndex) {
        NSLog(@"callbackBlock=%d", btnIndex);
        if (btnIndex > 0) {
            self.rightTeamPlayerName.text = self.homePlayerArray[btnIndex - 1];
            self.homePlayerId = self.homePlayerArrayIds[btnIndex - 1];
        }
        [self refreshHomeShootPoint];
                              }
                     destructiveButtonTitle:nil
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:_homePlayerArray];
}

-(void) refreshHomeShootPoint
{
    [self refreshDataWithTeam:@"1" playerId:self.homePlayerId];
}

-(void) refreshAwayShootPoint
{
    [self refreshDataWithTeam:@"2" playerId:self.awayPlayerId];
}

-(void) refreshDataWithTeam:(NSString *)team playerId:(NSString *)playerId //1-主队 2-客队
{
    kWeakSelf
    [MMoogHTMatchSummaryRequest getShootPointWithGameId:self.game_id home_away:team playerId:playerId quarter:self.quartId successBlock:^(NSArray<TuTuosHotShootPointModel *> *model) {
        
        if ([team isEqualToString:@"1"]) {
            [weakSelf.hotShootView setDataModel:model isLeft:NO width:SCREEN_WIDTH height:0];
            weakSelf.hotShootPointModel_home_temp = model;

            weakSelf.rightPtsLabel.text = [weakSelf setHitRate:model];
            
        }else{
            [weakSelf.hotShootView setDataModel:model isLeft:YES width:SCREEN_WIDTH height:0];
            weakSelf.hotShootPointModel_away_temp = model;
            
            weakSelf.leftPtsLabel.text = [weakSelf setHitRate:model];
        }
        
        
    } errorBlock:^(WSKggBJError *error) {
        
    }];
    
}

-(NSString *)setHitRate:(NSArray<TuTuosHotShootPointModel *> *)model
{
    CGFloat hitCount = 0;
    NSUInteger allCount = model.count;
    if (model) {
        for (TuTuosHotShootPointModel *x in model) {
            if ([x.isHit isEqualToString:@"1"]) {
                hitCount = hitCount + 1;
            }
        }
    }
    CGFloat hitRate = (hitCount / allCount) * 100;
    
    CGFloat rounded_up = round(hitRate);
    NSLog(@"%.0lf",rounded_up);
    
    NSString *rate = [NSString stringWithFormat:@"投籃:(%.0lf-%d) %.0lf%@", hitCount, allCount, rounded_up,@"%"];
//    self.leftPtsLabel.text = rate;
//    self.rightPtsLabel.text = rate;
    return rate;
}
@end
