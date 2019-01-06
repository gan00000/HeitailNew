#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
UIKIT_EXTERN NSString * __nonnull const kUMessageAliasTypeSina;
UIKIT_EXTERN NSString * __nonnull const kUMessageAliasTypeTencent;
UIKIT_EXTERN NSString * __nonnull const kUMessageAliasTypeQQ;
UIKIT_EXTERN NSString * __nonnull const kUMessageAliasTypeWeiXin;
UIKIT_EXTERN NSString * __nonnull const kUMessageAliasTypeBaidu;
UIKIT_EXTERN NSString * __nonnull const kUMessageAliasTypeRenRen;
UIKIT_EXTERN NSString * __nonnull const kUMessageAliasTypeKaixin;
UIKIT_EXTERN NSString * __nonnull const kUMessageAliasTypeDouban;
UIKIT_EXTERN NSString * __nonnull const kUMessageAliasTypeFacebook;
UIKIT_EXTERN NSString * __nonnull const kUMessageAliasTypeTwitter;
extern NSString * __nonnull const kUMessageErrorDomain;
typedef NS_ENUM(NSInteger, kUMessageError) {
    kUMessageErrorUnknown = 0,
    kUMessageErrorResponseErr = 1,
    kUMessageErrorOperateErr = 2,
    kUMessageErrorParamErr = 3,
    kUMessageErrorDependsErr = 4,
    kUMessageErrorServerSetErr = 5,
};
typedef NS_OPTIONS(NSUInteger, UMessageAuthorizationOptions) {
    UMessageAuthorizationOptionNone    = 0,
    UMessageAuthorizationOptionBadge   = (1 << 0),
    UMessageAuthorizationOptionSound   = (1 << 1),
    UMessageAuthorizationOptionAlert   = (1 << 2),
};
typedef void (^UMPlaunchFinishBlock)();
@interface UMessageRegisterEntity : NSObject
@property (nonatomic, assign) NSInteger types;
@property (nonatomic, strong) NSSet * __nullable categories;
@end
@interface UMessage : NSObject
+ (void)registerForRemoteNotificationsWithLaunchOptions:(NSDictionary * __nullable)launchOptions Entity:(UMessageRegisterEntity * __nullable)entity completionHandler:(void (^ __nullable)(BOOL granted, NSError *_Nullable error))completionHandler;
+ (void)unregisterForRemoteNotifications;
+ (void)registerDeviceToken:( NSData * __nullable)deviceToken;
+ (void)didReceiveRemoteNotification:( NSDictionary * __nullable)userInfo;
+ (void)setBadgeClear:(BOOL)value;
+ (void)setAutoAlert:(BOOL)value;
+ (void)sendClickReportForRemoteNotification:(NSDictionary * __nullable)userInfo;
+ (void)getTags:(void (^__nonnull)(NSSet * __nonnull responseTags,NSInteger remain,NSError * __nullable error))handle;
+ (void)addTags:(__nonnull id)tag response:( void (^ __nonnull)(id __nullable responseObject ,NSInteger remain,NSError * __nullable error))handle;
+ (void)deleteTags:(__nonnull id)tag response:(void (^__nonnull)(id __nullable responseObject,NSInteger remain,NSError * __nullable error))handle;
+ (void)addWeightedTags:(NSDictionary * __nonnull)weightedTag response:(void (^__nonnull)(id __nullable responseObject ,NSInteger remain,NSError * __nullable error))handle;
+ (void)getWeightedTags:(void (^__nonnull)(NSDictionary * __nullable responseWeightedTags,NSInteger remain,NSError * __nullable error))handle;
+ (void)deleteWeightedTags:(id __nonnull)weightedTags response:(void (^__nonnull)(id __nullable responseObject,NSInteger remain,NSError * __nullable error))handle;
+ (void)addAlias:(NSString * __nonnull)name type:(NSString * __nonnull)type response:(void (^__nonnull)(id __nullable responseObject,NSError * __nullable error))handle;
+ (void)setAlias:(NSString * __nonnull )name type:(NSString * __nonnull)type response:(void (^__nonnull)(id __nullable responseObject,NSError * __nullable error))handle;
+ (void)removeAlias:(NSString * __nonnull)name type:(NSString * __nonnull)type response:(void (^__nonnull)(id __nullable responseObject, NSError * __nullable error))handle;
+(void)addLaunchMessage;
+(void)addCardMessageWithLabel:(NSString* __nonnull)label;
+(void)addCustomCardMessageWithPortraitSize:(CGSize )portraitsize LandscapeSize:(CGSize )landscapesize CloseBtn:(UIButton * __nullable )button  Label:(NSString * __nonnull)label umCustomCloseButtonDisplayMode:(BOOL )displaymode;
+(void)addPlainTextCardMessageWithTitleFont:(UIFont * __nullable)titlefont ContentFont:(UIFont * __nullable)contentfont buttonFont:(UIFont * __nullable)buttonfont Label:(NSString * __nonnull)label;;
+(void)openDebugMode:(BOOL)debugmode;
+(void)setWebViewController:(UIViewController * __nonnull)webViewController;
@end
