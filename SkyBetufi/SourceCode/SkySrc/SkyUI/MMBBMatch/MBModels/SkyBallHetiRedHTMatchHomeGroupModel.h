#import <Foundation/Foundation.h>
#import "SkyBallHetiRedHTMatchHomeModel.h"
@interface SkyBallHetiRedHTMatchHomeGroupModel : NSObject
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, strong) NSArray <SkyBallHetiRedHTMatchHomeModel *> *matchList;
@end
