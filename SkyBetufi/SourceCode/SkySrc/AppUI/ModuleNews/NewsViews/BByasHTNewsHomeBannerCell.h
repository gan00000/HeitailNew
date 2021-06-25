#import <UIKit/UIKit.h>
#import "UUaksHTNewsModel.h"
@interface BByasHTNewsHomeBannerCell : UITableViewCell
@property (nonatomic, copy) void(^onBannerTappedBlock)(UUaksHTNewsModel *newsModel);
- (void)taosetupWithNewsModels:(NSArray *)bannerList;
@end
