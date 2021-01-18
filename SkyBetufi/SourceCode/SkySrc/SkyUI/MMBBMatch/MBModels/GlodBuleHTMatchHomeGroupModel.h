#import <Foundation/Foundation.h>
#import "GlodBuleHTMatchHomeModel.h"
@interface GlodBuleHTMatchHomeGroupModel : NSObject
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, strong) NSArray <GlodBuleHTMatchHomeModel *> *matchList;
@end
