#import "XRRFATKHTMeCenterHeaderCell.h"
@interface XRRFATKHTMeCenterHeaderCell ()
@property (weak, nonatomic) IBOutlet UIView *userInfoContentView;
@property (weak, nonatomic) IBOutlet JXImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet JXButton *loginButton;
@end
@implementation XRRFATKHTMeCenterHeaderCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)skarg_refreshUI {
    if ([XRRFATKHTUserManager skarg_isUserLogin]) {
        self.userInfoContentView.hidden = NO;
        self.loginButton.hidden = YES;
        self.avatarImageView.image = [XRRFATKHTUserManager skarg_userInfo].avatar;
        self.userNameLabel.text = [XRRFATKHTUserManager skarg_userInfo].display_name;
    } else {
        self.userInfoContentView.hidden = YES;
        self.loginButton.hidden = NO;
    }
}
- (IBAction)loginAction:(id)sender {
    [XRRFATKHTUserManager skarg_doUserLogin];
}
@end
