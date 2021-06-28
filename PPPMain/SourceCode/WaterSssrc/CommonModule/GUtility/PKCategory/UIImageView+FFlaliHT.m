//
//  UIImageView+FFlaliHT.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2019/12/12.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "UIImageView+FFlaliHT.h"
#import "UIImageView+BlysaSVG.h"

@implementation UIImageView (FFlaliHT)

- (void)th_setImageWithURL:(nullable NSString *)url placeholderImage:(nullable UIImage *)placeholder{
    
    if (!url) {
        return;
    }
       if ([url hasSuffix:@"svg"]) {//[url hasSuffix:@"svg"]
           [self svg_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
           
       }else if ([url hasPrefix:@"http"]){
           [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
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
