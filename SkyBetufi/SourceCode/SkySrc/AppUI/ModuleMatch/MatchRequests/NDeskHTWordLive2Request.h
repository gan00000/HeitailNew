//
//  NDeskHTWordLive2Request.h
//  XXXHeiTai
//
//  Created by ganyuanrong on 2021/3/4.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXFunBJHTTPServiceEngine.h"
#import "SundayHTMatchLiveFeedModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NDeskHTWordLive2Request : NSObject
@property (nonatomic, assign) BOOL hasMore;

- (void)getWordLiveFeedWithGameId:(NSString *)game_id
                            first:(BOOL)isFirst
                     successBlock:(void(^)(NSArray<SundayHTMatchLiveFeedModel *> *newsList))successBlock
                             errorBlock:(BJServiceErrorBlock)errorBlock;
@end

NS_ASSUME_NONNULL_END
