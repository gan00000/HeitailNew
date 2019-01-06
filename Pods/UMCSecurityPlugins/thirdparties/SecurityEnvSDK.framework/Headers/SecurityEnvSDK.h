#ifndef SECURITYENV_SECURITY_ENV_SDK_H
#define SECURITYENV_SECURITY_ENV_SDK_H
#import <Foundation/Foundation.h>
#import "ISecurityEnvInitListener.h"
@interface SecurityEnvSDK : NSObject
- (NSInteger) initSync;
- (void) initASync : (ISecurityEnvInitListener *) listener;
- (NSString*) getToken;
@end
#endif 
