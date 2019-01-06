#import <Foundation/Foundation.h>
@interface JXSystemAuthManager : NSObject
+ (void)jx_judgeAddressBookAuthStatusWithSuccess:(void(^)(void))success
                                         failure:(void(^)(void))failure;
+ (void)jx_judgeCameraAuthStatusWithSuccess:(void(^)(void))success
                                    failure:(void(^)(void))failure;
+ (void)jx_judgeAlbumAuthStatusWithSuccess:(void(^)(void))success
                                   failure:(void(^)(void))failure;
+ (void)jx_judgeMicrophoneAuthStatusWithSuccess:(void(^)(void))success
                                        failure:(void(^)(void))failure;
+ (void)jx_judgeLocationAuthStatusWithSuccess:(void(^)(void))success
                                      failure:(void(^)(void))failure;
+ (void)jx_judgeReminderAuthStatusWithSuccess:(void(^)(void))success
                                      failure:(void(^)(void))failure;
+ (void)jx_judgeCalendarAuthStatusWithSuccess:(void(^)(void))success
                                      failure:(void(^)(void))failure;
+ (void)jx_openApplicationSetting;
@end
