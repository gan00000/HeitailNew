#ifndef SECURITYENV_ISECURITY_ENV_INITLISTENER_H
#define SECURITYENV_ISECURITY_ENV_INITLISTENER_H
#import <Foundation/Foundation.h>
#include "EnvExport.h"
@interface ISecurityEnvInitListener : NSObject
- (void) onUMIDInitFinished : (const char *) strToken : (int) status;
@end
#endif 
