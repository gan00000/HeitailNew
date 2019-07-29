//
//  XRRFATKHTRankEastWestRequest.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKHTRankEastWestRequest.h"

@implementation XRRFATKHTRankEastWestRequest

+ (void)skargrequestWithSuccessBlock:(void(^)(XRRFATKHTRankEastWestModel *eastWestModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [XRRFATKBJHTTPServiceEngine getRequestWithFunctionPath:API_RANK_EAST_WEST params:nil successBlock:^(id responseData) {
        XRRFATKHTRankEastWestModel *eastWestModel = [XRRFATKHTRankEastWestModel yy_modelWithJSON:responseData];
        if (successBlock) {
            successBlock(eastWestModel);
        }
    } errorBlock:errorBlock];
}

@end
