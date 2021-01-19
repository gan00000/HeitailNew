#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface GlodBuleHTUserInfoModel : NSObject
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *display_name;
@property (nonatomic, assign) BOOL change_name;
@property (nonatomic, copy) NSString *user_email;
@property (nonatomic, assign) NSInteger user_status; 
@property (nonatomic, copy) NSString *user_img;
@property (nonatomic, strong) UIImage *avatar;
@end
NS_ASSUME_NONNULL_END
