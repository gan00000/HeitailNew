#import <Foundation/Foundation.h>
#import "GlodBuleBJBaseHTTPEngine.h"
#import "GlodBuleBJError.h"
#import "BJAPIAddress.h"
typedef void (^BJServiceSuccessBlock)(id responseData);
typedef void (^BJServiceErrorBlock)(GlodBuleBJError *error);
@interface GlodBuleBJHTTPServiceEngine : NSObject
+ (instancetype)sharedInstance;
+ (void)tao_getRequestCommon:(NSString *)path
                  params:(NSDictionary *)params
            successBlock:(BJServiceSuccessBlock)successBlock
              errorBlock:(BJServiceErrorBlock)errorBlock;
+ (void)tao_getRequestWithFunctionPath:(NSString *)path
                            params:(NSDictionary *)params
                      successBlock:(BJServiceSuccessBlock)successBlock
                        errorBlock:(BJServiceErrorBlock)errorBlock;
+ (void)tao_postRequestWithFunctionPath:(NSString *)path
                             params:(NSDictionary *)params
                       successBlock:(BJServiceSuccessBlock)successBlock
                         errorBlock:(BJServiceErrorBlock)errorBlock;
+ (void)tao_fileUploadWithFunctionPath:(NSString *)functionPath
                            params:(NSDictionary *)params
                          fileData:(NSData *)fileData
                          fileName:(NSString *)fileName
                          mimeType:(NSString *)mimeType
                     progressBlock:(BJHTTPProgressBlock)progressBlock
                      successBlock:(BJServiceSuccessBlock)successBlock
                        errorBlock:(BJServiceErrorBlock)errorBlock;
+ (void)tao_imageUploadWithFunctionPath:(NSString *)functionPath
                             params:(NSDictionary *)params
                          imageData:(NSData *)imageData
                          imageName:(NSString *)imageName
                      progressBlock:(BJHTTPProgressBlock)progressBlock
                       successBlock:(BJServiceSuccessBlock)successBlock
                         errorBlock:(BJServiceErrorBlock)errorBlock;
@end