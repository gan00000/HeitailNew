#import "GlodBuleHTMyCommentCell.h"
#import "GlodBuleBJDateFormatUtility.h"
#import "UIImageView+GlodBuleHT.h"
@interface GlodBuleHTMyCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
@implementation GlodBuleHTMyCommentCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)taosetupWithNewsModel:(GlodBuleHTNewsModel *)newsModel {
//    self.avatarImageView.image = newsModel.userInfo.avatar;
    [self.avatarImageView th_setImageWithURL:newsModel.userInfo.user_img placeholderImage:HT_DEFAULT_AVATAR_LOGO];
    self.userNameLabel.text = [GlodBuleHTUserManager tao_userInfo].display_name;
    self.timeLabel.text = [GlodBuleBJDateFormatUtility dateToShowFromDate:newsModel.comt_date_obj];
    self.contentLabel.text = newsModel.comment_content;
    self.titleLabel.text = newsModel.title;
}
@end