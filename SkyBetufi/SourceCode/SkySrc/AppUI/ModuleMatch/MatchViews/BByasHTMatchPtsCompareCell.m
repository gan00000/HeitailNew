#import "BByasHTMatchPtsCompareCell.h"
@interface BByasHTMatchPtsCompareCell ()
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

@property (weak, nonatomic) IBOutlet YeYeeHTCompareView *ptsCompareView;
@property (weak, nonatomic) IBOutlet YeYeeHTCompareView *rebCompareView;
@property (weak, nonatomic) IBOutlet YeYeeHTCompareView *astCompareView;
@property (weak, nonatomic) IBOutlet YeYeeHTCompareView *blkCompareView;
@property (weak, nonatomic) IBOutlet YeYeeHTCompareView *stlCompareView;
@property (weak, nonatomic) IBOutlet YeYeeHTCompareView *fgmadeCompareView;

@property (weak, nonatomic) IBOutlet YeYeeHTCompareView *fg3madeCompareView;
@property (weak, nonatomic) IBOutlet YeYeeHTCompareView *ftCompareView;

@end
@implementation BByasHTMatchPtsCompareCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)taosetupWithMatchSummaryModel:(NSNiceHTMatchSummaryModel *)summaryModel {
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
    
    [self.ptsCompareView updateWithLeftValue:[summaryModel.away_pts intValue] rightValue:[summaryModel.home_pts intValue]];
    
    [self.rebCompareView updateWithLeftValue:[summaryModel.away_team_reb intValue] rightValue:[summaryModel.home_team_reb intValue]];
    
    [self.astCompareView updateWithLeftValue:[summaryModel.away_team_ast intValue] rightValue:[summaryModel.home_team_ast intValue]];
    
    [self.blkCompareView updateWithLeftValue:[summaryModel.away_team_blk intValue] rightValue:[summaryModel.home_team_blk intValue]];
    
    [self.stlCompareView updateWithLeftValue:[summaryModel.away_team_stl intValue] rightValue:[summaryModel.home_team_stl intValue]];
    
    [self.fgmadeCompareView updateWithLeftPercent:[[summaryModel.away_team_fgmade stringByReplacingOccurrencesOfString:@"%" withString:@""] intValue] / 100.0 rightPercent:[summaryModel.home_team_fgmade intValue] / 100.0];
    
    [self.fg3madeCompareView updateWithLeftPercent:[[summaryModel.away_team_fg3ptmade stringByReplacingOccurrencesOfString:@"%" withString:@""] intValue] / 100.0 rightPercent:[summaryModel.home_team_fg3ptmade intValue] / 100.0];
    
    [self.ftCompareView updateWithLeftPercent:[[summaryModel.away_team_ftmade stringByReplacingOccurrencesOfString:@"%" withString:@""] intValue] / 100.0 rightPercent:[summaryModel.home_team_ftmade intValue] / 100.0];
}
@end
