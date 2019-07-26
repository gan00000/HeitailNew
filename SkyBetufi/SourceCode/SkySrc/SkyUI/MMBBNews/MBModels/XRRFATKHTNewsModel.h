//
//  XRRFATKHTNewsModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XRRFATKHTNewsModel : NSObject

@property (nonatomic, copy) NSString *news_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *title_plain;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong) NSDictionary *custom_fields;
@property (nonatomic, assign) NSInteger total_comment;
@property (nonatomic, assign) NSInteger total_like;
@property (nonatomic, assign) NSInteger total_save;
@property (nonatomic, assign) BOOL my_save; // 是否收藏
@property (nonatomic, copy) NSString *comment_id;
@property (nonatomic, copy) NSString *user_img;
@property (nonatomic, copy) NSString *comment_content;
@property (nonatomic, copy) NSString *comment_date;

@property (nonatomic, strong) XRRFATKHTUserInfoModel *userInfo;
@property (nonatomic, strong) NSDate *comt_date_obj;
@property (nonatomic, assign) CGFloat my_comment_cell_height;

@property (nonatomic, copy) NSString *img_url;
@property (nonatomic, copy) NSString *view_count;
@property (nonatomic, assign) CGFloat detailHeaderHeight;
@property (nonatomic, copy) NSString *news_type;
@property (nonatomic, copy) NSString *iframe;
@property (nonatomic, assign) CGFloat iframe_height;
@property (nonatomic, assign) CGFloat filmCellHeight;
@property (nonatomic, strong) id share_thub;

/// 新闻详情页使用
- (void)getClearContentWithBlock:(void(^)(BOOL success, NSString *content))block;

+ (BOOL)canShare;
- (void)share;

- (void)countCommentHeight;

@end
