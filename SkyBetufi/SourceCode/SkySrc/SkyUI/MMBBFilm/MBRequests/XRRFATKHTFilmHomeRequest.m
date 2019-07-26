//
//  XRRFATKHTFilmHomeRequest.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKHTFilmHomeRequest.h"

@interface XRRFATKHTFilmHomeRequest ()

@property (nonatomic, strong) NSMutableArray *newsList;
@property (nonatomic, assign) NSInteger page;

@end

@implementation XRRFATKHTFilmHomeRequest

- (void)requestWithSuccessBlock:(void(^)(NSArray<XRRFATKHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    if (!self.newsList) {
        self.newsList = [NSMutableArray array];
    }
    self.page = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"json"] = @1;
    params[@"count"] = @20;
    params[@"page"] = @(self.page);
    
    [XRRFATKBJHTTPServiceEngine getRequestWithFunctionPath:API_FILM_HOME params:params successBlock:^(id responseData) {
        [self.newsList removeAllObjects];
        
        if (self.page < [responseData[@"pages"] integerValue]) {
            self.page ++;
            self.hasMore = YES;
        } else {
            self.hasMore = NO;
        }
        
        NSArray *list = [NSArray yy_modelArrayWithClass:[XRRFATKHTNewsModel class] json:responseData[@"posts"]];
        if (list) {
            [self.newsList addObjectsFromArray:list];
        }
        
        if (successBlock) {
            successBlock(self.newsList);
        }
        
    } errorBlock:errorBlock];
    
}

- (void)loadNextPageWithSuccessBlock:(void(^)(NSArray<XRRFATKHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"json"] = @1;
    params[@"count"] = @20;
    params[@"page"] = @(self.page);
    
    [XRRFATKBJHTTPServiceEngine getRequestWithFunctionPath:API_FILM_HOME params:params successBlock:^(id responseData) {
        if (self.page < [responseData[@"pages"] integerValue]) {
            self.page ++;
            self.hasMore = YES;
        } else {
            self.hasMore = NO;
        }
        
        NSArray *list = [NSArray yy_modelArrayWithClass:[XRRFATKHTNewsModel class] json:responseData[@"posts"]];
        if (list) {
            [self.newsList addObjectsFromArray:list];
        }
        
        if (successBlock) {
            successBlock(self.newsList);
        }
    } errorBlock:errorBlock];
}

@end
