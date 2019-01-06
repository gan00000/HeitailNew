#import "HBMatchQuarterCell.h"
@interface HBMatchQuarterCell ()
@property (weak, nonatomic) IBOutlet UIView *quarterItemContentView;
@property (weak, nonatomic) IBOutlet UIView *homeQuarterPtsContentView;
@property (weak, nonatomic) IBOutlet UIView *awayQuarterPtsContentView;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *homePtsLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayPtsLabel;
@property (nonatomic, strong) NSMutableArray *labels;
@end
@implementation HBMatchQuarterCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setupWithMatchSummaryModel:(HBMatchSummaryModel *)summaryModel {
    self.homeTeamLabel.text = summaryModel.homeName;
    self.homePtsLabel.text = summaryModel.home_pts;
    self.awayTeamLabel.text = summaryModel.awayName;
    self.awayPtsLabel.text = summaryModel.away_pts;
    for (UILabel *label in self.quarterItemContentView.subviews) {
        [label removeFromSuperview];
    }
    for (UILabel *label in self.homeQuarterPtsContentView.subviews) {
        [label removeFromSuperview];
    }
    for (UILabel *label in self.awayQuarterPtsContentView.subviews) {
        [label removeFromSuperview];
    }
    NSArray *h = [summaryModel.home_quarter_scores componentsSeparatedByString:@","];
    NSArray *a = [summaryModel.away_quarter_scores componentsSeparatedByString:@","];
    NSInteger index = 0;
    CGFloat width = (SCREEN_WIDTH - 130) / h.count;
    for (; index <h.count; index++) {
        UILabel *label = [self getLabelAtIndex:index quarterCount:h.count labelWidth:width];
        if (index < 4) {
            label.text = [NSString stringWithFormat:@"Q%ld", index + 1];
        } else {
            label.text = [NSString stringWithFormat:@"OT%ld", index % 4 + 1];
        }
        [self.quarterItemContentView addSubview:label];
    }
    for (NSString *pts in h) {
        UILabel *label = [self getLabelAtIndex:index quarterCount:h.count labelWidth:width];
        label.text = pts;
        [self.homeQuarterPtsContentView addSubview:label];
        index++;
    }
    for (NSString *pts in a) {
        UILabel *label = [self getLabelAtIndex:index quarterCount:h.count labelWidth:width];
        label.text = pts;
        [self.awayQuarterPtsContentView addSubview:label];
        index++;
    }
}
- (UILabel *)getLabelAtIndex:(NSInteger)index quarterCount:(NSInteger)count labelWidth:(CGFloat)width {
    UILabel *label;
    if (self.labels.count > index) {
        label = self.labels[index];
    } else {
        label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        [self.labels addObject:label];
    }
    label.frame = CGRectMake(index % count * width, 0, width, 35);
    return label;
}
- (NSMutableArray *)labels {
    if (!_labels) {
        _labels = [NSMutableArray array];
    }
    return _labels;
}
@end
