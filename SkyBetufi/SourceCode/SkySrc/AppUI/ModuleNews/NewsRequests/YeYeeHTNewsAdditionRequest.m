#import "YeYeeHTNewsAdditionRequest.h"
@implementation YeYeeHTNewsAdditionRequest
+ (void)taorequestNormalCommentWithOffset:(NSInteger)offset newsId:(NSString *)newsId successBlock:(void(^)(NSArray <NSNiceHTCommentModel *> *commentList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [BlysaBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_NEWS_COMMENTS params:@{@"offset": @(offset), @"post_id": newsId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *commentsData = responseData[@"result"][@"comments"];
            NSArray<NSNiceHTCommentModel *> *comments = [NSArray yy_modelArrayWithClass:[NSNiceHTCommentModel class] json:commentsData];
            NSInteger pages = [(NSNumber *)responseData[@"result"][@"pages"] integerValue];
            successBlock(comments, pages);
        }
    } errorBlock:failBlock];
}
+ (void)taorequestHotCommentWithOffset:(NSInteger)offset newsId:(NSString *)newsId successBlock:(void(^)(NSArray <NSNiceHTCommentModel *> *commentList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [BlysaBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_NEWS_HOT_COMMENT params:@{@"offset": @(offset), @"post_id": newsId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *commentsData = responseData[@"result"][@"comments"];
            NSArray<NSNiceHTCommentModel *> *comments = [NSArray yy_modelArrayWithClass:[NSNiceHTCommentModel class] json:commentsData];
            NSInteger pages = [(NSNumber *)responseData[@"result"][@"pages"] integerValue];
            successBlock(comments, pages);
        }
    } errorBlock:failBlock];
}
+ (void)taorequestAllCommentWithPostId:(NSString *)postId
                       successBlock:(void(^)(NSArray <NSNiceHTCommentModel *> *commentList, NSArray<NSNiceHTCommentModel *> *hotComments))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock {
    [BlysaBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_NEWS_ALL_COMMENT params:@{@"post_id": postId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *comments = [NSArray yy_modelArrayWithClass:[NSNiceHTCommentModel class] json:responseData[@"get_comments"][@"result"][@"comments"]];
            NSArray *hotComments = [NSArray yy_modelArrayWithClass:[NSNiceHTCommentModel class] json:responseData[@"get_hot_comments"][@"result"][@"comments"]];
            successBlock(comments, hotComments);
        }
    } errorBlock:failBlock];
}
+ (void)taorequestDetailWithPostId:(NSString *)post_id
                   successBlock:(void(^)(UUaksHTNewsModel *newsModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [BlysaBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_NEWS_DETAIL params:@{@"post_id": post_id} successBlock:^(id responseData) {
        if (successBlock) {
            
            NSArray *xxHTNewsDetailModels = [NSArray yy_modelArrayWithClass:[FFlaliHTNewsDetailModel class] json:responseData[@"post"][@"new_content"]];
            NSMutableArray *maData = [NSMutableArray array];
            
            for (FFlaliHTNewsDetailModel * d in xxHTNewsDetailModels) {
                if ([d.type isEqualToString:@"text"] && [d.data hasPrefix:@"<a"] && [d.data hasSuffix:@"></a>"]) {
                    
                }else{
                    [maData addObject:d];
                }
            }
            
            UUaksHTNewsModel *mHTNewsModel = [UUaksHTNewsModel yy_modelWithJSON:responseData[@"post"]];

            mHTNewsModel.mHTNewsDetailModels = maData;
            successBlock(mHTNewsModel);
        }
    } errorBlock:errorBlock];
}
@end
