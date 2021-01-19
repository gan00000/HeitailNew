#import <UIKit/UIKit.h>
#import "GlodBuleHTNewsModel.h"
@interface GlodBuleHTNewsHomeBannerCell : UITableViewCell
@property (nonatomic, copy) void(^onBannerTappedBlock)(GlodBuleHTNewsModel *newsModel);
- (void)taosetupWithNewsModels:(NSArray *)bannerList;
@end
