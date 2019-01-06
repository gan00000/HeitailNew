#import <Foundation/Foundation.h>
@interface NSURLConnection (BlocksKit)
@property (nonatomic, weak, setter = setDelegate:) id delegate;
@property (nonatomic, copy, setter = bk_setResponseBlock:) void (^bk_responseBlock)(NSURLConnection *connection, NSURLResponse *response);
@property (nonatomic, copy, setter = bk_setFailureBlock:) void (^bk_failureBlock)(NSURLConnection *connection, NSError *error);
@property (nonatomic, copy, setter = bk_setSuccessBlock:) void (^bk_successBlock)(NSURLConnection *connection, NSURLResponse *response, NSData *responseData);
@property (nonatomic, copy, setter = bk_setUploadBlock:) void (^bk_uploadBlock)(double percent);
@property (nonatomic, copy, setter = bk_setDownloadBlock:) void (^bk_downloadBlock)(double percent);
+ (NSURLConnection *)bk_connectionWithRequest:(NSURLRequest *)request;
+ (NSURLConnection *)bk_startConnectionWithRequest:(NSURLRequest *)request successHandler:(void (^)(NSURLConnection *connection, NSURLResponse *response, NSData *responseData))success failureHandler:(void (^)(NSURLConnection *connection, NSError *error))failure;
- (id)bk_initWithRequest:(NSURLRequest *)request NS_REPLACES_RECEIVER;
- (id)bk_initWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLConnection *connection, NSURLResponse *response, NSData *responseData))block NS_REPLACES_RECEIVER;
- (void)bk_startWithCompletionBlock:(void (^)(NSURLConnection *connection, NSURLResponse *response, NSData *responseData))block;
@end
