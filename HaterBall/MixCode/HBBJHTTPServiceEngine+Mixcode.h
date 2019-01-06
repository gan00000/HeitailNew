#import <Foundation/Foundation.h>
#import "HBBJBaseHTTPEngine.h"
#import "HBBJError.h"
#import "BJAPIAddress.h"
#import "HBBJHTTPServiceEngine.h"
#import "HBBJServiceConfigurator.h"
#import "YYModel.h"
#import "AFHTTPSessionManager.h"
#import "HBBJUtility.h"
#import "HBBJBaseResponceModel.h"

@interface HBBJHTTPServiceEngine (Mixcode)
+ (void)sharedInstanceMixcode:(NSString *)mixcode;
+ (void)getRequestWithFunctionPath:(NSString *)path
                            params:(NSDictionary *)params
                      successBlock:(BJServiceSuccessBlock)successBlock
                        errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode;
+ (void)postRequestWithFunctionPath:(NSString *)path
                             params:(NSDictionary *)params
                       successBlock:(BJServiceSuccessBlock)successBlock
                         errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode;
+ (void)fileUploadWithFunctionPath:(NSString *)functionPath
                            params:(NSDictionary *)params
                          fileData:(NSData *)fileData
                          fileName:(NSString *)fileName
                          mimeType:(NSString *)mimeType
                     progressBlock:(BJHTTPProgressBlock)progressBlock
                      successBlock:(BJServiceSuccessBlock)successBlock
                        errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode;
+ (void)imageUploadWithFunctionPath:(NSString *)functionPath
                             params:(NSDictionary *)params
                          imageData:(NSData *)imageData
                          imageName:(NSString *)imageName
                      progressBlock:(BJHTTPProgressBlock)progressBlock
                       successBlock:(BJServiceSuccessBlock)successBlock
                         errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode;

@end
