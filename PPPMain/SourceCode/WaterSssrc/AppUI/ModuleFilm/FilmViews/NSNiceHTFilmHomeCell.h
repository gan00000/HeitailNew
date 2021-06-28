#import <UIKit/UIKit.h>
#import "CfipyHTNewsModel.h"
#import "PLMediaInfo.h"
#import "YeYeeYSPlayerController.h"

@class NSNiceHTFilmHomeCell;

@protocol PlayerTableViewCellDelegate <NSObject>

- (void)tableViewWillPlay:(NSNiceHTFilmHomeCell *)cell;

- (void)tableViewCellEnterFullScreen:(NSNiceHTFilmHomeCell *)cell;

- (void)tableViewCellExitFullScreen:(NSNiceHTFilmHomeCell *)cell;

@end


@interface NSNiceHTFilmHomeCell : UITableViewCell

@property (nonatomic, copy) NSString *news_id;

@property (strong, nonatomic) id<PlayerTableViewCellDelegate> mPlayerTableViewCellDelegate;
@property (weak, nonatomic) IBOutlet UIImageView *addSaveImageView;
@property (weak, nonatomic) IBOutlet UIButton *addSaveBtn;

@property (weak, nonatomic) IBOutlet UIButton *addSaveBtnReplace;//为了点击区域更大而设置

@property (strong, nonatomic) YeYeeYSPlayerController *playerController;

- (void)taosetupWithNewsModel:(CfipyHTNewsModel *)newsModel;

- (void)taosetupWithPLMediaInfo:(PLMediaInfo *)mPLMediaInfo;

+ (CGFloat)headerViewHeight;

- (void)play;

- (void)stop;

- (void)pause;

- (void)shutdown;

-(void)removeCellPlayerView;
-(void)reAddCellPlayerView;

@end
