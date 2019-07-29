//
//  XRRFATKHTMatchSummaryRequest.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/22.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKHTMatchSummaryModel.h"
#import "XRRFATKHTMatchCompareModel.h"

@interface XRRFATKHTMatchSummaryRequest : NSObject

+ (void)skargrequestSummaryWithGameId:(NSString *)game_id
                    successBlock:(void(^)(XRRFATKHTMatchSummaryModel *summaryModel, XRRFATKHTMatchCompareModel *compareModel))successBlock
                      errorBlock:(BJServiceErrorBlock)errorBlock;

@end
