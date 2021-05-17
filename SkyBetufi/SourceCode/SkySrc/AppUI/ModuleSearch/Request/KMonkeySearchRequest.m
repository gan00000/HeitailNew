//
//  KMonkeySearchRequest.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/9.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import "KMonkeySearchRequest.h"

@interface KMonkeySearchRequest ()
@property (nonatomic, strong) NSMutableArray *newsList;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSString *xkey;
@end

@implementation KMonkeySearchRequest

- (void)requestWithKey:(NSString *)key successBlock:(void(^)(NSArray<PXFunHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    if (!self.newsList) {
        self.newsList = [NSMutableArray array];
    }
    self.page = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    self.xkey = key;
    params[@"search"] = key;
    params[@"count"] = @20;
    params[@"page"] = @(self.page);
    [PXFunBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_SEARCH params:params successBlock:^(id responseData) {
        [self.newsList removeAllObjects];
        if (self.page < [responseData[@"pages"] integerValue]) {
            self.page ++;
            self.hasMore = YES;
        } else {
            self.hasMore = NO;
        }
        NSArray *list = [NSArray yy_modelArrayWithClass:[PXFunHTNewsModel class] json:responseData[@"posts"]];
        if (list) {
            [self.newsList addObjectsFromArray:list];
        }
        if (successBlock) {
            successBlock(self.newsList);
        }
    } errorBlock:errorBlock];
}
- (void)loadNextPageWithSuccessBlock:(void(^)(NSArray<PXFunHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"search"] = self.xkey;
    params[@"count"] = @20;
    params[@"page"] = @(self.page);
    [PXFunBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_NEWS_HOME params:params successBlock:^(id responseData) {
        if (self.page < [responseData[@"pages"] integerValue]) {
            self.page ++;
            self.hasMore = YES;
        } else {
            self.hasMore = NO;
        }
        NSArray *list = [NSArray yy_modelArrayWithClass:[PXFunHTNewsModel class] json:responseData[@"posts"]];
        if (list) {
            [self.newsList addObjectsFromArray:list];
        }
        if (successBlock) {
            successBlock(self.newsList);
        }
    } errorBlock:errorBlock];
}

//+ (void)requestSearchWithKey:(NSString *)key
//                                  page:(NSInteger)xPage
//               successBlock:(void(^)(NDeskHTLikeTeamModel * m))successBlock
//                 errorBlock:(BJServiceErrorBlock)errorBlock {
//
//    [PXFunBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_SEARCH params:@{@"search":key, @"page": [NSString stringWithFormat:@"%d",xPage], @"count":@20} successBlock:^(id responseData) {
//
//       NDeskHTLikeTeamModel *mHTLikeTeamModel = [NDeskHTLikeTeamModel yy_modelWithJSON: responseData[@"team_like"]];
//       if (successBlock) {
//           successBlock(mHTLikeTeamModel);
//       }
//
//   } errorBlock:errorBlock];
//
//}

@end