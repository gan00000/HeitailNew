//
//  UIImageView+HT.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2019/12/12.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "UIImageView+HT.h"
#import "UIImageView+SkyBallHetiRedSVG.h"

@implementation UIImageView (HT)

- (void)th_setImageWithURL:(nullable NSString *)url placeholderImage:(nullable UIImage *)placeholder{
    
    if (!url) {
        return;
    }
       if ([url hasPrefix:@"http"]) {
           [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
           
       }else if ([url hasSuffix:@"svg"]){
           [self svg_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
       }else{//base64
           
           NSData *data = [[NSData alloc] initWithBase64EncodedString:url options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *image = [UIImage imageWithData:data];
           if (image) {
               self.image = image;
            } else {
                self.image = placeholder;
            }
       }
}

@end
