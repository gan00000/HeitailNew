#import "SkyBallHetiRedHTUserInfoModel.h"
@implementation SkyBallHetiRedHTUserInfoModel
- (UIImage *)avatar {
    if (!_avatar) {
        NSData *data = [[NSData alloc] initWithBase64EncodedString:self.user_img options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *image = [UIImage imageWithData:data];
        if (image) {
            _avatar = image;
        } else {
            _avatar = [UIImage imageNamed:@"default_avatar"];
        }
    }
    return _avatar;
}
@end
