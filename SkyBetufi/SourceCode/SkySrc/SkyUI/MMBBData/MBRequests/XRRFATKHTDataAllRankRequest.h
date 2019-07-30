#import <Foundation/Foundation.h>
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKHTDataTeamRankModel.h"
#import "XRRFATKHTDataPlayerRankModel.h"
@interface XRRFATKHTDataAllRankRequest : NSObject
+ (void)skargrequestAllTeamRankDataWithType:(NSString *)type
                          successBlock:(void(^)(NSArray<XRRFATKHTDataTeamRankModel *> *allTeamRankList))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock;
+ (void)requestAllPlayerRankDataWithType:(NSString *)type
                            successBlock:(void(^)(NSArray<XRRFATKHTDataPlayerRankModel *> *allPlayerRankList))successBlock
                              errorBlock:(BJServiceErrorBlock)errorBlock;
@end
