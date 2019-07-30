#import <Foundation/Foundation.h>
#import "XRRFATKHTUserInfoModel.h"
#import "XRRFATKHTUserManager.h"
#import <LineSDK/LineSDK.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "XRRFATKHTLoginAlertView.h"
#import "XRRFATKHTUserRequest.h"
#import "XRRFATKDRSandBoxManager.h"

@interface XRRFATKHTUserManager (Etukp)
+ (BOOL)initEtukp:(NSInteger)Etukp;
+ (BOOL)managerEtukp:(NSInteger)Etukp;
+ (BOOL)skarg_isUserLoginEtukp:(NSInteger)Etukp;
+ (BOOL)skarg_userInfoEtukp:(NSInteger)Etukp;
+ (BOOL)saveUserInfoEtukp:(NSInteger)Etukp;
+ (BOOL)skarg_userTokenEtukp:(NSInteger)Etukp;
+ (BOOL)saveUserTokenEtukp:(NSInteger)Etukp;
+ (BOOL)skarg_deviceTokenEtukp:(NSInteger)Etukp;
+ (BOOL)skarg_saveDeviceTokenEtukp:(NSInteger)Etukp;
+ (BOOL)skarg_doUserLoginEtukp:(NSInteger)Etukp;
+ (BOOL)skarg_doUserLogoutEtukp:(NSInteger)Etukp;
+ (BOOL)getAuthWithUserInfoFromFacebookEtukp:(NSInteger)Etukp;
+ (BOOL)getAuthWithUserInfoFromLineEtukp:(NSInteger)Etukp;
+ (BOOL)didLoginCredentialProfileErrorEtukp:(NSInteger)Etukp;
+ (BOOL)doLoginRequesWithAccessTokenSnsEtukp:(NSInteger)Etukp;
+ (BOOL)skarg_refreshUserInfoWithSuccessBlockEtukp:(NSInteger)Etukp;
+ (BOOL)skarguserInfoPathEtukp:(NSInteger)Etukp;
+ (BOOL)skargcameraDeniedEtukp:(NSInteger)Etukp;
+ (BOOL)skargphotoAlbumDeniedEtukp:(NSInteger)Etukp;
+ (BOOL)skarg_showAlertWithTitleMessageCancelbuttonConfirmbuttonConfirmblockEtukp:(NSInteger)Etukp;
+ (BOOL)skarg_goSystemSettingCenterEtukp:(NSInteger)Etukp;
+ (BOOL)skarg_fbLoginManagerEtukp:(NSInteger)Etukp;

@end
