#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface HourseHTMyMessageModel : NSObject
@property (nonatomic, copy) NSString *post_id;
@property (nonatomic, copy) NSString *post_title;
@property (nonatomic, copy) NSString *post_content;
@property (nonatomic, copy) NSString *post_guide;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *comment_id;
@property (nonatomic, copy) NSString *comment_content;
@property (nonatomic, copy) NSString *reply_msg;
@property (nonatomic, copy) NSString *type; 
@property (nonatomic, assign) BOOL read;
@property (nonatomic, copy) NSString *created_on;
@property (nonatomic, copy) NSString *display_name;
@property (nonatomic, copy) NSString *user_img;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) NSDate *date;
- (void)tao_countHeight;
@end
NS_ASSUME_NONNULL_END
