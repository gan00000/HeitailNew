//
//  XRRFATKHTRankZoneRequest.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKHTRankZoneRequest.h"

@implementation XRRFATKHTRankZoneRequest

+ (void)skargrequestWithSuccessBlock:(void(^)(XRRFATKHTRankZoneModel *zoneModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [XRRFATKBJHTTPServiceEngine getRequestWithFunctionPath:API_RANK_ZONE params:nil successBlock:^(id responseData) {
        if (successBlock) {
            XRRFATKHTRankZoneModel *zoneModel = [XRRFATKHTRankZoneModel yy_modelWithJSON:responseData];
            successBlock(zoneModel);
        }
    } errorBlock:errorBlock];
}

@end
