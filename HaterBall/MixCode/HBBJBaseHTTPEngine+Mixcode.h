#import <Foundation/Foundation.h>
#import "HBBJBaseHTTPEngine.h"
#import <AFNetworking/AFNetworking.h>

@interface HBBJBaseHTTPEngine (Mixcode)
- (void)initWithBasePath:(NSString *)basePath mixcode:(NSString *)mixcode;
- (void)updateSessionWithBlock:(void(^)(AFHTTPSessionManager *sesson))updateBlock mixcode:(NSString *)mixcode;
- (void)getRequestWithFunctionPath:(NSString *)path
                            params:(NSDictionary *)params
                      successBlock:(BJHTTPSuccessBlock)successBlock
                        errorBlock:(BJHTTPFailureBlock)errorBlock mixcode:(NSString *)mixcode;
- (void)postRequestWithFunctionPath:(NSString *)path
                             params:(NSDictionary *)params
                       successBlock:(BJHTTPSuccessBlock)successBlock
                         errorBlock:(BJHTTPFailureBlock)errorBlock mixcode:(NSString *)mixcode;
- (void)fileUploadWithFunctionPath:(NSString *)functionPath
                            params:(NSDictionary *)params
                          fileData:(NSData *)fileData
                          fileName:(NSString *)fileName
                          mimeType:(NSString *)mimeType
                     progressBlock:(BJHTTPProgressBlock)progressBlock
                      successBlock:(BJHTTPSuccessBlock)successBlock
                        errorBlock:(BJHTTPFailureBlock)errorBlock mixcode:(NSString *)mixcode;
- (void)imageUploadWithFunctionPath:(NSString *)functionPath
                             params:(NSDictionary *)params
                          imageData:(NSData *)imageData
                          imageName:(NSString *)imageName
                      progressBlock:(BJHTTPProgressBlock)progressBlock
                       successBlock:(BJHTTPSuccessBlock)successBlock
                         errorBlock:(BJHTTPFailureBlock)errorBlock mixcode:(NSString *)mixcode;

@end
