#import "HBMatchLiveFeedCell.h"
@interface HBMatchLiveFeedCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@property (weak, nonatomic) IBOutlet UILabel *ptsCompareLabel;
@end
@implementation HBMatchLiveFeedCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setupWithMatchLiveFeedModel:(HBMatchLiveFeedModel *)feedModel {
    self.timeLabel.text = feedModel.time;
    self.teamLabel.text = feedModel.teamName;
    self.eventLabel.text = feedModel.desc;
    self.ptsCompareLabel.text = [NSString stringWithFormat:@"%@ - %@", feedModel.awayPts, feedModel.homePts];
}
@end
