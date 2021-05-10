#import "GlodBuleHTUserInfoModel.h"
@implementation GlodBuleHTUserInfoModel
- (UIImage *)avatar {
    if (!_avatar) {
        NSData *data;
        if ([self.user_img hasPrefix:@"http"]) {
            data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.user_img]];
        }else{
            data = [[NSData alloc] initWithBase64EncodedString:self.user_img options:NSDataBase64DecodingIgnoreUnknownCharacters];
        }
        UIImage *image = [UIImage imageWithData:data];
        if (image) {
            _avatar = image;
        } else {
            _avatar = HT_DEFAULT_AVATAR_LOGO;
        }
    }
    return _avatar;
}
@end
