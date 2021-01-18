#import <Foundation/Foundation.h>
#import "GlodBuleHTUserInfoModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface GlodBuleHTCommentModel : NSObject
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
@property (nonatomic, strong) NSArray<GlodBuleHTUserInfoModel *> *like;
@property (nonatomic, assign) BOOL my_like;
@property (nonatomic, assign) NSInteger total_reply;
@property (nonatomic, strong) NSArray<GlodBuleHTCommentModel *> *reply;
@property (nonatomic, strong) GlodBuleHTUserInfoModel *userModel;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat replyHeight;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) BOOL isReply;
@property (nonatomic, assign) BOOL expend; 
- (void)waterSkycountHeight:(BOOL)isReply;
@end
NS_ASSUME_NONNULL_END
