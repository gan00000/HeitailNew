#import "HBDataHomeRequest+Mixcode.h"
@implementation HBDataHomeRequest (Mixcode)
+ (void)requestWithType:(NSInteger)type successBlock:(void(^)(HBDataHomeInfoModel *infoModel))successBlock errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
