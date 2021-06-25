//
//  TuTuosHTWordLive2Request.h
//  
//
//  Created by ganyuanrong on 2021/3/4.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSNiceBJHTTPServiceEngine.h"
#import "FFlaliHTMatchLiveFeedModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuTuosHTWordLive2Request : NSObject
@property (nonatomic, assign) BOOL hasMore;

- (void)getWordLiveFeedWithGameId:(NSString *)game_id
                            first:(BOOL)isFirst
                     successBlock:(void(^)(NSArray<FFlaliHTMatchLiveFeedModel *> *newsList))successBlock
                             errorBlock:(BJServiceErrorBlock)errorBlock;
@end

NS_ASSUME_NONNULL_END
