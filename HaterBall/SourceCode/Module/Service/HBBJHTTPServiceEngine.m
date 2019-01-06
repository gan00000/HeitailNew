#import "HBBJHTTPServiceEngine.h"
#import "HBBJServiceConfigurator.h"
#import "YYModel.h"
#import "AFHTTPSessionManager.h"
#import "HBBJUtility.h"
#import "HBBJBaseResponceModel.h"
@interface HBBJHTTPServiceEngine ()
@property (nonatomic, strong) HBBJBaseHTTPEngine *httpEngine;
@end
@implementation HBBJHTTPServiceEngine
+ (instancetype)sharedInstance {
    static HBBJHTTPServiceEngine *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HBBJHTTPServiceEngine alloc] init];
        NSString *servicePath = [[HBBJServiceConfigurator sharedInstance] serverBaseUrl];
        instance.httpEngine = [[HBBJBaseHTTPEngine alloc] initWithBasePath:servicePath];
        [instance.httpEngine updateSessionWithBlock:^(AFHTTPSessionManager *session) {
            session.requestSerializer.timeoutInterval = 30;
            [session.requestSerializer setValue:@"89bc52ca5b" forHTTPHeaderField:@"X-User-AppId"];
            [session.requestSerializer setValue:@"1" forHTTPHeaderField:@"X-User-Platform"];
            [session.requestSerializer setValue:[NSString stringWithFormat:@"%@|%@|%@", [HBBJUtility modelName], [HBBJUtility systemVersion], [HBBJUtility idfa]] forHTTPHeaderField:@"X-User-Device"]; 
            [session.requestSerializer setValue:[HBBJUtility appVersion] forHTTPHeaderField:@"X-App-Version"];
        }];
    });
    return instance;
}
#pragma mark -
+ (void)getRequestWithFunctionPath:(NSString *)path
                            params:(NSDictionary *)params
                      successBlock:(BJServiceSuccessBlock)successBlock
                        errorBlock:(BJServiceErrorBlock)errorBlock {
    [[HBBJHTTPServiceEngine sharedInstance].httpEngine getRequestWithFunctionPath:path params:params successBlock:^(NSURLSessionDataTask *task, id responseData) {
#if ENABLE_REQUEST_LOG
        BJLog(@"get: path = %@,requsetHeader = %@, params = %@, data = %@", task.originalRequest.URL,task.originalRequest.allHTTPHeaderFields,params, responseData);
#endif
        NSDictionary *responseDict = responseData;
        NSString *code = responseDict[@"status"];
        if (!code || (code.length > 0 && [code isEqualToString:@"ok"])) {
            if (successBlock) {
                successBlock(responseData);
            }
        } else {
            HBBJError *errorObject = [HBBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        BJLog(@"get: path = %@, error = %@", path, error);
        if (errorBlock) {
            HBBJError *errorObject = [[HBBJError alloc] init];
            errorObject.code = error.code;
            errorObject.msg = @"请求失败"; 
            errorBlock(errorObject);
        }
    }];
}
+ (void)postRequestWithFunctionPath:(NSString *)path
                             params:(NSDictionary *)params
                       successBlock:(BJServiceSuccessBlock)successBlock
                         errorBlock:(BJServiceErrorBlock)errorBlock {
    [[HBBJHTTPServiceEngine sharedInstance].httpEngine postRequestWithFunctionPath:path params:params successBlock:^(NSURLSessionDataTask *task, id responseData) {
#if ENABLE_REQUEST_LOG
        BJLog(@"post: path = %@,requsetHeader = %@,data = %@", task.originalRequest.URL,task.originalRequest.HTTPBody, responseData);
#endif
        NSDictionary *responseDict = responseData;
        NSString *code = responseDict[@"status"];
        if (!code || (code.length > 0 && [code isEqualToString:@"ok"])) {
            if (successBlock) {
                successBlock(responseData);
            }
        } else {
            HBBJError *errorObject = [HBBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        BJLog(@"post: path = %@, error = %@,requsetHeader = %@", path, error,task.originalRequest.HTTPBody);
        if (errorBlock) {
            HBBJError *errorObject = [[HBBJError alloc] init];
            errorObject.code = error.code;
            errorObject.msg = @"请求失败"; 
            errorBlock(errorObject);
        }
    }];
}
+ (void)fileUploadWithFunctionPath:(NSString *)functionPath
                            params:(NSDictionary *)params
                          fileData:(NSData *)fileData
                          fileName:(NSString *)fileName
                          mimeType:(NSString *)mimeType
                     progressBlock:(BJHTTPProgressBlock)progressBlock
                      successBlock:(BJServiceSuccessBlock)successBlock
                        errorBlock:(BJServiceErrorBlock)errorBlock {
    [[HBBJHTTPServiceEngine sharedInstance].httpEngine fileUploadWithFunctionPath:functionPath params:params fileData:fileData fileName:fileName mimeType:mimeType progressBlock:^(float progress) {
        if (progressBlock) {
            progressBlock(progress);
        }
    } successBlock:^(NSURLSessionDataTask *task, id responseData) {
        NSDictionary *responseDict = responseData;
        NSString *code = responseDict[@"status"];
        if (!code || (code.length > 0 && [code isEqualToString:@"ok"])) {
            if (successBlock) {
                successBlock(responseData);
            }
        } else {
            HBBJError *errorObject = [HBBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        BJLog(@"file upload: path = %@, error = %@", functionPath, error);
        if (errorBlock) {
            HBBJError *errorObject = [[HBBJError alloc] init];
            errorObject.code = error.code;
            errorObject.msg = @"请求失败"; 
            errorBlock(errorObject);
        }
    }];
}
+ (void)imageUploadWithFunctionPath:(NSString *)functionPath
                             params:(NSDictionary *)params
                          imageData:(NSData *)imageData
                          imageName:(NSString *)imageName
                      progressBlock:(BJHTTPProgressBlock)progressBlock
                       successBlock:(BJServiceSuccessBlock)successBlock
                         errorBlock:(BJServiceErrorBlock)errorBlock {
    [[HBBJHTTPServiceEngine sharedInstance].httpEngine imageUploadWithFunctionPath:functionPath params:params imageData:imageData imageName:imageName progressBlock:^(float progress) {
        if (progressBlock) {
            progressBlock(progress);
        }
    } successBlock:^(NSURLSessionDataTask *task, id responseData) {
        NSDictionary *responseDict = responseData;
        NSString *code = responseDict[@"status"];
        if (!code || (code.length > 0 && [code isEqualToString:@"ok"])) {
            if (successBlock) {
                successBlock(responseData);
            }
        } else {
            HBBJError *errorObject = [HBBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        if (errorBlock) {
            HBBJError *errorObject = [[HBBJError alloc] init];
            errorObject.code = error.code;
            errorObject.msg = @"请求失败"; 
            errorBlock(errorObject);
        }
    }];
}
@end
