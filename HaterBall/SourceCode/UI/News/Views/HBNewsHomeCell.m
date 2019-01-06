#import "HBNewsHomeCell.h"
@interface HBNewsHomeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewLabel;
@property (weak, nonatomic) IBOutlet UIView *shareButtonContentView;
@property (nonatomic, weak) HBNewsModel *newsModel;
@end
@implementation HBNewsHomeCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([HBNewsModel canShare]) {
        self.shareButtonContentView.hidden = NO;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setupWithNewsModel:(HBNewsModel *)newsModel {
    self.newsModel = newsModel;
    [self.thumbImageView sd_setImageWithURL:[NSURL URLWithString:newsModel.img_url] placeholderImage:HT_DEFAULT_IMAGE];
    self.titleLabel.text = newsModel.title;
    self.timeLabel.text = newsModel.time;
    self.viewLabel.text = newsModel.view_count;
}
- (IBAction)onShareButtonTapped:(id)sender {
    [self.newsModel share];
}
@end
