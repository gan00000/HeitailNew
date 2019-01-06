#import "HBBJBaseHTTPEngine+Mixcode.h"
@implementation HBBJBaseHTTPEngine (Mixcode)
- (void)initWithBasePath:(NSString *)basePath mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)updateSessionWithBlock:(void(^)(AFHTTPSessionManager *sesson))updateBlock mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)getRequestWithFunctionPath:(NSString *)path
                            params:(NSDictionary *)params
                      successBlock:(BJHTTPSuccessBlock)successBlock
                        errorBlock:(BJHTTPFailureBlock)errorBlock mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)postRequestWithFunctionPath:(NSString *)path
                             params:(NSDictionary *)params
                       successBlock:(BJHTTPSuccessBlock)successBlock
                         errorBlock:(BJHTTPFailureBlock)errorBlock mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)fileUploadWithFunctionPath:(NSString *)functionPath
                            params:(NSDictionary *)params
                          fileData:(NSData *)fileData
                          fileName:(NSString *)fileName
                          mimeType:(NSString *)mimeType
                     progressBlock:(BJHTTPProgressBlock)progressBlock
                      successBlock:(BJHTTPSuccessBlock)successBlock
                        errorBlock:(BJHTTPFailureBlock)errorBlock mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)imageUploadWithFunctionPath:(NSString *)functionPath
                             params:(NSDictionary *)params
                          imageData:(NSData *)imageData
                          imageName:(NSString *)imageName
                      progressBlock:(BJHTTPProgressBlock)progressBlock
                       successBlock:(BJHTTPSuccessBlock)successBlock
                         errorBlock:(BJHTTPFailureBlock)errorBlock mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
