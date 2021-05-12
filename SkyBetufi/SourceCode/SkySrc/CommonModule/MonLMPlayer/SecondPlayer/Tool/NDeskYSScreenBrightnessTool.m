//
//  NDeskYSScreenBrightnessTool.m
//  ijkplayerDemo
//
//  Created by 张延深 on 2020/4/16.
//  Copyright © 2020 张延深. All rights reserved.
//

#import "NDeskYSScreenBrightnessTool.h"

@implementation NDeskYSScreenBrightnessTool

+ (void)changeBrightness:(CGFloat)brightness {
    if (brightness > 1.0) {
        brightness = 1.0;
    }
    if (brightness < 0.0) {
        brightness = 0.0;
    }
    [UIScreen mainScreen].brightness = brightness;
}

+ (CGFloat)getBrightness {
    return [UIScreen mainScreen].brightness;
}

@end
