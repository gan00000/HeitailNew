#import "KSasxHTMyMessaageCell.h"
#import "BlysaBJDateFormatUtility.h"
@interface KSasxHTMyMessaageCell ()
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end
@implementation KSasxHTMyMessaageCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)taorefreshWithMyMessageModel:(YeYeeHTMyMessageModel *)model {
    self.descLabel.text = model.desc;
    self.contentLabel.text = model.reply_msg;
    self.titleLabel.text = model.post_title;
    self.timeLabel.text = [BlysaBJDateFormatUtility dateToShowFromDate:model.date];
}
@end
