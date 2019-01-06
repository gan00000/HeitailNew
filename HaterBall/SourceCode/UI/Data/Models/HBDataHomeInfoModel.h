#import <Foundation/Foundation.h>
#import "HBDataHomeModel.h"
@interface HBDataHomeInfoModel : NSObject
@property (nonatomic, strong) NSArray<HBDataHomeModel *> *pts;
@property (nonatomic, strong) NSArray<HBDataHomeModel *> *reb;
@property (nonatomic, strong) NSArray<HBDataHomeModel *> *ast;
@property (nonatomic, strong) NSArray<HBDataHomeModel *> *stl;
@property (nonatomic, strong) NSArray<HBDataHomeModel *> *blk;
@property (nonatomic, strong) NSArray<HBDataHomeModel *> *turnover;
@end
