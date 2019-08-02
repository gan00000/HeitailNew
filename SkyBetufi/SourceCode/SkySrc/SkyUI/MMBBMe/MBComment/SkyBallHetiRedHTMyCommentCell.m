#import "SkyBallHetiRedHTMyCommentCell.h"
#import "SkyBallHetiRedBJDateFormatUtility.h"
@interface SkyBallHetiRedHTMyCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
@implementation SkyBallHetiRedHTMyCommentCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)waterSkysetupWithNewsModel:(SkyBallHetiRedHTNewsModel *)newsModel {
    self.avatarImageView.image = newsModel.userInfo.avatar;
    self.userNameLabel.text = [SkyBallHetiRedHTUserManager waterSky_userInfo].display_name;
    self.timeLabel.text = [SkyBallHetiRedBJDateFormatUtility dateToShowFromDate:newsModel.comt_date_obj];
    self.contentLabel.text = newsModel.comment_content;
    self.titleLabel.text = newsModel.title;
}
@end
