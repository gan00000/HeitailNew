//
//  XRRFATKHTNewsBannerRequest.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKHTNewsBannerRequest.h"

@implementation XRRFATKHTNewsBannerRequest

+ (void)skargrequestWithSuccessBlock:(void(^)(NSArray<XRRFATKHTNewsModel*> *bannerList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    
    [XRRFATKBJHTTPServiceEngine getRequestWithFunctionPath:API_NEWS_BANNER params:nil successBlock:^(id responseData) {
        NSArray *arr = [NSArray yy_modelArrayWithClass:[XRRFATKHTNewsModel class] json:responseData[@"topslideposts"][@"posts"]];
        if (successBlock) {
            successBlock(arr);
        }
    } errorBlock:errorBlock];
}

@end
