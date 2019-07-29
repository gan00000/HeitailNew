//
//  XRRFATKHTMatchHomeRequest.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKHTMatchHomeGroupModel.h"

@interface XRRFATKHTMatchHomeRequest : NSObject

+ (void)skargrequestWithStartDate:(NSString *)startDate
                     endDate:(NSString *)endDate
                successBlock:(void(^)(NSArray<XRRFATKHTMatchHomeGroupModel *> *matchList))successBlock
                  errorBlock:(BJServiceErrorBlock)errorBlock;

+ (void)skargrequestMatchProgressWithGameId:(NSString *)game_id
                          successBlock:(void(^)(NSString *game_id, NSString *quarter, NSString *time))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock;

@end
