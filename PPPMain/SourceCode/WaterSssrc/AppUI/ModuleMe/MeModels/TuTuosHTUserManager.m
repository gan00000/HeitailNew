#import "TuTuosHTUserManager.h"
#import <LineSDK/LineSDK.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "MMoogHTLoginAlertView.h"
#import "NSNiceHTUserRequest.h"
#import "BByasDRSandBoxManager.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import "BlysaBJUtility.h"
#import "UIColor+FFlaliHex.h"

const NSString * kUserLogStatusChagneNotice = @"UserLogStatusChagneNotice";
#define kUserTokenKey @"userToken"
#define kDeviceTokenKey @"deviceToken"
@interface TuTuosHTUserManager () <LineSDKLoginDelegate,ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>
@property (nonatomic, strong) FFlaliHTUserInfoModel *userInfoModel;
@property (nonatomic, strong) FBSDKLoginManager *tao_fbLoginManager;
@end
@implementation TuTuosHTUserManager
- (instancetype)init {
    self = [super init];
    if (self) {
        self.svgImageCache = [[NSMutableDictionary alloc] initWithCapacity:0];
        if ([TuTuosHTUserManager tao_isUserLogin]) {
            NSData *data = [NSData dataWithContentsOfFile:[TuTuosHTUserManager taouserInfoPath]];
            self.userInfoModel = [FFlaliHTUserInfoModel yy_modelWithJSON:data];
        }
    }
    return self;
}


+ (instancetype)manager {
    static TuTuosHTUserManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TuTuosHTUserManager alloc] init];
    });
    return manager;
}
+ (BOOL)tao_isUserLogin {
    return [TuTuosHTUserManager tao_userToken].length > 0;
}
+ (FFlaliHTUserInfoModel *)tao_userInfo {
    return [TuTuosHTUserManager manager].userInfoModel;
}
+ (void)saveUserInfo:(NSDictionary *)userInfo {
    TuTuosHTUserManager *manager = [TuTuosHTUserManager manager];
    manager.userInfoModel = [FFlaliHTUserInfoModel yy_modelWithJSON:userInfo];
    NSData *data = [userInfo yy_modelToJSONData];
    [data writeToFile:[TuTuosHTUserManager taouserInfoPath] atomically:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLogStatusChagneNotice object:nil];
}
+ (NSString *)tao_userToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserTokenKey];
}
+ (void)saveUserToken:(NSString *)userToken {
    [[NSUserDefaults standardUserDefaults] setObject:userToken forKey:kUserTokenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)tao_deviceToken {
    //"{length=32,bytes=0xd582e45f98bb7e74178057a7a09d4469...a1f4e84fe1eadaf4}"
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceTokenKey];
    if (token || token.length == 0) {
        token = @"{length=32,bytes=0xd582e45f98bb7e74178057a7a09d4469...a1f4e84fe1eadaf4}";
    }
    return token;
}

+ (void)tao_saveDeviceToken:(NSString *)deviceToken {
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:kDeviceTokenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)tao_doUserLogin {
    [MMoogHTLoginAlertView taoshowLoginAlertViewWithSelectBlock:^(HTLoginPlatform platform) {
        TuTuosHTUserManager *manager = [TuTuosHTUserManager manager];
        if (platform == HTLoginPlatformFB) {
            [manager getAuthWithUserInfoFromFacebook];
        } else if (platform == HTLoginPlatformLine) {
            [manager getAuthWithUserInfoFromLine];
        }else if (platform == HTLoginPlatformAppleId){
            [manager handleAuthrization];
        }else if (platform == HTLoginPlatformGid){
            [manager handleGidSign];
        }
    }];
}
+ (void)tao_doUserLogout {
    [self saveUserToken:nil];
    [BByasDRSandBoxManager taodeleteFileAtPath:[self taouserInfoPath] doneBlock:^(NSString * _Nonnull filePath, BOOL success, NSError * _Nonnull error) {
        BJLog(@"用戶信息刪除 %d", success);
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLogStatusChagneNotice object:nil];
    [[TuTuosHTUserManager manager].tao_fbLoginManager logOut];
}
#pragma mark - Facebook Authory
- (void)getAuthWithUserInfoFromFacebook {
    
    kWeakSelf
    [self.tao_fbLoginManager logInWithPermissions:@[@"public_profile",@"email"] fromViewController:[CfipyPPXXBJViewControllerCenter currentViewController] handler:^(FBSDKLoginManagerLoginResult * _Nullable result, NSError * _Nullable error) {
        if (error) {
            [kWindow showToast:@"登錄失敗"];
        } else if (result.isCancelled) {
            [kWindow showToast:@"取消登錄"];
        } else {
            [weakSelf doLoginRequesWithAccessToken:result.token.tokenString sns:1];
        }
    }];

//    [self.tao_fbLoginManager logInWithReadPermissions:@[@"public_profile",@"email"] fromViewController:[CfipyPPXXBJViewControllerCenter currentViewController] handler:^(FBSDKLoginManagerLoginResult * _Nullable result, NSError * _Nullable error) {
//            if (error) {
//                [kWindow showToast:@"登錄失敗"];
//            } else if (result.isCancelled) {
//                [kWindow showToast:@"取消登錄"];
//            } else {
//                [weakSelf doLoginRequesWithAccessToken:result.token.tokenString sns:1];
//            }
//    }];
    
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
    [NSNiceHTUserRequest taodoLoginRequestWithAccessToken:accessToken sns:sns successBlock:^(NSString * _Nonnull userToken) {
        [TuTuosHTUserManager saveUserToken:userToken];
        [TuTuosHTUserManager tao_refreshUserInfoWithSuccessBlock:nil];
    } failBlock:^(WSKggBJError *error) {
        BJLog(@"登錄失敗");
    }];
}

- (void)doThirdLoginRequesWithAccessToken:(NSString *)accessToken sns:(NSInteger)sns userId:(NSString *)userId nickName:(NSString *)nickName email:(NSString *)email {
    
    [NSNiceHTUserRequest doThirdLoginRequestWithAccessToken:accessToken
                                                                sns:sns
                                                             userId:userId
                                                           nickName:nickName
                                                              email:email
                                                       successBlock:^(NSString * _Nonnull userToken) {
                [TuTuosHTUserManager saveUserToken:userToken];
                [TuTuosHTUserManager tao_refreshUserInfoWithSuccessBlock:nil];
                }
                                                          failBlock:^(WSKggBJError *error) {
                    BJLog(@"登入失敗");
        [kWindow showToast:@"登入失敗"];
    }];
    
}


+ (void)tao_refreshUserInfoWithSuccessBlock:(dispatch_block_t)block {
    [NSNiceHTUserRequest taorequestUserInfoWithSuccessBlock:^(NSDictionary * _Nonnull userInfo) {
        [self saveUserInfo:userInfo];
        if (block) {
            block();
        }
    } failBlock:^(WSKggBJError *error) {
        BJLog(@"獲取用戶信息失敗");
    }];
}


//! 处理授权
- (void)handleAuthrization{
    if (@available(iOS 13.0, *)) {
        // A mechanism for generating requests to authenticate users based on their Apple ID.
        // 基于用户的Apple ID授权用户，生成用户授权请求的一种机制
        ASAuthorizationAppleIDProvider *appleIDProvider = [ASAuthorizationAppleIDProvider new];
        // Creates a new Apple ID authorization request.
        // 创建新的AppleID 授权请求
        ASAuthorizationAppleIDRequest *request = appleIDProvider.createRequest;
        // The contact information to be requested from the user during authentication.
        // 在用户授权期间请求的联系信息
        request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        // A controller that manages authorization requests created by a provider.
        // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
        ASAuthorizationController *controller = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
        // A delegate that the authorization controller informs about the success or failure of an authorization attempt.
        // 设置授权控制器通知授权请求的成功与失败的代理
        controller.delegate = self;
        // A delegate that provides a display context in which the system can present an authorization interface to the user.
        // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
        controller.presentationContextProvider = self;
        // starts the authorization flows named during controller initialization.
        // 在控制器初始化期间启动授权流
        [controller performRequests];
    }
}

- (void)handleGidSign{
    
    UIViewController *xxxxpresentingViewController = [BlysaBJUtility getCurrentViewController];
    [GIDSignIn sharedInstance].presentingViewController = xxxxpresentingViewController;
    [[GIDSignIn sharedInstance] signIn];
}


#pragma mark - ASAuthorizationControllerDelegate
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)){
    
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", controller);
    NSLog(@"%@", authorization);
    
    NSLog(@"authorization.credential：%@", authorization.credential);
    
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        // 用户登录使用ASAuthorizationAppleIDCredential
        ASAuthorizationAppleIDCredential *appleIDCredential = authorization.credential;
        NSString *userId = appleIDCredential.user;
        NSString *nickname = appleIDCredential.fullName.nickname;
        NSString *email = appleIDCredential.email;
        NSData *identityToken = appleIDCredential.identityToken;
        NSString *identityTokenStr = [[NSString alloc] initWithData:identityToken encoding:NSUTF8StringEncoding];
        NSLog(@"user:%@,identityToken:%@,fullname:%@", userId, identityTokenStr,nickname);
        
        [self doThirdLoginRequesWithAccessToken:identityTokenStr sns:3 userId:userId nickName:nickname email:email];
        
    } else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]) {
        // 用户登录使用现有的密码凭证
        ASPasswordCredential *passwordCredential = authorization.credential;
        // 密码凭证对象的用户标识 用户的唯一标识
        NSString *user = passwordCredential.user;
        // 密码凭证对象的密码
        NSString *password = passwordCredential.password;
      
    } else {
        NSLog(@"授权信息均不符");
     
    }
    
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)){
    
     NSLog(@"%s", __FUNCTION__);
        NSLog(@"错误信息：%@", error);
        NSString *errorMsg = nil;
        switch (error.code) {
            case ASAuthorizationErrorCanceled:
                errorMsg = @"用戶取消授權請求";
                break;
            case ASAuthorizationErrorFailed:
                errorMsg = @"授權請求失敗";
                break;
            case ASAuthorizationErrorInvalidResponse:
                errorMsg = @"授權請求響應無效";
                break;
            case ASAuthorizationErrorNotHandled:
                errorMsg = @"未能处理授权请求";
                break;
            case ASAuthorizationErrorUnknown:
                errorMsg = @"授权请求失败未知原因";
                break;
        }
     [kWindow showToast:errorMsg];
     NSLog(@"authorizationController errorMsg：%@", errorMsg);

}

#pragma mark - ASAuthorizationControllerPresentationContextProviding
- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)){
    
    
      NSLog(@"调用展示window方法：%s", __FUNCTION__);
      // 返回window
      return [CfipyPPXXBJViewControllerCenter currentViewController].view.window;
}

#pragma mark - util
+ (NSString *)taouserInfoPath {
    return [NSString stringWithFormat:@"%@/userInfo.json", [BByasDRSandBoxManager taogetDocumentPath]];
}
+ (void)taocameraDenied {
    [self tao_showAlertWithTitle:@"相機權限未開啟" message:@"檢測到相機被禁用，無法拍照" cancelButton:@"取消" confirmButton:@"去開啟" confirmBlock:^{
        [self tao_goSystemSettingCenter];
    }];
}
+ (void)taophotoAlbumDenied {
    [self tao_showAlertWithTitle:@"相冊權限未開啟" message:@"檢測到相冊被禁用，無法查看照片" cancelButton:@"取消" confirmButton:@"去開啟" confirmBlock:^{
        [self tao_goSystemSettingCenter];
    }];
}
+ (void)tao_showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButton confirmButton:(NSString *)confirmButton confirmBlock:(dispatch_block_t)confirmBlock {
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
    [[CfipyPPXXBJViewControllerCenter currentViewController] presentViewController:alert animated:YES completion:nil];
}
+ (void)tao_goSystemSettingCenter {
    NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:appSettings];
}
- (FBSDKLoginManager *)tao_fbLoginManager {
    if (!_tao_fbLoginManager) {
        _tao_fbLoginManager = [[FBSDKLoginManager alloc] init];
    }
    return _tao_fbLoginManager;
}


+ (UIColor *)getAppBaseColor {
    if (isAppInView) {
        return [UIColor hx_colorWithHexRGBAString:@"54b4ec"];
    }else{
        return [UIColor hx_colorWithHexRGBAString:@"fc562e"];
    }
}

+(NSString *)getDefaultAvater
{
    NSString *default_avatar = @"gurk_default_avatar";
    if (isAppInView) {
        default_avatar = @"gurk_default_avater_view";
    }
    return default_avatar;
}
@end
