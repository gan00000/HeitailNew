#import <Foundation/Foundation.h>
#import "SundayHTMatchDetailsModel.h"
@interface PXFunHTMatchCompareModel : NSObject
@property (nonatomic, strong) NSArray<SundayHTMatchDetailsModel *> *homeTeamDetails;
@property (nonatomic, strong) NSArray<SundayHTMatchDetailsModel *> *awayTeamDetails;
@end
