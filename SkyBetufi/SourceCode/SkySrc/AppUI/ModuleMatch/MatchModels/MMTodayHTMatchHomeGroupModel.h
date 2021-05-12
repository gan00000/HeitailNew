#import <Foundation/Foundation.h>
#import "SundayHTMatchHomeModel.h"
@interface MMTodayHTMatchHomeGroupModel : NSObject
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, strong) NSArray <SundayHTMatchHomeModel *> *matchList;
@end
