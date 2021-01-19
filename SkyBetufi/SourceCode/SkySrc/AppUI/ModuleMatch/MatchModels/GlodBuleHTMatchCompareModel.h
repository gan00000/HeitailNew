#import <Foundation/Foundation.h>
#import "GlodBuleHTMatchDetailsModel.h"
@interface GlodBuleHTMatchCompareModel : NSObject
@property (nonatomic, strong) NSArray<GlodBuleHTMatchDetailsModel *> *homeTeamDetails;
@property (nonatomic, strong) NSArray<GlodBuleHTMatchDetailsModel *> *awayTeamDetails;
@end
