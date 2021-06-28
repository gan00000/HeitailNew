#import "UUaksHTMeCenterHeaderCell.h"
#import "UIImageView+FFlaliHT.h"

@interface UUaksHTMeCenterHeaderCell ()
@property (weak, nonatomic) IBOutlet UIView *userInfoContentView;
@property (weak, nonatomic) IBOutlet JXImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet JXButton *loginButton;
@end
@implementation UUaksHTMeCenterHeaderCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)tao_refreshUI {
    if ([TuTuosHTUserManager tao_isUserLogin]) {
        self.userInfoContentView.hidden = NO;
        self.loginButton.hidden = YES;
//        self.avatarImageView.image = [TuTuosHTUserManager tao_userInfo].avatar;
        [self.avatarImageView th_setImageWithURL:[TuTuosHTUserManager tao_userInfo].user_img placeholderImage:HT_DEFAULT_AVATAR_LOGO];
        self.userNameLabel.text = [TuTuosHTUserManager tao_userInfo].display_name;
    } else {
        self.userInfoContentView.hidden = YES;
        self.loginButton.backgroundColor = appBaseColor;
        self.loginButton.hidden = NO;
    }
}
- (IBAction)loginAction:(id)sender {
    [TuTuosHTUserManager tao_doUserLogin];
}
@end
