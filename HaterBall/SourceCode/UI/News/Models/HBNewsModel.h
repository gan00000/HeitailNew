#import <Foundation/Foundation.h>
@interface HBNewsModel : NSObject
@property (nonatomic, copy) NSString *news_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *title_plain;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong) NSDictionary *custom_fields;
@property (nonatomic, copy) NSString *img_url;
@property (nonatomic, copy) NSString *view_count;
@property (nonatomic, assign) CGFloat detailHeaderHeight;
@property (nonatomic, copy) NSString *news_type;
@property (nonatomic, copy) NSString *iframe;
@property (nonatomic, assign) CGFloat iframe_height;
@property (nonatomic, assign) CGFloat filmCellHeight;
@property (nonatomic, strong) id share_thub;
- (void)getClearContentWithBlock:(void(^)(BOOL success, NSString *content))block;
+ (BOOL)canShare;
- (void)share;
@end
