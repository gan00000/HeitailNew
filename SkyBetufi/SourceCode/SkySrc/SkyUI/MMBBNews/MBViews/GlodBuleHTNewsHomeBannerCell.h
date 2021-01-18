#import <UIKit/UIKit.h>
#import "GlodBuleHTNewsModel.h"
@interface GlodBuleHTNewsHomeBannerCell : UITableViewCell
@property (nonatomic, copy) void(^onBannerTappedBlock)(GlodBuleHTNewsModel *newsModel);
- (void)waterSkysetupWithNewsModels:(NSArray *)bannerList;
@end
