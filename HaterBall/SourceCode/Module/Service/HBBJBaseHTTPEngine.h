#import <Foundation/Foundation.h>
@class AFHTTPSessionManager;
typedef void (^BJHTTPSuccessBlock)(NSURLSessionDataTask *task, id responseData);
typedef void (^BJHTTPProgressBlock)(float progress);
typedef void (^BJHTTPFailureBlock)(NSURLSessionDataTask *task, NSError *error);
@interface HBBJBaseHTTPEngine : NSObject
- (instancetype)initWithBasePath:(NSString *)basePath;
- (void)updateSessionWithBlock:(void(^)(AFHTTPSessionManager *session))updateBlock;
- (void)getRequestWithFunctionPath:(NSString *)path
                            params:(NSDictionary *)params
                      successBlock:(BJHTTPSuccessBlock)successBlock
                        errorBlock:(BJHTTPFailureBlock)errorBlock;
- (void)postRequestWithFunctionPath:(NSString *)path
                             params:(NSDictionary *)params
                       successBlock:(BJHTTPSuccessBlock)successBlock
                         errorBlock:(BJHTTPFailureBlock)errorBlock;
- (void)fileUploadWithFunctionPath:(NSString *)functionPath
                            params:(NSDictionary *)params
                          fileData:(NSData *)fileData
                          fileName:(NSString *)fileName
                          mimeType:(NSString *)mimeType
                     progressBlock:(BJHTTPProgressBlock)progressBlock
                      successBlock:(BJHTTPSuccessBlock)successBlock
                        errorBlock:(BJHTTPFailureBlock)errorBlock;
- (void)imageUploadWithFunctionPath:(NSString *)functionPath
                             params:(NSDictionary *)params
                          imageData:(NSData *)imageData
                          imageName:(NSString *)imageName
                      progressBlock:(BJHTTPProgressBlock)progressBlock
                       successBlock:(BJHTTPSuccessBlock)successBlock
                         errorBlock:(BJHTTPFailureBlock)errorBlock;
@end
