#import <Foundation/Foundation.h>
#import "HBRankModel.h"
#import "HBRankZoneModel.h"

@interface HBRankZoneModel (Mixcode)
+ (void)modelContainerPropertyGenericClassMixcode:(NSString *)mixcode;
- (void)setEasternAtlantic:(NSArray<HBRankModel *> *)EasternAtlantic mixcode:(NSString *)mixcode;
- (void)setEasternCentral:(NSArray<HBRankModel *> *)EasternCentral mixcode:(NSString *)mixcode;
- (void)setEasternSoutheast:(NSArray<HBRankModel *> *)EasternSoutheast mixcode:(NSString *)mixcode;
- (void)setWesternPacific:(NSArray<HBRankModel *> *)WesternPacific mixcode:(NSString *)mixcode;
- (void)setWesternSouthwest:(NSArray<HBRankModel *> *)WesternSouthwest mixcode:(NSString *)mixcode;
- (void)setWesternNorthwest:(NSArray<HBRankModel *> *)WesternNorthwest mixcode:(NSString *)mixcode;

@end
