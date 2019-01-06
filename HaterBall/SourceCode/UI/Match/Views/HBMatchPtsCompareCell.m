#import "HBMatchPtsCompareCell.h"
@interface HBMatchPtsCompareCell ()
@property (weak, nonatomic) IBOutlet UILabel *homePtsLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeRebLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeAstLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeBlkLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeStlLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeFgmadeLabel;
@property (weak, nonatomic) IBOutlet UILabel *home3FgmadeLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeFtmadeLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayPtsLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayRebLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayAstLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayBlkLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayStlLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayFgmadeLabel;
@property (weak, nonatomic) IBOutlet UILabel *away3FgmadeLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayFtmadeLabel;
@end
@implementation HBMatchPtsCompareCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setupWithMatchSummaryModel:(HBMatchSummaryModel *)summaryModel {
    self.homePtsLabel.text = summaryModel.home_pts;
    self.homeRebLabel.text = summaryModel.home_team_reb;
    self.homeAstLabel.text = summaryModel.home_team_ast;
    self.homeBlkLabel.text = summaryModel.home_team_blk;
    self.homeStlLabel.text = summaryModel.home_team_stl;
    self.homeFgmadeLabel.text = summaryModel.home_team_fgmade;
    self.home3FgmadeLabel.text = summaryModel.home_team_fg3ptmade;
    self.homeFtmadeLabel.text = summaryModel.home_team_ftmade;
    self.awayPtsLabel.text = summaryModel.away_pts;
    self.awayRebLabel.text = summaryModel.away_team_reb;
    self.awayAstLabel.text = summaryModel.away_team_ast;
    self.awayBlkLabel.text = summaryModel.away_team_blk;
    self.awayStlLabel.text = summaryModel.away_team_stl;
    self.awayFgmadeLabel.text = summaryModel.away_team_fgmade;
    self.away3FgmadeLabel.text = summaryModel.away_team_fg3ptmade;
    self.awayFtmadeLabel.text = summaryModel.away_team_ftmade;
}
@end
