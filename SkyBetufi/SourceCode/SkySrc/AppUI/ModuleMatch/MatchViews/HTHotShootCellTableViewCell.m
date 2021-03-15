//
//  HTHotShootCellTableViewCell.m
//  XXXHeiTai
//
//  Created by ganyuanrong on 2021/3/5.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import "HTHotShootCellTableViewCell.h"
#import "GamaAlertView.h"
#import "UIView+GlodBuleViewController.h"
#import "GlodBuleHTMatchSummaryRequest.h"

@interface HTHotShootCellTableViewCell ()

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

@property (nonatomic, strong)NSArray<HotShootPointModel *> *hotShootPointModel_away_temp;
@property (nonatomic, strong)NSArray<HotShootPointModel *> *hotShootPointModel_home_temp;

@end

@implementation HTHotShootCellTableViewCell

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

- (void)setDataModel:(NSArray<HotShootPointModel *> *) model isLeft:(BOOL) isLeft width:(CGFloat)width height:(CGFloat)height
{
    if (isLeft) {
            
        if (!_hotShootPointModel_away_temp) {
            [self.hotShootView setDataModel:model isLeft:isLeft width:width height:height];
        }else{
            [self.hotShootView setDataModel:_hotShootPointModel_away_temp isLeft:YES width:width height:height];
        }
        
    }else{
        
        if (!_hotShootPointModel_home_temp) {
            [self.hotShootView setDataModel:model isLeft:isLeft width:width height:height];
        }else{
            [self.hotShootView setDataModel:_hotShootPointModel_home_temp isLeft:NO width:width height:height];
        }
        
    }

}


-(void) updateDataModel:(NSArray<HotShootPointModel *> *) model  summaryModel:(GlodBuleHTMatchSummaryModel *)summaryModel matchCompareModel:(GlodBuleHTMatchCompareModel *)matchCompareModel gameId:(NSString*)gameId isLeft:(BOOL) isLeft
{
    
    [self.leftTeamIcon sd_setImageWithURL:[NSURL URLWithString:summaryModel.awayLogo]];
    
    [self.rightTeamIcon sd_setImageWithURL:[NSURL URLWithString:summaryModel.homeLogo]];
    
    self.game_id = gameId;
    
    if (isLeft) {
        if (_awayPlayerArrayIds.count > 1) {
            return;
        }
        for (GlodBuleHTMatchDetailsModel *m in matchCompareModel.awayTeamDetails) {
            [_awayPlayerArray addObject:m.name];
            [_awayPlayerArrayIds addObject:m.playerId];
        }

    }else{
        if (_homePlayerArrayIds.count > 1) {
            return;
        }
        for (GlodBuleHTMatchDetailsModel *m in matchCompareModel.homeTeamDetails) {
            [_homePlayerArray addObject:m.name];
            [_homePlayerArrayIds addObject:m.playerId];
        }
    }

}

-(void)clickSelectQuartView{
    [GamaAlertView showActionSheetWithTitle:nil
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
        [self refreshDataWithTeam:@"2" playerId:self.awayPlayerId];
        [self refreshDataWithTeam:@"1" playerId:self.homePlayerId];
        
                        }
                     destructiveButtonTitle:nil
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:[NSArray arrayWithArray:self.quartArray]
                               ];
}

-(void)selectLeftPlayer
{
    [GamaAlertView showActionSheetWithTitle:nil
                                    message:nil
                              callbackBlock:^(NSInteger btnIndex) {
        NSLog(@"callbackBlock=%d", btnIndex);
        
        if (btnIndex > 0) {
            self.leftTeamPlayerName.text = self.awayPlayerArray[btnIndex - 1];
            self.awayPlayerId = self.awayPlayerArrayIds[btnIndex - 1];
        }
        [self refreshDataWithTeam:@"2" playerId:self.awayPlayerId];
                              }
                     destructiveButtonTitle:nil
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:_awayPlayerArray];
}

-(void)selectRightPlayer
{
    [GamaAlertView showActionSheetWithTitle:nil
                                    message:nil
                              callbackBlock:^(NSInteger btnIndex) {
        NSLog(@"callbackBlock=%d", btnIndex);
        if (btnIndex > 0) {
            self.rightTeamPlayerName.text = self.homePlayerArray[btnIndex - 1];
            self.homePlayerId = self.homePlayerArrayIds[btnIndex - 1];
        }
        [self refreshDataWithTeam:@"1" playerId:self.homePlayerId];
                              }
                     destructiveButtonTitle:nil
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:_homePlayerArray];
}


-(void) refreshDataWithTeam:(NSString *)team playerId:(NSString *)playerId //1-主队 2-客队
{
    kWeakSelf
    [GlodBuleHTMatchSummaryRequest getShootPointWithGameId:self.game_id home_away:team playerId:playerId quarter:self.quartId successBlock:^(NSArray<HotShootPointModel *> *model) {
        
        if ([team isEqualToString:@"1"]) {
            [weakSelf.hotShootView setDataModel:model isLeft:NO width:SCREEN_WIDTH height:0];
            weakSelf.hotShootPointModel_home_temp = model;
        }else{
            [weakSelf.hotShootView setDataModel:model isLeft:YES width:SCREEN_WIDTH height:0];
            weakSelf.hotShootPointModel_away_temp = model;
        }
        
        
    } errorBlock:^(GlodBuleBJError *error) {
        
    }];
    
}
@end
