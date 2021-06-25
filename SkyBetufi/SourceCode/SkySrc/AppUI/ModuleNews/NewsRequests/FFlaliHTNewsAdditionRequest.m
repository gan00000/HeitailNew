#import "FFlaliHTNewsAdditionRequest.h"
@implementation FFlaliHTNewsAdditionRequest
+ (void)taorequestNormalCommentWithOffset:(NSInteger)offset newsId:(NSString *)newsId successBlock:(void(^)(NSArray <WSKggHTCommentModel *> *commentList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [NSNiceBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_NEWS_COMMENTS params:@{@"offset": @(offset), @"post_id": newsId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *commentsData = responseData[@"result"][@"comments"];
            NSArray<WSKggHTCommentModel *> *comments = [NSArray yy_modelArrayWithClass:[WSKggHTCommentModel class] json:commentsData];
            NSInteger pages = [(NSNumber *)responseData[@"result"][@"pages"] integerValue];
            successBlock(comments, pages);
        }
    } errorBlock:failBlock];
}
+ (void)taorequestHotCommentWithOffset:(NSInteger)offset newsId:(NSString *)newsId successBlock:(void(^)(NSArray <WSKggHTCommentModel *> *commentList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [NSNiceBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_NEWS_HOT_COMMENT params:@{@"offset": @(offset), @"post_id": newsId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *commentsData = responseData[@"result"][@"comments"];
            NSArray<WSKggHTCommentModel *> *comments = [NSArray yy_modelArrayWithClass:[WSKggHTCommentModel class] json:commentsData];
            NSInteger pages = [(NSNumber *)responseData[@"result"][@"pages"] integerValue];
            successBlock(comments, pages);
        }
    } errorBlock:failBlock];
}
+ (void)taorequestAllCommentWithPostId:(NSString *)postId
                       successBlock:(void(^)(NSArray <WSKggHTCommentModel *> *commentList, NSArray<WSKggHTCommentModel *> *hotComments))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock {
    [NSNiceBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_NEWS_ALL_COMMENT params:@{@"post_id": postId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *comments = [NSArray yy_modelArrayWithClass:[WSKggHTCommentModel class] json:responseData[@"get_comments"][@"result"][@"comments"]];
            NSArray *hotComments = [NSArray yy_modelArrayWithClass:[WSKggHTCommentModel class] json:responseData[@"get_hot_comments"][@"result"][@"comments"]];
            successBlock(comments, hotComments);
        }
    } errorBlock:failBlock];
}
+ (void)taorequestDetailWithPostId:(NSString *)post_id
                   successBlock:(void(^)(CfipyHTNewsModel *newsModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [NSNiceBJHTTPServiceEngine tao_postRequestWithFunctionPath:API_NEWS_DETAIL params:@{@"post_id": post_id} successBlock:^(id responseData) {
        if (successBlock) {
            
            NSArray *xxHTNewsDetailModels = [NSArray yy_modelArrayWithClass:[CfipyHTNewsDetailModel class] json:responseData[@"post"][@"new_content"]];
            NSMutableArray *maData = [NSMutableArray array];
            
            for (CfipyHTNewsDetailModel * d in xxHTNewsDetailModels) {
                if ([d.type isEqualToString:@"text"] && [d.data hasPrefix:@"<a"] && [d.data hasSuffix:@"></a>"]) {
                    
                }else{
                    [maData addObject:d];
                }
            }
            
            CfipyHTNewsModel *mHTNewsModel = [CfipyHTNewsModel yy_modelWithJSON:responseData[@"post"]];

            mHTNewsModel.mHTNewsDetailModels = maData;
            successBlock(mHTNewsModel);
        }
    } errorBlock:errorBlock];
}
@end
