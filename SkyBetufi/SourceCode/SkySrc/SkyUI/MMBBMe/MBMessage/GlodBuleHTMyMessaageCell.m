#import "GlodBuleHTMyMessaageCell.h"
#import "GlodBuleBJDateFormatUtility.h"
@interface GlodBuleHTMyMessaageCell ()
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end
@implementation GlodBuleHTMyMessaageCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)waterSkyrefreshWithMyMessageModel:(GlodBuleHTMyMessageModel *)model {
    self.descLabel.text = model.desc;
    self.contentLabel.text = model.reply_msg;
    self.titleLabel.text = model.post_title;
    self.timeLabel.text = [GlodBuleBJDateFormatUtility dateToShowFromDate:model.date];
}
@end
