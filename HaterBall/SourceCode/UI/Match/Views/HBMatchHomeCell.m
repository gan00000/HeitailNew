#import "HBMatchHomeCell.h"
#import <WebKit/WebKit.h>
@interface HBMatchHomeCell () <WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet UILabel *homeTeamNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *homeTeamLogo;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamPtsLabel;
@property (strong, nonatomic) WKWebView *homeTeamLogoWeb;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *awayTeamLogo;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamPtsLabel;
@property (strong, nonatomic) WKWebView *awayTeamLogoWeb;
@property (weak, nonatomic) IBOutlet UILabel *matchStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end
@implementation HBMatchHomeCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.homeTeamLogo.contentMode = UIViewContentModeScaleAspectFit;
    self.awayTeamLogo.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.homeTeamLogoWeb];
    [self.homeTeamLogoWeb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.homeTeamLogo);
        make.left.equalTo(self.homeTeamLogo);
        make.bottom.equalTo(self.homeTeamLogo);
        make.right.equalTo(self.homeTeamLogo);
    }];
    [self addSubview:self.awayTeamLogoWeb];
    [self.awayTeamLogoWeb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.awayTeamLogo);
        make.left.equalTo(self.awayTeamLogo);
        make.bottom.equalTo(self.awayTeamLogo);
        make.right.equalTo(self.awayTeamLogo);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setupWithMatchModel:(HBMatchHomeModel *)matchModel {
    self.homeTeamLogo.hidden = YES;
    self.homeTeamLogoWeb.hidden = YES;
    self.awayTeamLogo.hidden = YES;
    self.awayTeamLogoWeb.hidden = YES;
    if (matchModel.img_home_logo) {
        self.homeTeamLogoWeb.hidden = NO;
        [self.homeTeamLogoWeb loadHTMLString:matchModel.img_home_logo baseURL:nil];
    } else {
        self.homeTeamLogo.hidden = NO;
        [self.homeTeamLogo sd_setImageWithURL:[NSURL URLWithString:matchModel.homeLogo] placeholderImage:HT_DEFAULT_TEAM_LOGO];
    }
    self.homeTeamNameLabel.text = matchModel.homeName;
    self.homeTeamPtsLabel.text = matchModel.home_pts;
    if (matchModel.img_away_logo) {
        self.awayTeamLogoWeb.hidden = NO;
        [self.awayTeamLogoWeb loadHTMLString:matchModel.img_away_logo baseURL:nil];
    } else {
        self.awayTeamLogo.hidden = NO;
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
    if (matchModel.game_status == 1) {
        self.matchStatusLabel.text = @"已結束";
        self.timeLabel.hidden = YES;
    } else if ([matchModel.scheduleStatus isEqualToString:@"Final"]) {
        self.matchStatusLabel.text = @"已結束";
        self.timeLabel.hidden = YES;
    } else if ([matchModel.scheduleStatus isEqualToString:@"InProgress"]) {
        if (matchModel.quarter.length > 0) {
            self.matchStatusLabel.text = matchModel.quarter;
        }
        if (matchModel.quarter_time.length > 0) {
            self.timeLabel.text = matchModel.quarter_time;
        }        
    } else if ([matchModel.scheduleStatus isEqualToString:@"Canceled"]) {
        self.matchStatusLabel.text = @"已取消";
    } else if ([matchModel.scheduleStatus isEqualToString:@"Postponed"]) {
        self.matchStatusLabel.text = @"未開始";
    } else {
        self.matchStatusLabel.text = @"未開始";
    }
}
- (WKWebView *)homeTeamLogoWeb {
    if (!_homeTeamLogoWeb) {
        _homeTeamLogoWeb = [[WKWebView alloc] init];
        _homeTeamLogoWeb.scrollView.scrollEnabled = NO;
    }
    return _homeTeamLogoWeb;
}
- (WKWebView *)awayTeamLogoWeb {
    if (!_awayTeamLogoWeb) {
        _awayTeamLogoWeb = [[WKWebView alloc] init];
        _awayTeamLogoWeb.scrollView.scrollEnabled = NO;
    }
    return _awayTeamLogoWeb;
}
@end
