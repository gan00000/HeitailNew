#import <UIKit/UIKit.h>
#import "UUaksHTNewsModel.h"
#import "PLMediaInfo.h"
#import "UUaksYSPlayerController.h"

@class KSasxHTFilmHomeCell;

@protocol PlayerTableViewCellDelegate <NSObject>

- (void)tableViewWillPlay:(KSasxHTFilmHomeCell *)cell;

- (void)tableViewCellEnterFullScreen:(KSasxHTFilmHomeCell *)cell;

- (void)tableViewCellExitFullScreen:(KSasxHTFilmHomeCell *)cell;

@end


@interface KSasxHTFilmHomeCell : UITableViewCell

@property (nonatomic, copy) NSString *news_id;

@property (strong, nonatomic) id<PlayerTableViewCellDelegate> mPlayerTableViewCellDelegate;
@property (weak, nonatomic) IBOutlet UIImageView *addSaveImageView;
@property (weak, nonatomic) IBOutlet UIButton *addSaveBtn;

@property (weak, nonatomic) IBOutlet UIButton *addSaveBtnReplace;//为了点击区域更大而设置

@property (strong, nonatomic) UUaksYSPlayerController *playerController;

- (void)taosetupWithNewsModel:(UUaksHTNewsModel *)newsModel;

- (void)taosetupWithPLMediaInfo:(PLMediaInfo *)mPLMediaInfo;

+ (CGFloat)headerViewHeight;

- (void)play;

- (void)stop;

- (void)pause;

- (void)shutdown;

-(void)removeCellPlayerView;
-(void)reAddCellPlayerView;

@end
