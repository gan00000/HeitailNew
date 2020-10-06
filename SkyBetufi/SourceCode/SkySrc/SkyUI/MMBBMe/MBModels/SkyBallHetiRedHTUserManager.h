#import <Foundation/Foundation.h>
#import "SkyBallHetiRedHTUserInfoModel.h"
#import "SkyBallHetiRedHTMatchSummaryModel.h"

extern const NSString * kUserLogStatusChagneNotice;
@interface SkyBallHetiRedHTUserManager : NSObject
@property (nonatomic, assign)BOOL appInView;

@property (nonatomic, assign)BOOL showTextLive;

@property (nonatomic, strong) NSMutableDictionary *svgImageCache;

@property (nonatomic, strong) SkyBallHetiRedHTMatchSummaryModel *matchSummaryModel;

+ (instancetype)manager;
+ (BOOL)waterSky_isUserLogin;
+ (SkyBallHetiRedHTUserInfoModel *)waterSky_userInfo;
+ (NSString *)waterSky_userToken;
+ (NSString *)waterSky_deviceToken;
+ (void)waterSky_saveDeviceToken:(NSString *)deviceToken;
+ (void)waterSky_doUserLogin;
+ (void)waterSky_doUserLogout;
+ (void)waterSky_refreshUserInfoWithSuccessBlock:(dispatch_block_t)block;
+ (void)waterSkycameraDenied;
+ (void)waterSkyphotoAlbumDenied;
+ (void)waterSky_showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              cancelButton:(NSString *)cancelButton
             confirmButton:(NSString *)confirmButton
              confirmBlock:(dispatch_block_t)confirmBlock;
@end
