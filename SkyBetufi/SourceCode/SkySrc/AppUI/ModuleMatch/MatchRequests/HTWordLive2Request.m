//
//  HTWordLive2Request.m
//  XXXHeiTai
//
//  Created by ganyuanrong on 2021/3/4.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import "HTWordLive2Request.h"

@interface HTWordLive2Request ()
@property (nonatomic, strong) NSMutableArray *wordLiveList;
@property (nonatomic, assign) NSInteger page;
@end
@implementation HTWordLive2Request

- (void)getWordLiveFeedWithGameId:(NSString *)game_id successBlock:(void(^)(NSArray<GlodBuleHTMatchLiveFeedModel *> *newsList))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock{
    if (!self.wordLiveList) {
        self.wordLiveList = [NSMutableArray array];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"game_id"] = game_id;
    params[@"limit"] = @20;
    params[@"pages"] = @0;//当前页，默认0
    [GlodBuleBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_MATCH_LIVE_FEED_PAGING params:params successBlock:^(id responseData) {
        [self.wordLiveList removeAllObjects];
        if (self.page < [responseData[@"pages"] integerValue]) {
            self.page ++;
            self.hasMore = YES;
        } else {
            self.hasMore = NO;
        }
        
        NSArray *data = responseData[@"live_feed"];
        NSInteger toCount = 0;
        if ([data isKindOfClass:[NSArray class]] && data.count > 0) {
            if (data.count > 4) {
                toCount = data.count - 4;
            }
            for (NSArray *q in data) {
                NSArray *quarter = [NSArray yy_modelArrayWithClass:[GlodBuleHTMatchLiveFeedModel class] json:q];
                [self.wordLiveList addObjectsFromArray:quarter];
            }
        }
        
        GlodBuleHTMatchLiveFeedModel *currentModel;
        for (GlodBuleHTMatchLiveFeedModel *m in self.wordLiveList) {
            m.toCount = toCount;
            if (currentModel) {
                
                if ([m.awayPts intValue] > [currentModel.awayPts intValue] || [m.homePts intValue] > [currentModel.homePts intValue]) {
                    m.tagSrore = 1;
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

