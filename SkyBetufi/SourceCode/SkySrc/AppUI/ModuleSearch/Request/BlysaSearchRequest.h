//
//  BlysaSearchRequest.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/9.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UUaksHTNewsModel.h"
#import "TuTuosBJBaseHTTPEngine.h"
#import "BlysaBJHTTPServiceEngine.h"
NS_ASSUME_NONNULL_BEGIN

@interface BlysaSearchRequest : NSObject
@property (nonatomic, assign) BOOL hasMore;

- (void)requestWithKey:(NSString *)key successBlock:(void(^)(NSArray<UUaksHTNewsModel *> *newsList))successBlock
           errorBlock:(BJServiceErrorBlock)errorBlock;

- (void)loadNextPageWithSuccessBlock:(void(^)(NSArray<UUaksHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;
@end

NS_ASSUME_NONNULL_END
