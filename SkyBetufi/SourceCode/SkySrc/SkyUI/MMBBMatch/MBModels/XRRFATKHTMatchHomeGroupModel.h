#import <Foundation/Foundation.h>
#import "XRRFATKHTMatchHomeModel.h"
@interface XRRFATKHTMatchHomeGroupModel : NSObject
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, strong) NSArray <XRRFATKHTMatchHomeModel *> *matchList;
@end
