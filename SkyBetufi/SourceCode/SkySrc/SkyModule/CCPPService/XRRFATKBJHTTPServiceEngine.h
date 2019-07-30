#import <Foundation/Foundation.h>
#import "XRRFATKBJBaseHTTPEngine.h"
#import "XRRFATKBJError.h"
#import "BJAPIAddress.h"
typedef void (^BJServiceSuccessBlock)(id responseData);
typedef void (^BJServiceErrorBlock)(XRRFATKBJError *error);
@interface XRRFATKBJHTTPServiceEngine : NSObject
+ (instancetype)sharedInstance;
+ (void)skarg_getRequestCommon:(NSString *)path
                  params:(NSDictionary *)params
            successBlock:(BJServiceSuccessBlock)successBlock
              errorBlock:(BJServiceErrorBlock)errorBlock;
+ (void)skarg_getRequestWithFunctionPath:(NSString *)path
                            params:(NSDictionary *)params
                      successBlock:(BJServiceSuccessBlock)successBlock
                        errorBlock:(BJServiceErrorBlock)errorBlock;
+ (void)skarg_postRequestWithFunctionPath:(NSString *)path
                             params:(NSDictionary *)params
                       successBlock:(BJServiceSuccessBlock)successBlock
                         errorBlock:(BJServiceErrorBlock)errorBlock;
+ (void)skarg_fileUploadWithFunctionPath:(NSString *)functionPath
                            params:(NSDictionary *)params
                          fileData:(NSData *)fileData
                          fileName:(NSString *)fileName
                          mimeType:(NSString *)mimeType
                     progressBlock:(BJHTTPProgressBlock)progressBlock
                      successBlock:(BJServiceSuccessBlock)successBlock
                        errorBlock:(BJServiceErrorBlock)errorBlock;
+ (void)skarg_imageUploadWithFunctionPath:(NSString *)functionPath
                             params:(NSDictionary *)params
                          imageData:(NSData *)imageData
                          imageName:(NSString *)imageName
                      progressBlock:(BJHTTPProgressBlock)progressBlock
                       successBlock:(BJServiceSuccessBlock)successBlock
                         errorBlock:(BJServiceErrorBlock)errorBlock;
@end
