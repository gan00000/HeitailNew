#import "GlodBuleHTNewsHomeRequest.h"
@interface GlodBuleHTNewsHomeRequest ()
@property (nonatomic, strong) NSMutableArray *newsList;
@property (nonatomic, assign) NSInteger page;
@end
@implementation GlodBuleHTNewsHomeRequest
- (void)taorequestWithSuccessBlock:(void(^)(NSArray<GlodBuleHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    if (!self.newsList) {
        self.newsList = [NSMutableArray array];
    }
    self.page = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"json"] = @1;
    params[@"count"] = @20;
    params[@"page"] = @(self.page);
    [GlodBuleBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_NEWS_HOME params:params successBlock:^(id responseData) {
        [self.newsList removeAllObjects];
        if (self.page < [responseData[@"pages"] integerValue]) {
            self.page ++;
            self.hasMore = YES;
        } else {
            self.hasMore = NO;
        }
        NSArray *list = [NSArray yy_modelArrayWithClass:[GlodBuleHTNewsModel class] json:responseData[@"posts"]];
        if (list) {
            [self.newsList addObjectsFromArray:list];
        }
        if (successBlock) {
            successBlock(self.newsList);
        }
    } errorBlock:errorBlock];
}
- (void)taoloadNextPageWithSuccessBlock:(void(^)(NSArray<GlodBuleHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"json"] = @1;
    params[@"count"] = @20;
    params[@"page"] = @(self.page);
    [GlodBuleBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_NEWS_HOME params:params successBlock:^(id responseData) {
        if (self.page < [responseData[@"pages"] integerValue]) {
            self.page ++;
            self.hasMore = YES;
        } else {
            self.hasMore = NO;
        }
        NSArray *list = [NSArray yy_modelArrayWithClass:[GlodBuleHTNewsModel class] json:responseData[@"posts"]];
        if (list) {
            [self.newsList addObjectsFromArray:list];
        }
        if (successBlock) {
            successBlock(self.newsList);
        }
    } errorBlock:errorBlock];
}

+(void)taorequestHighLightWithGameId:(NSString *)gameId successBlock:(void(^)(NSArray<GlodBuleHTNewsModel *> *newsList))successBlock
                         errorBlock:(BJServiceErrorBlock)errorBlock {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"game_id"] = gameId;
    [GlodBuleBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_MATCH_GET_highlights params:params successBlock:^(id responseData) {
        
//        if (self.page < [responseData[@"pages"] integerValue]) {
//            self.page ++;
//            self.hasMore = YES;
//        } else {
//            self.hasMore = NO;
//        }
        NSArray *list = [NSArray yy_modelArrayWithClass:[GlodBuleHTNewsModel class] json:responseData[@"posts"]];
//        if (list) {
//            [self.newsList addObjectsFromArray:list];
//        }
        if (successBlock) {
            successBlock(list);
        }
    } errorBlock:errorBlock];
}
@end
