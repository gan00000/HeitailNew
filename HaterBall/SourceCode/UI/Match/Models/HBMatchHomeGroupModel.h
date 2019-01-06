#import <Foundation/Foundation.h>
#import "HBMatchHomeModel.h"
@interface HBMatchHomeGroupModel : NSObject
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, strong) NSArray <HBMatchHomeModel *> *matchList;
@end
