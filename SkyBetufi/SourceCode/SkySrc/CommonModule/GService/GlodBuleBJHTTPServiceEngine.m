#import "GlodBuleBJHTTPServiceEngine.h"
#import "GlodBuleBJServiceConfigurator.h"
#import "YYModel.h"
#import "AFHTTPSessionManager.h"
#import "GlodBuleBJUtility.h"
#import "GlodBuleBJBaseResponceModel.h"
@interface GlodBuleBJHTTPServiceEngine ()
@property (nonatomic, strong) GlodBuleBJBaseHTTPEngine *httpEngine;
@end
@implementation GlodBuleBJHTTPServiceEngine
+ (instancetype)sharedInstance {
    static GlodBuleBJHTTPServiceEngine *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GlodBuleBJHTTPServiceEngine alloc] init];
        NSString *servicePath = [[GlodBuleBJServiceConfigurator sharedInstance] serverBaseUrl];
        instance.httpEngine = [[GlodBuleBJBaseHTTPEngine alloc] initWithBasePath:servicePath];
        [instance.httpEngine tao_updateSessionWithBlock:^(AFHTTPSessionManager *session) {
            session.requestSerializer.timeoutInterval = 30;
            [session.requestSerializer setValue:@"89bc52ca5b" forHTTPHeaderField:@"X-User-AppId"];
            [session.requestSerializer setValue:@"1" forHTTPHeaderField:@"X-User-Platform"];
            [session.requestSerializer setValue:[NSString stringWithFormat:@"%@|%@|%@", [GlodBuleBJUtility modelName], [GlodBuleBJUtility systemVersion], [GlodBuleBJUtility idfa]] forHTTPHeaderField:@"X-User-Device"]; 
            [session.requestSerializer setValue:[GlodBuleBJUtility appVersion] forHTTPHeaderField:@"X-App-Version"];
        }];
    });
    return instance;
}
#pragma mark -
+ (void)tao_getRequestCommon:(NSString *)path
                            params:(NSDictionary *)params
                      successBlock:(BJServiceSuccessBlock)successBlock
                        errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    if (params) {
        [allParams addEntriesFromDictionary:params];
    }
    [[GlodBuleBJHTTPServiceEngine sharedInstance].httpEngine tao_getRequestWithFunctionPath:path params:allParams successBlock:^(NSURLSessionDataTask *task, id responseData) {
#if ENABLE_REQUEST_LOG
        BJLog(@"get: path = %@,requsetHeader = %@, params = %@, data = %@", task.originalRequest.URL,task.originalRequest.allHTTPHeaderFields,params, responseData);
#endif
        NSDictionary *responseDict = responseData;
        if (responseData) {
            if (successBlock) {
                successBlock(responseData);
            }
        } else {
            GlodBuleBJError *errorObject = [GlodBuleBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        BJLog(@"get: path = %@, error = %@", path, error);
        if (errorBlock) {
            GlodBuleBJError *errorObject = [[GlodBuleBJError alloc] init];
            errorObject.code = error.code;
            errorObject.msg = @"请求失败"; 
            errorBlock(errorObject);
        }
    }];
}
#pragma mark -
+ (void)tao_getRequestWithFunctionPath:(NSString *)path
                            params:(NSDictionary *)params
                      successBlock:(BJServiceSuccessBlock)successBlock
                        errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    if ([GlodBuleHTUserManager tao_isUserLogin]) {
        allParams[@"token"] = [GlodBuleHTUserManager tao_userToken];
    }
    if (params) {
        [allParams addEntriesFromDictionary:params];
    }
    if (!allParams.count) {
        allParams = [NSMutableDictionary dictionaryWithDictionary:@{@"token":@""}] ;
    }
    [[GlodBuleBJHTTPServiceEngine sharedInstance].httpEngine tao_getRequestWithFunctionPath:path params:allParams successBlock:^(NSURLSessionDataTask *task, id responseData) {
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
            GlodBuleBJError *errorObject = [GlodBuleBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        BJLog(@"get: path = %@, error = %@", path, error);
        if (errorBlock) {
            GlodBuleBJError *errorObject = [[GlodBuleBJError alloc] init];
            errorObject.code = error.code;
            errorObject.msg = @"请求失败"; 
            errorBlock(errorObject);
        }
    }];
}
+ (void)tao_postRequestWithFunctionPath:(NSString *)path
                             params:(NSDictionary *)params
                       successBlock:(BJServiceSuccessBlock)successBlock
                         errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    if ([GlodBuleHTUserManager tao_isUserLogin]) {
        allParams[@"token"] = [GlodBuleHTUserManager tao_userToken];
    }
    if (params) {
        [allParams addEntriesFromDictionary:params];
    }
    [[GlodBuleBJHTTPServiceEngine sharedInstance].httpEngine tao_postRequestWithFunctionPath:path params:allParams successBlock:^(NSURLSessionDataTask *task, id responseData) {
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
            GlodBuleBJError *errorObject = [GlodBuleBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        BJLog(@"post: path = %@, error = %@,requsetHeader = %@", path, error,task.originalRequest.HTTPBody);
        if (errorBlock) {
            GlodBuleBJError *errorObject = [[GlodBuleBJError alloc] init];
            errorObject.code = error.code;
            errorObject.msg = @"请求失败"; 
            errorBlock(errorObject);
        }
    }];
}
+ (void)tao_fileUploadWithFunctionPath:(NSString *)functionPath
                            params:(NSDictionary *)params
                          fileData:(NSData *)fileData
                          fileName:(NSString *)fileName
                          mimeType:(NSString *)mimeType
                     progressBlock:(BJHTTPProgressBlock)progressBlock
                      successBlock:(BJServiceSuccessBlock)successBlock
                        errorBlock:(BJServiceErrorBlock)errorBlock {
    [[GlodBuleBJHTTPServiceEngine sharedInstance].httpEngine tao_fileUploadWithFunctionPath:functionPath params:params fileData:fileData fileName:fileName mimeType:mimeType progressBlock:^(float progress) {
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
            GlodBuleBJError *errorObject = [GlodBuleBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        BJLog(@"file upload: path = %@, error = %@", functionPath, error);
        if (errorBlock) {
            GlodBuleBJError *errorObject = [[GlodBuleBJError alloc] init];
            errorObject.code = error.code;
            errorObject.msg = @"请求失败"; 
            errorBlock(errorObject);
        }
    }];
}
+ (void)tao_imageUploadWithFunctionPath:(NSString *)functionPath
                             params:(NSDictionary *)params
                          imageData:(NSData *)imageData
                          imageName:(NSString *)imageName
                      progressBlock:(BJHTTPProgressBlock)progressBlock
                       successBlock:(BJServiceSuccessBlock)successBlock
                         errorBlock:(BJServiceErrorBlock)errorBlock {
    [[GlodBuleBJHTTPServiceEngine sharedInstance].httpEngine tao_imageUploadWithFunctionPath:functionPath params:params imageData:imageData imageName:imageName progressBlock:^(float progress) {
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
            GlodBuleBJError *errorObject = [GlodBuleBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        if (errorBlock) {
            GlodBuleBJError *errorObject = [[GlodBuleBJError alloc] init];
            errorObject.code = error.code;
            errorObject.msg = @"请求失败"; 
            errorBlock(errorObject);
        }
    }];
}
@end
