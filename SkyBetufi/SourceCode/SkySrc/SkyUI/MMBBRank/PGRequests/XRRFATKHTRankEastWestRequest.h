//
//  XRRFATKHTRankEastWestRequest.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKHTRankEastWestModel.h"

@interface XRRFATKHTRankEastWestRequest : NSObject

+ (void)requestWithSuccessBlock:(void(^)(XRRFATKHTRankEastWestModel *eastWestModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;

@end
