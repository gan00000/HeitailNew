#import "SundayHTMyCommentCell.h"
#import "GGCatBJDateFormatUtility.h"
#import "UIImageView+PXFunHT.h"
@interface SundayHTMyCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
@implementation SundayHTMyCommentCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)taosetupWithNewsModel:(PXFunHTNewsModel *)newsModel {
//    self.avatarImageView.image = newsModel.userInfo.avatar;
    [self.avatarImageView th_setImageWithURL:newsModel.userInfo.user_img placeholderImage:HT_DEFAULT_AVATAR_LOGO];
    self.userNameLabel.text = [MMTodayHTUserManager tao_userInfo].display_name;
    self.timeLabel.text = [GGCatBJDateFormatUtility dateToShowFromDate:newsModel.comt_date_obj];
    self.contentLabel.text = newsModel.comment_content;
    self.titleLabel.text = newsModel.title;
}
@end
