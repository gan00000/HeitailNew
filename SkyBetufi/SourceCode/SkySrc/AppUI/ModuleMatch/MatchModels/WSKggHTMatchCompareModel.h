#import <Foundation/Foundation.h>
#import "TuTuosHTMatchDetailsModel.h"
@interface WSKggHTMatchCompareModel : NSObject
@property (nonatomic, strong) NSArray<TuTuosHTMatchDetailsModel *> *homeTeamDetails;
@property (nonatomic, strong) NSArray<TuTuosHTMatchDetailsModel *> *awayTeamDetails;
@end
