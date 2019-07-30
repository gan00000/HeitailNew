#import <Foundation/Foundation.h>
#import "XRRFATKBJBaseHTTPEngine.h"
#import "XRRFATKBJError.h"
#import "BJAPIAddress.h"
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKBJServiceConfigurator.h"
#import "YYModel.h"
#import "AFHTTPSessionManager.h"
#import "XRRFATKBJUtility.h"
#import "XRRFATKBJBaseResponceModel.h"

@interface XRRFATKBJHTTPServiceEngine (Bwyyr)
+ (BOOL)sharedInstanceBwyyr:(NSInteger)Bwyyr;
+ (BOOL)skarg_getRequestCommonParamsSuccessblockErrorblockBwyyr:(NSInteger)Bwyyr;
+ (BOOL)skarg_getRequestWithFunctionPathParamsSuccessblockErrorblockBwyyr:(NSInteger)Bwyyr;
+ (BOOL)skarg_postRequestWithFunctionPathParamsSuccessblockErrorblockBwyyr:(NSInteger)Bwyyr;
+ (BOOL)skarg_fileUploadWithFunctionPathParamsFiledataFilenameMimetypeProgressblockSuccessblockErrorblockBwyyr:(NSInteger)Bwyyr;
+ (BOOL)skarg_imageUploadWithFunctionPathParamsImagedataImagenameProgressblockSuccessblockErrorblockBwyyr:(NSInteger)Bwyyr;

@end
