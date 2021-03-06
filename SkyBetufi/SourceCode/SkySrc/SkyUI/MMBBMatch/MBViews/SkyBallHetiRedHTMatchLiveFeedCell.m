#import "SkyBallHetiRedHTMatchLiveFeedCell.h"
#import "UIImageView+HT.h"
@interface SkyBallHetiRedHTMatchLiveFeedCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@property (weak, nonatomic) IBOutlet UILabel *ptsCompareLabel;
@property (weak, nonatomic) IBOutlet UIImageView *teamImageView;


@end
@implementation SkyBallHetiRedHTMatchLiveFeedCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)waterSkysetupWithMatchLiveFeedModel:(SkyBallHetiRedHTMatchLiveFeedModel *)feedModel summary:(SkyBallHetiRedHTMatchSummaryModel *)summaryModel {
    
    self.teamLabel.hidden = YES;
    if (feedModel.tagSrore == 1) {
        self.timeLabel.font = [UIFont boldSystemFontOfSize:12];
        self.teamLabel.font = [UIFont boldSystemFontOfSize:12];
        self.eventLabel.font = [UIFont boldSystemFontOfSize:12];
        self.ptsCompareLabel.font = [UIFont boldSystemFontOfSize:12];
    }else{
        self.timeLabel.font = [UIFont systemFontOfSize:12];
       self.teamLabel.font = [UIFont systemFontOfSize:12];
       self.eventLabel.font = [UIFont systemFontOfSize:12];
       self.ptsCompareLabel.font = [UIFont systemFontOfSize:12];
    }
    if ([feedModel.teamName isEqualToString:summaryModel.homeName]) {
         [self.teamImageView th_setImageWithURL:summaryModel.homeLogo placeholderImage:nil];
    } else {
         [self.teamImageView th_setImageWithURL:summaryModel.awayLogo placeholderImage:nil];
    }
   
    self.timeLabel.text = feedModel.time;
    self.teamLabel.text = feedModel.teamName;
    self.eventLabel.text = feedModel.desc;
    self.ptsCompareLabel.text = [NSString stringWithFormat:@"%@ - %@", feedModel.awayPts, feedModel.homePts];
}
@end
