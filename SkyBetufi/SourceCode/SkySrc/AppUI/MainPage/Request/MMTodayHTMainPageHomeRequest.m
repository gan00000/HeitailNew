#import "MMTodayHTMainPageHomeRequest.h"
#import "KMonkeyBJUtility.h"

@interface MMTodayHTMainPageHomeRequest ()
@property (nonatomic, strong) NSMutableArray *newsList;
@property (nonatomic, assign) NSInteger page;
@end
@implementation MMTodayHTMainPageHomeRequest

//    vids 上次浏览过的post_id集合，多个用逗号隔开，如：262957,262937,262604
- (void)taorequestWithVids:(NSString *)vids successBlock:(void(^)(NSArray<PXFunHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    if (!self.newsList) {
        self.newsList = [NSMutableArray array];
    }
    self.page = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = KMonkeyBJUtility.idfa;//设备唯一id(广告id)
    params[@"type"] = @2;
    params[@"vids"] = vids;
    [PXFunBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_POST_RECOMMEND params:params successBlock:^(id responseData) {
        [self.newsList removeAllObjects];
//        if (self.page < [responseData[@"pages"] integerValue]) {
//            self.page ++;
            self.hasMore = YES;
//        } else {
//            self.hasMore = NO;
//        }
        NSArray *list = [NSArray yy_modelArrayWithClass:[PXFunHTNewsModel class] json:responseData[@"result"]];
        if (list) {
            [self.newsList addObjectsFromArray:list];
        }
        if (successBlock) {
            successBlock(self.newsList);
        }
    } errorBlock:errorBlock];
}
- (void)loadNextPageWithVids:(NSString *)vids successBlock:(void(^)(NSArray<PXFunHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sid"] = KMonkeyBJUtility.idfa;//设备唯一id(广告id)
    params[@"type"] = @2;
    params[@"vids"] = vids;
    [PXFunBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_POST_RECOMMEND params:params successBlock:^(id responseData) {
//        if (self.page < [responseData[@"pages"] integerValue]) {
//            self.page ++;
//            self.hasMore = YES;
//        } else {
//            self.hasMore = NO;
//        }
        NSArray *list = [NSArray yy_modelArrayWithClass:[PXFunHTNewsModel class] json:responseData[@"result"]];
        if (list) {
            [self.newsList addObjectsFromArray:list];
        }
        if (successBlock) {
            successBlock(self.newsList);
        }
    } errorBlock:errorBlock];
}
@end
