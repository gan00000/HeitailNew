//
//  XRRFATKHTRankZoneRequest.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKHTRankZoneModel.h"

@interface XRRFATKHTRankZoneRequest : NSObject

+ (void)skargrequestWithSuccessBlock:(void(^)(XRRFATKHTRankZoneModel *zoneModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;

@end
