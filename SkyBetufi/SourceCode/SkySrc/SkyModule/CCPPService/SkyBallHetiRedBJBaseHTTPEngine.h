#import <Foundation/Foundation.h>
@class AFHTTPSessionManager;
typedef void (^BJHTTPSuccessBlock)(NSURLSessionDataTask *task, id responseData);
typedef void (^BJHTTPProgressBlock)(float progress);
typedef void (^BJHTTPFailureBlock)(NSURLSessionDataTask *task, NSError *error);
@interface SkyBallHetiRedBJBaseHTTPEngine : NSObject
- (instancetype)initWithBasePath:(NSString *)basePath;
- (void)waterSky_updateSessionWithBlock:(void(^)(AFHTTPSessionManager *session))updateBlock;
- (void)waterSky_getRequestWithFunctionPath:(NSString *)path
                            params:(NSDictionary *)params
                      successBlock:(BJHTTPSuccessBlock)successBlock
                        errorBlock:(BJHTTPFailureBlock)errorBlock;
- (void)waterSky_postRequestWithFunctionPath:(NSString *)path
                             params:(NSDictionary *)params
                       successBlock:(BJHTTPSuccessBlock)successBlock
                         errorBlock:(BJHTTPFailureBlock)errorBlock;
- (void)waterSky_fileUploadWithFunctionPath:(NSString *)functionPath
                            params:(NSDictionary *)params
                          fileData:(NSData *)fileData
                          fileName:(NSString *)fileName
                          mimeType:(NSString *)mimeType
                     progressBlock:(BJHTTPProgressBlock)progressBlock
                      successBlock:(BJHTTPSuccessBlock)successBlock
                        errorBlock:(BJHTTPFailureBlock)errorBlock;
- (void)waterSky_imageUploadWithFunctionPath:(NSString *)functionPath
                             params:(NSDictionary *)params
                          imageData:(NSData *)imageData
                          imageName:(NSString *)imageName
                      progressBlock:(BJHTTPProgressBlock)progressBlock
                       successBlock:(BJHTTPSuccessBlock)successBlock
                         errorBlock:(BJHTTPFailureBlock)errorBlock;
@end
