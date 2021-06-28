#import "CfipyHTMeCenterNormalCell.h"
@interface CfipyHTMeCenterNormalCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet JXView *messageCountContent;
@property (weak, nonatomic) IBOutlet UILabel *messageCountLabel;
@end
@implementation CfipyHTMeCenterNormalCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}
- (void)setMessageCount:(NSInteger)messageCount {
    self.messageCountContent.hidden = YES;
    if (messageCount) {
        self.messageCountContent.hidden = NO;
        self.messageCountLabel.text = [NSString stringWithFormat:@"%ld", messageCount];
    }
}
@end
