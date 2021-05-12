#import "YYPackageHTMatchHomeCell.h"
#import <WebKit/WebKit.h>
#import "UIImageView+NDeskGlodBuleSVG.h"
#import "PXFunConfigCoreUtil.h"

@interface YYPackageHTMatchHomeCell () <WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet UILabel *homeTeamNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *homeTeamLogo;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamPtsLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *awayTeamLogo;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamPtsLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *playBtnImageView;

@property (nonatomic, strong) SundayHTMatchHomeModel *matchModel;

@end
@implementation YYPackageHTMatchHomeCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.homeTeamLogo.contentMode = UIViewContentModeScaleAspectFit;
    self.awayTeamLogo.contentMode = UIViewContentModeScaleAspectFit;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)taosetupWithMatchModel:(SundayHTMatchHomeModel *)matchModel matchType:(NSString *)matchType{
    
    self.matchModel = matchModel;
    
    if ([matchModel.homeLogo hasSuffix:@"svg"]) {
         [self.homeTeamLogo svg_setImageWithURL:[NSURL URLWithString:matchModel.homeLogo] placeholderImage:HT_DEFAULT_TEAM_LOGO];
    }else{
        [self.homeTeamLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.homeLogo] placeholderImage:HT_DEFAULT_TEAM_LOGO];
    }
    self.homeTeamNameLabel.text = matchModel.homeName;
    self.homeTeamPtsLabel.text = matchModel.home_pts;
    if ([matchModel.awayLogo hasSuffix:@"svg"]) {
        [self.awayTeamLogo svg_setImageWithURL:[NSURL URLWithString:matchModel.awayLogo] placeholderImage:HT_DEFAULT_TEAM_LOGO];
    }else{
         [self.awayTeamLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.awayLogo] placeholderImage:HT_DEFAULT_TEAM_LOGO];
    }
    self.awayTeamNameLabel.text = matchModel.awayName;
    self.awayTeamPtsLabel.text = matchModel.away_pts;
    self.homeTeamPtsLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"666666" alpha:1.0];
    self.awayTeamPtsLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"666666" alpha:1.0];
    if (matchModel.home_pts.integerValue > matchModel.away_pts.integerValue) {
        self.homeTeamPtsLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"151515" alpha:1.0];
        self.awayTeamPtsLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"BBBBBB" alpha:0.8];
    } else if (matchModel.home_pts.integerValue < matchModel.away_pts.integerValue) {
        self.homeTeamPtsLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"BBBBBB" alpha:0.8];
        self.awayTeamPtsLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"151515" alpha:1.0];        
    }
    self.timeLabel.text = matchModel.gametime;
    self.timeLabel.hidden = NO;
//    if (matchModel.game_status == 1) {//0未开始 1進行中、2已結束
//        self.matchStatusLabel.text = @"已結束";
//        self.timeLabel.hidden = YES;
//    } else
    
    self.backPlayView.hidden = YES;
    self.playBtnImageView.hidden = NO;
    if ([matchModel.scheduleStatus isEqualToString:@"Final"]) {
        self.matchStatusLabel.text = @"已結束";
        self.timeLabel.hidden = YES;
        if ([matchType isEqualToString:@"1"]) {
            self.backPlayView.hidden = NO;
        }
       
        self.playBtnImageView.hidden = YES;
        
//        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startPlay)];
//        self.backPlayView.userInteractionEnabled = YES;
//        [self.backPlayView addGestureRecognizer:tapGes];
        if ([self showPlayback]) {//比赛结束6小时候显示
            self.backPlayView.hidden = NO;
        }else{
            self.backPlayView.hidden = YES;
        }
        
    } else if ([matchModel.scheduleStatus isEqualToString:@"InProgress"]) {
        if (matchModel.quarter.length > 0) {
            self.matchStatusLabel.text = matchModel.quarter;
        }
        if (matchModel.quarter_time.length > 0) {
            self.timeLabel.text = matchModel.quarter_time;
        }        
    } else if ([matchModel.scheduleStatus isEqualToString:@"Canceled"]) {
        self.matchStatusLabel.text = @"已取消";
    } else if ([matchModel.scheduleStatus isEqualToString:@"NotStarted"]) {
        self.matchStatusLabel.text = @"未開始";
    } else {
        self.matchStatusLabel.text = @"未開始";
    }
}

- (void)startPlay {
    
    NSString *token = @"";
    if ([MMTodayHTUserManager tao_isUserLogin]) {
        token = [MMTodayHTUserManager tao_userToken];
    }
    
    NSString *webUrl = [NSString stringWithFormat:@"http://app.ballgametime.com/api/nbaschedule.php?token=%@&game_id=%@",token,self.matchModel.game_id];
    
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:webUrl] options:@{} completionHandler:nil];
    } else {
        // Fallback on earlier versions
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:webUrl]];
    }
}

-(BOOL)showPlayback
{
    NSString *timeStr = [NSString stringWithFormat:@"%@ %@",self.matchModel.gamedate, [self.matchModel.time uppercaseString]];
    NSString *timeStamp = [PXFunConfigCoreUtil getTimeStrWithString: timeStr];
    
    double now_timestamp = [[PXFunConfigCoreUtil getTimeStamp] doubleValue];
    double game_timestamp = [timeStamp doubleValue];
    if (now_timestamp - game_timestamp > 6 * 60 * 60 * 1000) { //游戏未开始
        return YES;
    }
    return NO;
}
@end
