#import "NSNiceHTFilmHomeRequest.h"
#import "BlysaBJUtility.h"
#import "TuTuosHTUserManager.h"

@interface NSNiceHTFilmHomeRequest ()
@property (nonatomic, strong) NSMutableArray *newsList;
@property (nonatomic, assign) NSInteger page;
@end
@implementation NSNiceHTFilmHomeRequest
- (void)taorequestWithSuccessBlock:(void(^)(NSArray<CfipyHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    if (!self.newsList) {
        self.newsList = [NSMutableArray array];
    }
    self.page = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"json"] = @1;
    params[@"count"] = @20;
    params[@"page"] = @(self.page);
    [NSNiceBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_FILM_HOME params:params successBlock:^(id responseData) {
        [self.newsList removeAllObjects];
        if (self.page < [responseData[@"pages"] integerValue]) {
            self.page ++;
            self.hasMore = YES;
        } else {
            self.hasMore = NO;
        }
        NSArray *list = [NSArray yy_modelArrayWithClass:[CfipyHTNewsModel class] json:responseData[@"posts"]];
        if (list) {
            [self.newsList addObjectsFromArray:list];
        }
        if (successBlock) {
            successBlock(self.newsList);
        }
    } errorBlock:errorBlock];
}
- (void)loadNextPageWithSuccessBlock:(void(^)(NSArray<CfipyHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"json"] = @1;
    params[@"count"] = @20;
    params[@"page"] = @(self.page);
    [NSNiceBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_FILM_HOME params:params successBlock:^(id responseData) {
        if (self.page < [responseData[@"pages"] integerValue]) {
            self.page ++;
            self.hasMore = YES;
        } else {
            self.hasMore = NO;
        }
        NSArray *list = [NSArray yy_modelArrayWithClass:[CfipyHTNewsModel class] json:responseData[@"posts"]];
        if (list) {
            [self.newsList addObjectsFromArray:list];
        }
        if (successBlock) {
            successBlock(self.newsList);
        }
    } errorBlock:errorBlock];
}


- (void)requestRecommonedWithSuccessBlock:(void(^)(NSArray<CfipyHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock
{
    
    if (!self.newsList) {
        self.newsList = [NSMutableArray array];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
   
    params[@"sid"] = BlysaBJUtility.idfa;//设备唯一id(广告id)
    params[@"type"] = @2;
    params[@"token"] = [TuTuosHTUserManager axxptao_userToken];
    params[@"vids"] = @""; //上次浏览过的post_id集合
    
    [NSNiceBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_FILM_HOME_RECOMMONED params:params successBlock:^(id responseData) {
        self.hasMore = YES;
        [self.newsList removeAllObjects];
        NSArray *list = [NSArray yy_modelArrayWithClass:[CfipyHTNewsModel class] json:responseData[@"result"]];
        if (list) {
            [self.newsList addObjectsFromArray:list];
        }
        if (successBlock) {
            successBlock(self.newsList);
        }
    } errorBlock:errorBlock];
}

- (void)loadRecommonedNextPageWithVis:(NSString *)vids SuccessBlock:(void(^)(NSArray<CfipyHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"sid"] = BlysaBJUtility.idfa;//设备唯一id(广告id)
    params[@"type"] = @2;
    params[@"token"] = [TuTuosHTUserManager axxptao_userToken];
    params[@"vids"] = vids; //上次浏览过的post_id集合
    
    [NSNiceBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_FILM_HOME_RECOMMONED params:params successBlock:^(id responseData) {
        NSArray *list = [NSArray yy_modelArrayWithClass:[CfipyHTNewsModel class] json:responseData[@"result"]];
        if (list) {
            [self.newsList addObjectsFromArray:list];
        }
        if (successBlock) {
            successBlock(self.newsList);
        }
    } errorBlock:errorBlock];
}
@end
