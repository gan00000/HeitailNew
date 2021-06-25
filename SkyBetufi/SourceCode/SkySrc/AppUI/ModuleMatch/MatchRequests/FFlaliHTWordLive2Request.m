//
//  FFlaliHTWordLive2Request.m
//  
//
//  Created by ganyuanrong on 2021/3/4.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import "FFlaliHTWordLive2Request.h"

@interface FFlaliHTWordLive2Request ()
@property (nonatomic, strong) NSMutableArray *wordLiveList;
@property (nonatomic, assign) NSInteger page;
@end
@implementation FFlaliHTWordLive2Request

- (void)getWordLiveFeedWithGameId:(NSString *)game_id
                          first:(BOOL)isFirst
                     successBlock:(void(^)(NSArray<UUaksHTMatchLiveFeedModel *> *newsList))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock{
    if (!self.wordLiveList) {
        self.wordLiveList = [NSMutableArray array];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"game_id"] = game_id;
    params[@"count"] = @20;
    if (isFirst) {
        params[@"page"] = @1;//当前页，默认1
        self.hasMore = NO;
        self.page = 1;
        
    }else{
        params[@"page"] = @(self.page);//[NSString stringWithFormat:@"%d",self.page];//当前页，默认1
    }
    
    //get_live_feed_paging
    [BlysaBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_MATCH_LIVE_FEED_PAGING params:params successBlock:^(id responseData) {
        if (isFirst) {
            [self.wordLiveList removeAllObjects];
        }
        if (self.page < [responseData[@"pages"] integerValue]) {
            self.page ++;
            self.hasMore = YES;
        } else {
            self.hasMore = NO;
        }
        
        NSArray *data = responseData[@"live_feed"];
//        NSInteger toCount = 0;
        if ([data isKindOfClass:[NSArray class]] && data.count > 0) {
//            if (data.count > 4) {
//                toCount = data.count - 4;
//            }
            for (NSArray *q in data) {
                NSArray *quarter = [NSArray yy_modelArrayWithClass:[UUaksHTMatchLiveFeedModel class] json:q];
                [self.wordLiveList addObjectsFromArray:quarter];
            }
        }
        
        UUaksHTMatchLiveFeedModel *currentModel;
      
        for (UUaksHTMatchLiveFeedModel *m in self.wordLiveList) {
//            m.toCount = toCount;
            if (currentModel) {
                //判断是否得分
                if ([m.awayPts intValue] > [currentModel.awayPts intValue] || [m.homePts intValue] > [currentModel.homePts intValue]) {
                    m.tagSrore = 1;//标记得分
                }else if ([m.awayPts intValue] < [currentModel.awayPts intValue] || [m.homePts intValue] < [currentModel.homePts intValue]){
                    currentModel.tagSrore = 1;
                }
            }
          
            currentModel = m;
        }
        if (successBlock) {
            successBlock(self.wordLiveList);
        }
        
    } errorBlock:errorBlock];
}

@end

