#import "SkyBallHetiRedBJHTTPServiceEngine.h"
#import "SkyBallHetiRedBJServiceConfigurator.h"
#import "YYModel.h"
#import "AFHTTPSessionManager.h"
#import "SkyBallHetiRedBJUtility.h"
#import "SkyBallHetiRedBJBaseResponceModel.h"
@interface SkyBallHetiRedBJHTTPServiceEngine ()
@property (nonatomic, strong) SkyBallHetiRedBJBaseHTTPEngine *httpEngine;
@end
@implementation SkyBallHetiRedBJHTTPServiceEngine
+ (instancetype)sharedInstance {
    static SkyBallHetiRedBJHTTPServiceEngine *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SkyBallHetiRedBJHTTPServiceEngine alloc] init];
        NSString *servicePath = [[SkyBallHetiRedBJServiceConfigurator sharedInstance] serverBaseUrl];
        instance.httpEngine = [[SkyBallHetiRedBJBaseHTTPEngine alloc] initWithBasePath:servicePath];
        [instance.httpEngine waterSky_updateSessionWithBlock:^(AFHTTPSessionManager *session) {
            session.requestSerializer.timeoutInterval = 30;
            [session.requestSerializer setValue:@"89bc52ca5b" forHTTPHeaderField:@"X-User-AppId"];
            [session.requestSerializer setValue:@"1" forHTTPHeaderField:@"X-User-Platform"];
            [session.requestSerializer setValue:[NSString stringWithFormat:@"%@|%@|%@", [SkyBallHetiRedBJUtility modelName], [SkyBallHetiRedBJUtility systemVersion], [SkyBallHetiRedBJUtility idfa]] forHTTPHeaderField:@"X-User-Device"]; 
            [session.requestSerializer setValue:[SkyBallHetiRedBJUtility appVersion] forHTTPHeaderField:@"X-App-Version"];
        }];
    });
    return instance;
}
#pragma mark -
+ (void)waterSky_getRequestCommon:(NSString *)path
                            params:(NSDictionary *)params
                      successBlock:(BJServiceSuccessBlock)successBlock
                        errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    if (params) {
        [allParams addEntriesFromDictionary:params];
    }
    [[SkyBallHetiRedBJHTTPServiceEngine sharedInstance].httpEngine waterSky_getRequestWithFunctionPath:path params:allParams successBlock:^(NSURLSessionDataTask *task, id responseData) {
#if ENABLE_REQUEST_LOG
        BJLog(@"get: path = %@,requsetHeader = %@, params = %@, data = %@", task.originalRequest.URL,task.originalRequest.allHTTPHeaderFields,params, responseData);
#endif
        NSDictionary *responseDict = responseData;
        if (responseData) {
            if (successBlock) {
                successBlock(responseData);
            }
        } else {
            SkyBallHetiRedBJError *errorObject = [SkyBallHetiRedBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        BJLog(@"get: path = %@, error = %@", path, error);
        if (errorBlock) {
            SkyBallHetiRedBJError *errorObject = [[SkyBallHetiRedBJError alloc] init];
            errorObject.code = error.code;
            errorObject.msg = @"请求失败"; 
            errorBlock(errorObject);
        }
    }];
}
#pragma mark -
+ (void)waterSky_getRequestWithFunctionPath:(NSString *)path
                            params:(NSDictionary *)params
                      successBlock:(BJServiceSuccessBlock)successBlock
                        errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    if ([SkyBallHetiRedHTUserManager waterSky_isUserLogin]) {
        allParams[@"token"] = [SkyBallHetiRedHTUserManager waterSky_userToken];
    }
    if (params) {
        [allParams addEntriesFromDictionary:params];
    }
    [[SkyBallHetiRedBJHTTPServiceEngine sharedInstance].httpEngine waterSky_getRequestWithFunctionPath:path params:allParams successBlock:^(NSURLSessionDataTask *task, id responseData) {
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
            SkyBallHetiRedBJError *errorObject = [SkyBallHetiRedBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        BJLog(@"get: path = %@, error = %@", path, error);
        if (errorBlock) {
            SkyBallHetiRedBJError *errorObject = [[SkyBallHetiRedBJError alloc] init];
            errorObject.code = error.code;
            errorObject.msg = @"请求失败"; 
            errorBlock(errorObject);
        }
    }];
}
+ (void)waterSky_postRequestWithFunctionPath:(NSString *)path
                             params:(NSDictionary *)params
                       successBlock:(BJServiceSuccessBlock)successBlock
                         errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    if ([SkyBallHetiRedHTUserManager waterSky_isUserLogin]) {
        allParams[@"token"] = [SkyBallHetiRedHTUserManager waterSky_userToken];
    }
    if (params) {
        [allParams addEntriesFromDictionary:params];
    }
    [[SkyBallHetiRedBJHTTPServiceEngine sharedInstance].httpEngine waterSky_postRequestWithFunctionPath:path params:allParams successBlock:^(NSURLSessionDataTask *task, id responseData) {
#if ENABLE_REQUEST_LOG
        NSLog(@"post: path = %@,requsetHeader = %@,data = %@", task.originalRequest.URL,task.originalRequest.HTTPBody, responseData);
#endif
        NSDictionary *responseDict = responseData;
        NSString *code = responseDict[@"status"];
        if (!code || (code.length > 0 && [code isEqualToString:@"ok"])) {
            if (successBlock) {
                successBlock(responseData);
            }
        } else {
            SkyBallHetiRedBJError *errorObject = [SkyBallHetiRedBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        BJLog(@"post: path = %@, error = %@,requsetHeader = %@", path, error,task.originalRequest.HTTPBody);
        if (errorBlock) {
            SkyBallHetiRedBJError *errorObject = [[SkyBallHetiRedBJError alloc] init];
            errorObject.code = error.code;
            errorObject.msg = @"请求失败"; 
            errorBlock(errorObject);
        }
    }];
}
+ (void)waterSky_fileUploadWithFunctionPath:(NSString *)functionPath
                            params:(NSDictionary *)params
                          fileData:(NSData *)fileData
                          fileName:(NSString *)fileName
                          mimeType:(NSString *)mimeType
                     progressBlock:(BJHTTPProgressBlock)progressBlock
                      successBlock:(BJServiceSuccessBlock)successBlock
                        errorBlock:(BJServiceErrorBlock)errorBlock {
    [[SkyBallHetiRedBJHTTPServiceEngine sharedInstance].httpEngine waterSky_fileUploadWithFunctionPath:functionPath params:params fileData:fileData fileName:fileName mimeType:mimeType progressBlock:^(float progress) {
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
            SkyBallHetiRedBJError *errorObject = [SkyBallHetiRedBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        BJLog(@"file upload: path = %@, error = %@", functionPath, error);
        if (errorBlock) {
            SkyBallHetiRedBJError *errorObject = [[SkyBallHetiRedBJError alloc] init];
            errorObject.code = error.code;
            errorObject.msg = @"请求失败"; 
            errorBlock(errorObject);
        }
    }];
}
+ (void)waterSky_imageUploadWithFunctionPath:(NSString *)functionPath
                             params:(NSDictionary *)params
                          imageData:(NSData *)imageData
                          imageName:(NSString *)imageName
                      progressBlock:(BJHTTPProgressBlock)progressBlock
                       successBlock:(BJServiceSuccessBlock)successBlock
                         errorBlock:(BJServiceErrorBlock)errorBlock {
    [[SkyBallHetiRedBJHTTPServiceEngine sharedInstance].httpEngine waterSky_imageUploadWithFunctionPath:functionPath params:params imageData:imageData imageName:imageName progressBlock:^(float progress) {
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
            SkyBallHetiRedBJError *errorObject = [SkyBallHetiRedBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        if (errorBlock) {
            SkyBallHetiRedBJError *errorObject = [[SkyBallHetiRedBJError alloc] init];
            errorObject.code = error.code;
            errorObject.msg = @"请求失败"; 
            errorBlock(errorObject);
        }
    }];
}
@end
