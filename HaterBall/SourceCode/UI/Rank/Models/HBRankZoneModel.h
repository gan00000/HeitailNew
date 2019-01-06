#import <Foundation/Foundation.h>
#import "HBRankModel.h"
@interface HBRankZoneModel : NSObject
@property (nonatomic, strong) NSArray<HBRankModel *> *EasternAtlantic;
@property (nonatomic, strong) NSArray<HBRankModel *> *EasternCentral;
@property (nonatomic, strong) NSArray<HBRankModel *> *EasternSoutheast;
@property (nonatomic, strong) NSArray<HBRankModel *> *WesternNorthwest;
@property (nonatomic, strong) NSArray<HBRankModel *> *WesternPacific;
@property (nonatomic, strong) NSArray<HBRankModel *> *WesternSouthwest;
@end
