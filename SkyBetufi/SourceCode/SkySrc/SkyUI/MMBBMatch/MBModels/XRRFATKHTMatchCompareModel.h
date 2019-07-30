#import <Foundation/Foundation.h>
#import "XRRFATKHTMatchDetailsModel.h"
@interface XRRFATKHTMatchCompareModel : NSObject
@property (nonatomic, strong) NSArray<XRRFATKHTMatchDetailsModel *> *homeTeamDetails;
@property (nonatomic, strong) NSArray<XRRFATKHTMatchDetailsModel *> *awayTeamDetails;
@end
