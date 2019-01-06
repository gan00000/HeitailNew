#import <Foundation/Foundation.h>
#import "HBMatchDetailsModel.h"
@interface HBMatchCompareModel : NSObject
@property (nonatomic, strong) NSArray<HBMatchDetailsModel *> *homeTeamDetails;
@property (nonatomic, strong) NSArray<HBMatchDetailsModel *> *awayTeamDetails;
@end
