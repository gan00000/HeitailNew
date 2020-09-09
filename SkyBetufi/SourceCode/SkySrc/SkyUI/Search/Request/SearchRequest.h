//
//  SearchRequest.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/9.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SkyBallHetiRedHTNewsModel.h"
#import "SkyBallHetiRedBJBaseHTTPEngine.h"
#import "SkyBallHetiRedBJHTTPServiceEngine.h"
NS_ASSUME_NONNULL_BEGIN

@interface SearchRequest : NSObject
@property (nonatomic, assign) BOOL hasMore;

- (void)requestWithKey:(NSString *)key successBlock:(void(^)(NSArray<SkyBallHetiRedHTNewsModel *> *newsList))successBlock
           errorBlock:(BJServiceErrorBlock)errorBlock;

- (void)loadNextPageWithSuccessBlock:(void(^)(NSArray<SkyBallHetiRedHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;
@end

NS_ASSUME_NONNULL_END
