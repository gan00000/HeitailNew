#import "NSNiceBJHTTPServiceEngine.h"
#import "TuTuosBJServiceConfigurator.h"
#import "YYModel.h"
#import "AFHTTPSessionManager.h"
#import "BlysaBJUtility.h"
#import "KSasxBJBaseResponceModel.h"
@interface NSNiceBJHTTPServiceEngine ()
@property (nonatomic, strong) TuTuosBJBaseHTTPEngine *httpEngine;
@end
@implementation NSNiceBJHTTPServiceEngine
+ (instancetype)sharedInstance {
    static NSNiceBJHTTPServiceEngine *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NSNiceBJHTTPServiceEngine alloc] init];
        NSString *servicePath = [[TuTuosBJServiceConfigurator sharedInstance] serverBaseUrl];
        instance.httpEngine = [[TuTuosBJBaseHTTPEngine alloc] initWithBasePath:servicePath];
        [instance.httpEngine tao_updateSessionWithBlock:^(AFHTTPSessionManager *session) {
            session.requestSerializer.timeoutInterval = 30;
            [session.requestSerializer setValue:@"89bc52ca5b" forHTTPHeaderField:@"X-User-AppId"];
            [session.requestSerializer setValue:@"1" forHTTPHeaderField:@"X-User-Platform"];
            [session.requestSerializer setValue:[NSString stringWithFormat:@"%@|%@|%@", [BlysaBJUtility modelName], [BlysaBJUtility systemVersion], [BlysaBJUtility idfa]] forHTTPHeaderField:@"X-User-Device"]; 
            [session.requestSerializer setValue:[BlysaBJUtility appVersion] forHTTPHeaderField:@"X-App-Version"];
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
    [[NSNiceBJHTTPServiceEngine sharedInstance].httpEngine tao_getRequestWithFunctionPath:path params:allParams successBlock:^(NSURLSessionDataTask *task, id responseData) {
#if ENABLE_REQUEST_LOG
        BJLog(@"get: path = %@,requsetHeader = %@, params = %@, data = %@", task.originalRequest.URL,task.originalRequest.allHTTPHeaderFields,params, responseData);
#endif
        NSDictionary *responseDict = responseData;
        if (responseData) {
            if (successBlock) {
                successBlock(responseData);
            }
        } else {
            WSKggBJError *errorObject = [WSKggBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        BJLog(@"get: path = %@, error = %@", path, error);
        if (errorBlock) {
            WSKggBJError *errorObject = [[WSKggBJError alloc] init];
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
    if ([TuTuosHTUserManager tao_isUserLogin]) {
        allParams[@"token"] = [TuTuosHTUserManager tao_userToken];
    }
    if (params) {
        [allParams addEntriesFromDictionary:params];
    }
    if (!allParams.count) {
        allParams = [NSMutableDictionary dictionaryWithDictionary:@{@"token":@""}] ;
    }
    [[NSNiceBJHTTPServiceEngine sharedInstance].httpEngine tao_getRequestWithFunctionPath:path params:allParams successBlock:^(NSURLSessionDataTask *task, id responseData) {
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
            WSKggBJError *errorObject = [WSKggBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        BJLog(@"get: path = %@, error = %@", path, error);
        if (errorBlock) {
            WSKggBJError *errorObject = [[WSKggBJError alloc] init];
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
    if ([TuTuosHTUserManager tao_isUserLogin]) {
        allParams[@"token"] = [TuTuosHTUserManager tao_userToken];
    }
    if (params) {
        [allParams addEntriesFromDictionary:params];
    }
    [[NSNiceBJHTTPServiceEngine sharedInstance].httpEngine tao_postRequestWithFunctionPath:path params:allParams successBlock:^(NSURLSessionDataTask *task, id responseData) {
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
            WSKggBJError *errorObject = [WSKggBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        BJLog(@"post: path = %@, error = %@,requsetHeader = %@", path, error,task.originalRequest.HTTPBody);
        if (errorBlock) {
            WSKggBJError *errorObject = [[WSKggBJError alloc] init];
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
    [[NSNiceBJHTTPServiceEngine sharedInstance].httpEngine tao_fileUploadWithFunctionPath:functionPath params:params fileData:fileData fileName:fileName mimeType:mimeType progressBlock:^(float progress) {
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
            WSKggBJError *errorObject = [WSKggBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        BJLog(@"file upload: path = %@, error = %@", functionPath, error);
        if (errorBlock) {
            WSKggBJError *errorObject = [[WSKggBJError alloc] init];
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
    [[NSNiceBJHTTPServiceEngine sharedInstance].httpEngine tao_imageUploadWithFunctionPath:functionPath params:params imageData:imageData imageName:imageName progressBlock:^(float progress) {
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
            WSKggBJError *errorObject = [WSKggBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        if (errorBlock) {
            WSKggBJError *errorObject = [[WSKggBJError alloc] init];
            errorObject.code = error.code;
            errorObject.msg = @"请求失败"; 
            errorBlock(errorObject);
        }
    }];
}
@end
