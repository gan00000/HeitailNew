#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKBJServiceConfigurator.h"
#import "YYModel.h"
#import "AFHTTPSessionManager.h"
#import "XRRFATKBJUtility.h"
#import "XRRFATKBJBaseResponceModel.h"
@interface XRRFATKBJHTTPServiceEngine ()
@property (nonatomic, strong) XRRFATKBJBaseHTTPEngine *httpEngine;
@end
@implementation XRRFATKBJHTTPServiceEngine
+ (instancetype)sharedInstance {
    static XRRFATKBJHTTPServiceEngine *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XRRFATKBJHTTPServiceEngine alloc] init];
        NSString *servicePath = [[XRRFATKBJServiceConfigurator sharedInstance] serverBaseUrl];
        instance.httpEngine = [[XRRFATKBJBaseHTTPEngine alloc] initWithBasePath:servicePath];
        [instance.httpEngine skarg_updateSessionWithBlock:^(AFHTTPSessionManager *session) {
            session.requestSerializer.timeoutInterval = 30;
            [session.requestSerializer setValue:@"89bc52ca5b" forHTTPHeaderField:@"X-User-AppId"];
            [session.requestSerializer setValue:@"1" forHTTPHeaderField:@"X-User-Platform"];
            [session.requestSerializer setValue:[NSString stringWithFormat:@"%@|%@|%@", [XRRFATKBJUtility modelName], [XRRFATKBJUtility systemVersion], [XRRFATKBJUtility idfa]] forHTTPHeaderField:@"X-User-Device"]; 
            [session.requestSerializer setValue:[XRRFATKBJUtility appVersion] forHTTPHeaderField:@"X-App-Version"];
        }];
    });
    return instance;
}
#pragma mark -
+ (void)skarg_getRequestCommon:(NSString *)path
                            params:(NSDictionary *)params
                      successBlock:(BJServiceSuccessBlock)successBlock
                        errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    if (params) {
        [allParams addEntriesFromDictionary:params];
    }
    [[XRRFATKBJHTTPServiceEngine sharedInstance].httpEngine skarg_getRequestWithFunctionPath:path params:allParams successBlock:^(NSURLSessionDataTask *task, id responseData) {
#if ENABLE_REQUEST_LOG
        BJLog(@"get: path = %@,requsetHeader = %@, params = %@, data = %@", task.originalRequest.URL,task.originalRequest.allHTTPHeaderFields,params, responseData);
#endif
        NSDictionary *responseDict = responseData;
        if (responseData) {
            if (successBlock) {
                successBlock(responseData);
            }
        } else {
            XRRFATKBJError *errorObject = [XRRFATKBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        BJLog(@"get: path = %@, error = %@", path, error);
        if (errorBlock) {
            XRRFATKBJError *errorObject = [[XRRFATKBJError alloc] init];
            errorObject.code = error.code;
            errorObject.msg = @"请求失败"; 
            errorBlock(errorObject);
        }
    }];
}
#pragma mark -
+ (void)skarg_getRequestWithFunctionPath:(NSString *)path
                            params:(NSDictionary *)params
                      successBlock:(BJServiceSuccessBlock)successBlock
                        errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    if ([XRRFATKHTUserManager skarg_isUserLogin]) {
        allParams[@"token"] = [XRRFATKHTUserManager skarg_userToken];
    }
    if (params) {
        [allParams addEntriesFromDictionary:params];
    }
    [[XRRFATKBJHTTPServiceEngine sharedInstance].httpEngine skarg_getRequestWithFunctionPath:path params:allParams successBlock:^(NSURLSessionDataTask *task, id responseData) {
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
            XRRFATKBJError *errorObject = [XRRFATKBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        BJLog(@"get: path = %@, error = %@", path, error);
        if (errorBlock) {
            XRRFATKBJError *errorObject = [[XRRFATKBJError alloc] init];
            errorObject.code = error.code;
            errorObject.msg = @"请求失败"; 
            errorBlock(errorObject);
        }
    }];
}
+ (void)skarg_postRequestWithFunctionPath:(NSString *)path
                             params:(NSDictionary *)params
                       successBlock:(BJServiceSuccessBlock)successBlock
                         errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    if ([XRRFATKHTUserManager skarg_isUserLogin]) {
        allParams[@"token"] = [XRRFATKHTUserManager skarg_userToken];
    }
    if (params) {
        [allParams addEntriesFromDictionary:params];
    }
    [[XRRFATKBJHTTPServiceEngine sharedInstance].httpEngine skarg_postRequestWithFunctionPath:path params:allParams successBlock:^(NSURLSessionDataTask *task, id responseData) {
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
            XRRFATKBJError *errorObject = [XRRFATKBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        BJLog(@"post: path = %@, error = %@,requsetHeader = %@", path, error,task.originalRequest.HTTPBody);
        if (errorBlock) {
            XRRFATKBJError *errorObject = [[XRRFATKBJError alloc] init];
            errorObject.code = error.code;
            errorObject.msg = @"请求失败"; 
            errorBlock(errorObject);
        }
    }];
}
+ (void)skarg_fileUploadWithFunctionPath:(NSString *)functionPath
                            params:(NSDictionary *)params
                          fileData:(NSData *)fileData
                          fileName:(NSString *)fileName
                          mimeType:(NSString *)mimeType
                     progressBlock:(BJHTTPProgressBlock)progressBlock
                      successBlock:(BJServiceSuccessBlock)successBlock
                        errorBlock:(BJServiceErrorBlock)errorBlock {
    [[XRRFATKBJHTTPServiceEngine sharedInstance].httpEngine skarg_fileUploadWithFunctionPath:functionPath params:params fileData:fileData fileName:fileName mimeType:mimeType progressBlock:^(float progress) {
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
            XRRFATKBJError *errorObject = [XRRFATKBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        BJLog(@"file upload: path = %@, error = %@", functionPath, error);
        if (errorBlock) {
            XRRFATKBJError *errorObject = [[XRRFATKBJError alloc] init];
            errorObject.code = error.code;
            errorObject.msg = @"请求失败"; 
            errorBlock(errorObject);
        }
    }];
}
+ (void)skarg_imageUploadWithFunctionPath:(NSString *)functionPath
                             params:(NSDictionary *)params
                          imageData:(NSData *)imageData
                          imageName:(NSString *)imageName
                      progressBlock:(BJHTTPProgressBlock)progressBlock
                       successBlock:(BJServiceSuccessBlock)successBlock
                         errorBlock:(BJServiceErrorBlock)errorBlock {
    [[XRRFATKBJHTTPServiceEngine sharedInstance].httpEngine skarg_imageUploadWithFunctionPath:functionPath params:params imageData:imageData imageName:imageName progressBlock:^(float progress) {
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
            XRRFATKBJError *errorObject = [XRRFATKBJError yy_modelWithDictionary:responseDict];
            if (errorBlock) {
                errorBlock(errorObject);
            }
        }
    } errorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        if (errorBlock) {
            XRRFATKBJError *errorObject = [[XRRFATKBJError alloc] init];
            errorObject.code = error.code;
            errorObject.msg = @"请求失败"; 
            errorBlock(errorObject);
        }
    }];
}
@end
