//
//  XRRFATKHTUserInfoModel.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/3/31.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "XRRFATKHTUserInfoModel.h"

@implementation XRRFATKHTUserInfoModel

- (UIImage *)avatar {
    if (!_avatar) {
//        NSURL *url = [NSURL URLWithString:self.user_img];
//        NSData *data = [NSData dataWithContentsOfURL:url];
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
