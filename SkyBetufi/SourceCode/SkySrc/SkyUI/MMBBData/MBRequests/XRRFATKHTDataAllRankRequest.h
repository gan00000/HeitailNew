//
//  XRRFATKHTDataAllRankRequest.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/19.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKHTDataTeamRankModel.h"
#import "XRRFATKHTDataPlayerRankModel.h"

@interface XRRFATKHTDataAllRankRequest : NSObject

+ (void)skargrequestAllTeamRankDataWithType:(NSString *)type
                          successBlock:(void(^)(NSArray<XRRFATKHTDataTeamRankModel *> *allTeamRankList))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock;

+ (void)requestAllPlayerRankDataWithType:(NSString *)type
                            successBlock:(void(^)(NSArray<XRRFATKHTDataPlayerRankModel *> *allPlayerRankList))successBlock
                              errorBlock:(BJServiceErrorBlock)errorBlock;

@end
