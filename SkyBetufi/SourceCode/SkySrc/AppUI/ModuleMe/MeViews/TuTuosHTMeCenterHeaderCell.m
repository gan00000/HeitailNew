#import "TuTuosHTMeCenterHeaderCell.h"
#import "UIImageView+WSKggPXFunHT.h"

@interface TuTuosHTMeCenterHeaderCell ()
@property (weak, nonatomic) IBOutlet UIView *userInfoContentView;
@property (weak, nonatomic) IBOutlet JXImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet JXButton *loginButton;
@end
@implementation TuTuosHTMeCenterHeaderCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)tao_refreshUI {
    if ([NSNiceHTUserManager tao_isUserLogin]) {
        self.userInfoContentView.hidden = NO;
        self.loginButton.hidden = YES;
//        self.avatarImageView.image = [NSNiceHTUserManager tao_userInfo].avatar;
        [self.avatarImageView th_setImageWithURL:[NSNiceHTUserManager tao_userInfo].user_img placeholderImage:HT_DEFAULT_AVATAR_LOGO];
        self.userNameLabel.text = [NSNiceHTUserManager tao_userInfo].display_name;
    } else {
        self.userInfoContentView.hidden = YES;
        self.loginButton.backgroundColor = appBaseColor;
        self.loginButton.hidden = NO;
    }
}
- (IBAction)loginAction:(id)sender {
    [NSNiceHTUserManager tao_doUserLogin];
}
@end
