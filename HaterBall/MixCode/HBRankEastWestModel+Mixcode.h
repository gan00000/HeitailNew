#import <Foundation/Foundation.h>
#import "HBRankModel.h"
#import "HBRankEastWestModel.h"

@interface HBRankEastWestModel (Mixcode)
+ (void)modelContainerPropertyGenericClassMixcode:(NSString *)mixcode;
- (void)setEastern:(NSArray<HBRankModel *> *)Eastern mixcode:(NSString *)mixcode;
- (void)setWestern:(NSArray<HBRankModel *> *)Western mixcode:(NSString *)mixcode;

@end
