#import <UIKit/UIKit.h>
#import "GlodBuleHTNewsModel.h"
#import "PLPlayerView.h"
#import "PLMediaInfo.h"
#import "YSPlayerController.h"

@class GlodBuleHTFilmHomeCell;

@protocol PlayerTableViewCellDelegate <NSObject>

- (void)tableViewWillPlay:(GlodBuleHTFilmHomeCell *)cell;

- (void)tableViewCellEnterFullScreen:(GlodBuleHTFilmHomeCell *)cell;

- (void)tableViewCellExitFullScreen:(GlodBuleHTFilmHomeCell *)cell;

@end


@interface GlodBuleHTFilmHomeCell : UITableViewCell

@property (nonatomic, copy) NSString *news_id;

@property (strong, nonatomic) id<PlayerTableViewCellDelegate> mPlayerTableViewCellDelegate;
@property (weak, nonatomic) IBOutlet UIImageView *addSaveImageView;
@property (weak, nonatomic) IBOutlet UIButton *addSaveBtn;

@property (strong, nonatomic) YSPlayerController *playerController;

- (void)taosetupWithNewsModel:(GlodBuleHTNewsModel *)newsModel;

- (void)taosetupWithPLMediaInfo:(PLMediaInfo *)mPLMediaInfo;

+ (CGFloat)headerViewHeight;

- (void)play;

- (void)stop;

- (void)pause;

- (void)shutdown;

-(void)removeCellPlayerView;
-(void)reAddCellPlayerView;

@end
