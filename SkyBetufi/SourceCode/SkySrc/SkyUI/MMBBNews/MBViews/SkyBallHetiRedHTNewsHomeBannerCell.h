#import <UIKit/UIKit.h>
#import "SkyBallHetiRedHTNewsModel.h"
@interface SkyBallHetiRedHTNewsHomeBannerCell : UITableViewCell
@property (nonatomic, copy) void(^onBannerTappedBlock)(SkyBallHetiRedHTNewsModel *newsModel);
- (void)waterSkysetupWithNewsModels:(NSArray *)bannerList;
@end
