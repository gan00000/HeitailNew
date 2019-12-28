#import "SkyBallHetiRedHTUserManager.h"
#import <LineSDK/LineSDK.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "SkyBallHetiRedHTLoginAlertView.h"
#import "SkyBallHetiRedHTUserRequest.h"
#import "SkyBallHetiRedDRSandBoxManager.h"
const NSString * kUserLogStatusChagneNotice = @"UserLogStatusChagneNotice";
#define kUserTokenKey @"userToken"
#define kDeviceTokenKey @"deviceToken"
@interface SkyBallHetiRedHTUserManager () <LineSDKLoginDelegate>
@property (nonatomic, strong) SkyBallHetiRedHTUserInfoModel *userInfoModel;
@property (nonatomic, strong) FBSDKLoginManager *waterSky_fbLoginManager;
@end
@implementation SkyBallHetiRedHTUserManager
- (instancetype)init {
    self = [super init];
    if (self) {
        self.svgImageCache = [[NSMutableDictionary alloc] initWithCapacity:0];
        if ([SkyBallHetiRedHTUserManager waterSky_isUserLogin]) {
            NSData *data = [NSData dataWithContentsOfFile:[SkyBallHetiRedHTUserManager waterSkyuserInfoPath]];
            self.userInfoModel = [SkyBallHetiRedHTUserInfoModel yy_modelWithJSON:data];
        }
    }
    return self;
}


+ (instancetype)manager {
    static SkyBallHetiRedHTUserManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SkyBallHetiRedHTUserManager alloc] init];
    });
    return manager;
}
+ (BOOL)waterSky_isUserLogin {
    return [SkyBallHetiRedHTUserManager waterSky_userToken].length > 0;
}
+ (SkyBallHetiRedHTUserInfoModel *)waterSky_userInfo {
    return [SkyBallHetiRedHTUserManager manager].userInfoModel;
}
+ (void)saveUserInfo:(NSDictionary *)userInfo {
    SkyBallHetiRedHTUserManager *manager = [SkyBallHetiRedHTUserManager manager];
    manager.userInfoModel = [SkyBallHetiRedHTUserInfoModel yy_modelWithJSON:userInfo];
    NSData *data = [userInfo yy_modelToJSONData];
    [data writeToFile:[SkyBallHetiRedHTUserManager waterSkyuserInfoPath] atomically:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLogStatusChagneNotice object:nil];
}
+ (NSString *)waterSky_userToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserTokenKey];
}
+ (void)saveUserToken:(NSString *)userToken {
    [[NSUserDefaults standardUserDefaults] setObject:userToken forKey:kUserTokenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)waterSky_deviceToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceTokenKey];
}
+ (void)waterSky_saveDeviceToken:(NSString *)deviceToken {
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:kDeviceTokenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)waterSky_doUserLogin {
    [SkyBallHetiRedHTLoginAlertView waterSkyshowLoginAlertViewWithSelectBlock:^(HTLoginPlatform platform) {
        SkyBallHetiRedHTUserManager *manager = [SkyBallHetiRedHTUserManager manager];
        if (platform == HTLoginPlatformFB) {
            [manager getAuthWithUserInfoFromFacebook];
        } else if (platform == HTLoginPlatformLine) {
            [manager getAuthWithUserInfoFromLine];
        }
    }];
}
+ (void)waterSky_doUserLogout {
    [self saveUserToken:nil];
    [SkyBallHetiRedDRSandBoxManager waterSkydeleteFileAtPath:[self waterSkyuserInfoPath] doneBlock:^(NSString * _Nonnull filePath, BOOL success, NSError * _Nonnull error) {
        BJLog(@"用戶信息刪除 %d", success);
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLogStatusChagneNotice object:nil];
    [[SkyBallHetiRedHTUserManager manager].waterSky_fbLoginManager logOut];
}
#pragma mark - Facebook Authory
- (void)getAuthWithUserInfoFromFacebook {
    kWeakSelf
    [self.waterSky_fbLoginManager logInWithReadPermissions: @[@"public_profile",@"email"] fromViewController:[SkyBallHetiRedPPXXBJViewControllerCenter currentViewController] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             [kWindow showToast:@"登錄失敗"];
         } else if (result.isCancelled) {
             [kWindow showToast:@"取消登錄"];
         } else {
             [weakSelf doLoginRequesWithAccessToken:result.token.tokenString sns:1];
         }
    }];
}
#pragma mark - Line Authory
- (void)getAuthWithUserInfoFromLine {
    [LineSDKLogin sharedInstance].delegate = self;
    [[LineSDKLogin sharedInstance] startLogin];
}
- (void)didLogin:(LineSDKLogin *)login
      credential:(nullable LineSDKCredential *)credential
         profile:(nullable LineSDKProfile *)profile
           error:(nullable NSError *)error {
    [self doLoginRequesWithAccessToken:credential.accessToken.accessToken sns:2];
}
#pragma mark - request
- (void)doLoginRequesWithAccessToken:(NSString *)accessToken sns:(NSInteger)sns {
    [SkyBallHetiRedHTUserRequest waterSkydoLoginRequestWithAccessToken:accessToken sns:sns successBlock:^(NSString * _Nonnull userToken) {
        [SkyBallHetiRedHTUserManager saveUserToken:userToken];
        [SkyBallHetiRedHTUserManager waterSky_refreshUserInfoWithSuccessBlock:nil];
    } failBlock:^(SkyBallHetiRedBJError *error) {
        BJLog(@"登錄失敗");
    }];
}
+ (void)waterSky_refreshUserInfoWithSuccessBlock:(dispatch_block_t)block {
    [SkyBallHetiRedHTUserRequest waterSkyrequestUserInfoWithSuccessBlock:^(NSDictionary * _Nonnull userInfo) {
        [self saveUserInfo:userInfo];
        if (block) {
            block();
        }
    } failBlock:^(SkyBallHetiRedBJError *error) {
        BJLog(@"獲取用戶信息失敗");
    }];
}
#pragma mark - util
+ (NSString *)waterSkyuserInfoPath {
    return [NSString stringWithFormat:@"%@/userInfo.json", [SkyBallHetiRedDRSandBoxManager waterSkygetDocumentPath]];
}
+ (void)waterSkycameraDenied {
    [self waterSky_showAlertWithTitle:@"相機權限未開啟" message:@"檢測到相機被禁用，無法拍照" cancelButton:@"取消" confirmButton:@"去開啟" confirmBlock:^{
        [self waterSky_goSystemSettingCenter];
    }];
}
+ (void)waterSkyphotoAlbumDenied {
    [self waterSky_showAlertWithTitle:@"相冊權限未開啟" message:@"檢測到相冊被禁用，無法查看照片" cancelButton:@"取消" confirmButton:@"去開啟" confirmBlock:^{
        [self waterSky_goSystemSettingCenter];
    }];
}
+ (void)waterSky_showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButton confirmButton:(NSString *)confirmButton confirmBlock:(dispatch_block_t)confirmBlock {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButton style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    if (confirmButton) {
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmButton style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirmBlock) {
                confirmBlock();
            }
        }];
        [alert addAction:confirmAction];
    }
    [[SkyBallHetiRedPPXXBJViewControllerCenter currentViewController] presentViewController:alert animated:YES completion:nil];
}
+ (void)waterSky_goSystemSettingCenter {
    NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:appSettings];
}
- (FBSDKLoginManager *)waterSky_fbLoginManager {
    if (!_waterSky_fbLoginManager) {
        _waterSky_fbLoginManager = [[FBSDKLoginManager alloc] init];
    }
    return _waterSky_fbLoginManager;
}
@end
