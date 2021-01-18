//
//  GlodBuleSearchRequest.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/9.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlodBuleHTNewsModel.h"
#import "GlodBuleBJBaseHTTPEngine.h"
#import "GlodBuleBJHTTPServiceEngine.h"
NS_ASSUME_NONNULL_BEGIN

@interface GlodBuleSearchRequest : NSObject
@property (nonatomic, assign) BOOL hasMore;

- (void)requestWithKey:(NSString *)key successBlock:(void(^)(NSArray<GlodBuleHTNewsModel *> *newsList))successBlock
           errorBlock:(BJServiceErrorBlock)errorBlock;

- (void)loadNextPageWithSuccessBlock:(void(^)(NSArray<GlodBuleHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;
@end

NS_ASSUME_NONNULL_END
