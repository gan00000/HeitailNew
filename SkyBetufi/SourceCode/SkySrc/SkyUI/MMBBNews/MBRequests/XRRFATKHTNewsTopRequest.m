//
//  XRRFATKHTNewsTopRequest.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKHTNewsTopRequest.h"

@implementation XRRFATKHTNewsTopRequest

+ (void)skargrequestWithSuccessBlock:(void(^)(NSArray<XRRFATKHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [XRRFATKBJHTTPServiceEngine getRequestWithFunctionPath:API_NEWS_TOP params:nil successBlock:^(id responseData) {
        NSArray *newsList = [NSArray yy_modelArrayWithClass:[XRRFATKHTNewsModel class] json:responseData[@"posts"]];
        if (successBlock) {
            successBlock(newsList);
        }
    } errorBlock:errorBlock];
}

@end
