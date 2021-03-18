#import <UIKit/UIKit.h>
#import "GlodBuleHTNewsModel.h"
#import "PLPlayerView.h"
#import "PLMediaInfo.h"

@class GlodBuleHTFilmHomeCell;

@protocol PLLongMediaTableViewCellDelegate <NSObject>

- (void)tableViewWillPlay:(GlodBuleHTFilmHomeCell *)cell;

- (void)tableViewCellEnterFullScreen:(GlodBuleHTFilmHomeCell *)cell;

- (void)tableViewCellExitFullScreen:(GlodBuleHTFilmHomeCell *)cell;

@end


@interface GlodBuleHTFilmHomeCell : UITableViewCell
- (void)taosetupWithNewsModel:(GlodBuleHTNewsModel *)newsModel;

@property (nonatomic, weak) id<PLLongMediaTableViewCellDelegate> delegate;

@property (nonatomic, strong) PLMediaInfo *media;

- (void)play;

- (void)stop;

- (void)configureVideo:(BOOL)enableRender;

+ (CGFloat)headerViewHeight;
@end
