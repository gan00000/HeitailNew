//
//  KMonkeySearchRequest.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/9.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXFunHTNewsModel.h"
#import "SundayBJBaseHTTPEngine.h"
#import "PXFunBJHTTPServiceEngine.h"
NS_ASSUME_NONNULL_BEGIN

@interface KMonkeySearchRequest : NSObject
@property (nonatomic, assign) BOOL hasMore;

- (void)requestWithKey:(NSString *)key successBlock:(void(^)(NSArray<PXFunHTNewsModel *> *newsList))successBlock
           errorBlock:(BJServiceErrorBlock)errorBlock;

- (void)loadNextPageWithSuccessBlock:(void(^)(NSArray<PXFunHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;
@end

NS_ASSUME_NONNULL_END
