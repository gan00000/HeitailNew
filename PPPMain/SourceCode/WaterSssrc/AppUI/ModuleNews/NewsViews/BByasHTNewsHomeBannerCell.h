#import <UIKit/UIKit.h>
#import "CfipyHTNewsModel.h"
@interface BByasHTNewsHomeBannerCell : UITableViewCell
@property (nonatomic, copy) void(^onBannerTappedBlock)(CfipyHTNewsModel *newsModel);
- (void)taosetupWithNewsModels:(NSArray *)bannerList;
@end
