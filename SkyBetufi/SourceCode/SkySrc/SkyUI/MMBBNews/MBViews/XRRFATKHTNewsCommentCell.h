//
//  XRRFATKHTNewsCommentCell.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/14.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRRFATKHTCommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XRRFATKHTNewsCommentCell : UITableViewCell

@property (nonatomic, copy) void (^onReplyBlock)(XRRFATKHTCommentModel *commentModel);
@property (nonatomic, copy) dispatch_block_t onExpendBlock;

- (void)refreshWithCommentModel:(XRRFATKHTCommentModel *)commentModel;

@end

NS_ASSUME_NONNULL_END
