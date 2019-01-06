#import <UIKit/UIKit.h>
#import "HBNewsModel.h"
@interface HBNewsHomeBannerCell : UITableViewCell
@property (nonatomic, copy) void(^onBannerTappedBlock)(HBNewsModel *newsModel);
- (void)setupWithNewsModels:(NSArray *)bannerList;
@end
