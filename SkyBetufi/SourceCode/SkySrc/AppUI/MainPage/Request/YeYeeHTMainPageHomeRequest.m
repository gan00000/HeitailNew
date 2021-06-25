#import "YeYeeHTMainPageHomeRequest.h"
#import "UUaksBJUtility.h"

@interface YeYeeHTMainPageHomeRequest ()
@property (nonatomic, strong) NSMutableArray *newsList;
@property (nonatomic, assign) NSInteger page;
@end
@implementation YeYeeHTMainPageHomeRequest

//    vids 上次浏览过的post_id集合，多个用逗号隔开，如：262957,262937,262604
- (void)taorequestWithVids:(NSString *)vids successBlock:(void(^)(NSArray<UUaksHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    if (!self.newsList) {
        self.newsList = [NSMutableArray array];
    }
    self.page = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = UUaksBJUtility.idfa;//设备唯一id(广告id)
    params[@"type"] = @2;
    params[@"vids"] = vids;
    [BlysaBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_POST_RECOMMEND params:params successBlock:^(id responseData) {
        [self.newsList removeAllObjects];
//        if (self.page < [responseData[@"pages"] integerValue]) {
//            self.page ++;
            self.hasMore = YES;
//        } else {
//            self.hasMore = NO;
//        }
        NSArray *list = [NSArray yy_modelArrayWithClass:[UUaksHTNewsModel class] json:responseData[@"result"]];
        if (list) {
            [self.newsList addObjectsFromArray:list];
        }
        if (successBlock) {
            successBlock(self.newsList);
        }
    } errorBlock:errorBlock];
}
- (void)loadNextPageWithVids:(NSString *)vids successBlock:(void(^)(NSArray<UUaksHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = UUaksBJUtility.idfa;//设备唯一id(广告id)
    params[@"type"] = @2;
    params[@"vids"] = vids;
    [BlysaBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_POST_RECOMMEND params:params successBlock:^(id responseData) {
//        if (self.page < [responseData[@"pages"] integerValue]) {
//            self.page ++;
//            self.hasMore = YES;
//        } else {
//            self.hasMore = NO;
//        }
        NSArray *list = [NSArray yy_modelArrayWithClass:[UUaksHTNewsModel class] json:responseData[@"result"]];
        if (list) {
            [self.newsList addObjectsFromArray:list];
        }
        if (successBlock) {
            successBlock(self.newsList);
        }
    } errorBlock:errorBlock];
}
@end
