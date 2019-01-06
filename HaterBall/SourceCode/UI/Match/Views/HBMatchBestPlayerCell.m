#import "HBMatchBestPlayerCell.h"
@interface HBMatchBestPlayerCell ()
@property (weak, nonatomic) IBOutlet UILabel *homePtsLabel;
@property (weak, nonatomic) IBOutlet UILabel *homePtsPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *homePtsPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeAstLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeAstPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeAstPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeRebLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeRebPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeRebPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayPtsLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayPtsPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayPtsPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayAstLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayAstPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayAstPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayRebLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayRebPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayRebPlaceLabel;
@end
@implementation HBMatchBestPlayerCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setupWithMatchSummaryModel:(HBMatchSummaryModel *)summaryModel {
    self.homePtsLabel.text = summaryModel.home_team_pts_most.pts.length > 0 ? summaryModel.home_team_pts_most.pts : @"0";
    self.homePtsPlayerLabel.text = summaryModel.home_team_pts_most.name.length > 0 ? summaryModel.home_team_pts_most.name : @"";
    self.homePtsPlaceLabel.text = [NSString stringWithFormat:@"位置：%@", summaryModel.home_team_pts_most.position.length > 0?summaryModel.home_team_pts_most.position : @""];
    self.homeAstLabel.text = summaryModel.home_team_ast_most.ast.length > 0 ? summaryModel.home_team_ast_most.ast : @"0";
    self.homeAstPlayerLabel.text = summaryModel.home_team_ast_most.name.length > 0 ? summaryModel.home_team_ast_most.name : @"";
    self.homeAstPlaceLabel.text = [NSString stringWithFormat:@"位置：%@", summaryModel.home_team_ast_most.position.length > 0 ? summaryModel.home_team_ast_most.position : @""];
    self.homeRebLabel.text = summaryModel.home_team_reb_most.reb.length > 0 ? summaryModel.home_team_reb_most.reb : @"0";
    self.homeRebPlayerLabel.text = summaryModel.home_team_reb_most.name.length > 0 ? summaryModel.home_team_reb_most.name : @"";
    self.homeRebPlaceLabel.text = [NSString stringWithFormat:@"位置：%@", summaryModel.home_team_reb_most.position.length > 0 ? summaryModel.home_team_reb_most.position : @""];
    self.awayPtsLabel.text = summaryModel.away_team_pts_most.pts.length > 0 ? summaryModel.away_team_pts_most.pts : @"0";
    self.awayPtsPlayerLabel.text = summaryModel.away_team_pts_most.name.length > 0 ? summaryModel.away_team_pts_most.name : @"";
    self.awayPtsPlaceLabel.text = [NSString stringWithFormat:@"位置：%@", summaryModel.away_team_pts_most.position.length > 0 ? summaryModel.away_team_pts_most.position : @""];
    self.awayAstLabel.text = summaryModel.away_team_ast_most.ast.length > 0 ? summaryModel.away_team_ast_most.ast : @"0";
    self.awayAstPlayerLabel.text = summaryModel.away_team_ast_most.name.length > 0 ? summaryModel.away_team_ast_most.name : @"";
    self.awayAstPlaceLabel.text = [NSString stringWithFormat:@"位置：%@", summaryModel.away_team_ast_most.position.length > 0 ? summaryModel.away_team_ast_most.position : @""];
    self.awayRebLabel.text = summaryModel.away_team_reb_most.reb.length > 0 ? summaryModel.away_team_reb_most.reb : @"0";
    self.awayRebPlayerLabel.text = summaryModel.away_team_reb_most.name.length > 0 ? summaryModel.away_team_reb_most.name : @"";
    self.awayRebPlaceLabel.text = [NSString stringWithFormat:@"位置：%@", summaryModel.away_team_reb_most.position.length ? summaryModel.away_team_reb_most.position : @""];
}
@end
