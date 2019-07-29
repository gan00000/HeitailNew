//
//  XRRFATKHTFilmHomeRequest.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKHTNewsModel.h"

@interface XRRFATKHTFilmHomeRequest : NSObject

@property (nonatomic, assign) BOOL hasMore;

- (void)skargrequestWithSuccessBlock:(void(^)(NSArray<XRRFATKHTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;

- (void)loadNextPageWithSuccessBlock:(void(^)(NSArray<XRRFATKHTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;

@end
