#import <Foundation/Foundation.h>
#import "HBNewsModel.h"
#import "HBBJDateFormatUtility.h"
#import "HBBJHTTPServiceEngine.h"
#import "HBHtmlLoadUtil.h"
#import <UShareUI/UShareUI.h>
#import <SDWebImage/SDWebImageManager.h>
#import "HBBJViewControllerCenter.h"

@interface HBNewsModel (Mixcode)
+ (void)modelCustomPropertyMapperMixcode:(NSString *)mixcode;
- (void)setContent:(NSString *)content mixcode:(NSString *)mixcode;
- (void)setDate:(NSString *)date mixcode:(NSString *)mixcode;
- (void)setCustom_fields:(NSDictionary *)custom_fields mixcode:(NSString *)mixcode;
- (void)setTitle:(NSString *)title mixcode:(NSString *)mixcode;
- (void)getClearContentWithBlock:(void(^)(BOOL success, NSString *content))block mixcode:(NSString *)mixcode;
+ (void)canShareMixcode:(NSString *)mixcode;
- (void)shareMixcode:(NSString *)mixcode;
- (void)doShareToPlatform:(UMSocialPlatformType)platformType withMessage:(UMSocialMessageObject *)messageObject mixcode:(NSString *)mixcode;

@end
