//
//  HTComentGetter.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/13.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRFATKHTCommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XRRFATKHTCommentGetter : NSObject

@property (nonatomic, strong) NSMutableArray<XRRFATKHTCommentModel *> *hotComments;
@property (nonatomic, strong) NSMutableArray<XRRFATKHTCommentModel *> *normalComments;
@property (nonatomic, assign) BOOL hasMore;

- (instancetype)initWithPostId:(NSString *)post_id;

- (void)doRequestWithCompleteBlock:(dispatch_block_t)commentBlock;
- (void)reset;

@end

NS_ASSUME_NONNULL_END
