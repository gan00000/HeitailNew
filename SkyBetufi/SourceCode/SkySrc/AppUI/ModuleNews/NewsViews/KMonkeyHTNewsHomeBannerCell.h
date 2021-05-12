#import <UIKit/UIKit.h>
#import "PXFunHTNewsModel.h"
@interface KMonkeyHTNewsHomeBannerCell : UITableViewCell
@property (nonatomic, copy) void(^onBannerTappedBlock)(PXFunHTNewsModel *newsModel);
- (void)taosetupWithNewsModels:(NSArray *)bannerList;
@end
