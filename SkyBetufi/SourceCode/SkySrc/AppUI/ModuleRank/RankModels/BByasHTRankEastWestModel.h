#import <Foundation/Foundation.h>
#import "CfipyHTRankModel.h"
@interface BByasHTRankEastWestModel : NSObject
@property (nonatomic, strong) NSArray<CfipyHTRankModel *> *Eastern;
@property (nonatomic, strong) NSArray<CfipyHTRankModel *> *Western;
@end
