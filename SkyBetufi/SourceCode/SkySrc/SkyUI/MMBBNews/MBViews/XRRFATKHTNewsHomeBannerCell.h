#import <UIKit/UIKit.h>
#import "XRRFATKHTNewsModel.h"
@interface XRRFATKHTNewsHomeBannerCell : UITableViewCell
@property (nonatomic, copy) void(^onBannerTappedBlock)(XRRFATKHTNewsModel *newsModel);
- (void)skargsetupWithNewsModels:(NSArray *)bannerList;
@end
