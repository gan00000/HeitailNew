//
//  XRRFATKHTMatchLiveFeedRequest.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/22.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKHTMatchLiveFeedModel.h"

@interface XRRFATKHTMatchLiveFeedRequest : NSObject

+ (void)skargrequestLiveFeedWithGameId:(NSString *)game_id
                     successBlock:(void(^)(NSArray<XRRFATKHTMatchLiveFeedModel *> *feedList))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock;

@end
