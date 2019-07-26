//
//  XRRFATKHTNewsBannerRequest.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKHTNewsModel.h"

@interface XRRFATKHTNewsBannerRequest : NSObject

+ (void)requestWithSuccessBlock:(void(^)(NSArray<XRRFATKHTNewsModel*> *bannerList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;

@end
