#import <Foundation/Foundation.h>
#import "HBRankModel.h"
@interface HBRankEastWestModel : NSObject
@property (nonatomic, strong) NSArray<HBRankModel *> *Eastern;
@property (nonatomic, strong) NSArray<HBRankModel *> *Western;
@end
