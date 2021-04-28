#import <UIKit/UIKit.h>
#import "GlodBuleHTNewsModel.h"
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

@property (weak, nonatomic) IBOutlet UIButton *addSaveBtnReplace;//为了点击区域更大而设置

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
