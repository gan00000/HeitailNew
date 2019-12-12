#import "SkyBallHetiRedHTMeCenterHeaderCell.h"
#import "UIImageView+HT.h"

@interface SkyBallHetiRedHTMeCenterHeaderCell ()
@property (weak, nonatomic) IBOutlet UIView *userInfoContentView;
@property (weak, nonatomic) IBOutlet JXImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet JXButton *loginButton;
@end
@implementation SkyBallHetiRedHTMeCenterHeaderCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)waterSky_refreshUI {
    if ([SkyBallHetiRedHTUserManager waterSky_isUserLogin]) {
        self.userInfoContentView.hidden = NO;
        self.loginButton.hidden = YES;
//        self.avatarImageView.image = [SkyBallHetiRedHTUserManager waterSky_userInfo].avatar;
        [self.avatarImageView th_setImageWithURL:[SkyBallHetiRedHTUserManager waterSky_userInfo].user_img placeholderImage:HT_DEFAULT_AVATAR_LOGO];
        self.userNameLabel.text = [SkyBallHetiRedHTUserManager waterSky_userInfo].display_name;
    } else {
        self.userInfoContentView.hidden = YES;
        self.loginButton.hidden = NO;
    }
}
- (IBAction)loginAction:(id)sender {
    [SkyBallHetiRedHTUserManager waterSky_doUserLogin];
}
@end
