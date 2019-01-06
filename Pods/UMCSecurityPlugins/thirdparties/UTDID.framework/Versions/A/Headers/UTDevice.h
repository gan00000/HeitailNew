#ifndef UTDIDDevice_h
#define UTDIDDevice_h
#import "AidProtocol.h"
@interface UTDevice : NSObject
+(NSString *) utdid;
+(NSString *) aid:(NSString *)appName
            token:(NSString *)token;
+(void) aidAsync:(NSString *)appName
                 token:(NSString *)token
           aidDelegate:(id<AidProtocolDelegate>)aidDelegate;
@end
#endif
