//
//  XRRFATKHTCommentModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/9.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRFATKHTUserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XRRFATKHTCommentModel : NSObject

@property (nonatomic, copy) NSString *comment_id;
@property (nonatomic, copy) NSString *post_id;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *comment_author;
@property (nonatomic, copy) NSString *comment_date;
@property (nonatomic, copy) NSString *comment_content;
@property (nonatomic, copy) NSString *user_img;
@property (nonatomic, assign) NSInteger total_like;
@property (nonatomic, copy) NSString *reply_to_user_id;
@property (nonatomic, copy) NSString *reply_to_display_name;
@property (nonatomic, strong) NSArray<XRRFATKHTUserInfoModel *> *like;
@property (nonatomic, assign) BOOL my_like;
@property (nonatomic, assign) NSInteger total_reply;
@property (nonatomic, strong) NSArray<XRRFATKHTCommentModel *> *reply;

@property (nonatomic, strong) XRRFATKHTUserInfoModel *userModel;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat replyHeight;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) BOOL isReply;
@property (nonatomic, assign) BOOL expend; // 展开

- (void)skargcountHeight:(BOOL)isReply;

@end

NS_ASSUME_NONNULL_END
