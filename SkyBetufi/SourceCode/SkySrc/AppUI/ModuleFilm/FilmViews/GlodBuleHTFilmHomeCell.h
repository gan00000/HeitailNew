#import <UIKit/UIKit.h>
#import "GlodBuleHTNewsModel.h"
#import "PLPlayerView.h"
#import "PLMediaInfo.h"

@class GlodBuleHTFilmHomeCell;

@protocol PlayerTableViewCellDelegate <NSObject>

- (void)tableViewWillPlay:(GlodBuleHTFilmHomeCell *)cell;

- (void)tableViewCellEnterFullScreen:(GlodBuleHTFilmHomeCell *)cell;

- (void)tableViewCellExitFullScreen:(GlodBuleHTFilmHomeCell *)cell;

@end


@interface GlodBuleHTFilmHomeCell : UITableViewCell

@property (strong, nonatomic) id<PlayerTableViewCellDelegate> mPlayerTableViewCellDelegate;

- (void)taosetupWithNewsModel:(GlodBuleHTNewsModel *)newsModel;
+ (CGFloat)headerViewHeight;

- (void)play;

- (void)stop;

- (void)pause;

@end
