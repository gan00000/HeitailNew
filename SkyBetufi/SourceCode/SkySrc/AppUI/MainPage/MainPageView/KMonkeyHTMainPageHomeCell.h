#import <UIKit/UIKit.h>
#import "PXFunHTNewsModel.h"
#import "PLMediaInfo.h"
#import "CCCaseYSPlayerController.h"

@class KMonkeyHTMainPageHomeCell;

@protocol MainPagePlayerTableViewCellDelegate <NSObject>

- (void)tableViewWillPlay:(KMonkeyHTMainPageHomeCell *)cell;

- (void)tableViewCellEnterFullScreen:(KMonkeyHTMainPageHomeCell *)cell;

- (void)tableViewCellExitFullScreen:(KMonkeyHTMainPageHomeCell *)cell;

@end


@interface KMonkeyHTMainPageHomeCell : UITableViewCell

@property (nonatomic, copy) NSString *news_id;

@property (strong, nonatomic) id<MainPagePlayerTableViewCellDelegate> mPlayerTableViewCellDelegate;
@property (weak, nonatomic) IBOutlet UIImageView *addSaveImageView;
@property (weak, nonatomic) IBOutlet UIButton *addSaveBtn;

@property (weak, nonatomic) IBOutlet UIButton *addSaveBtnReplace;//为了点击区域更大而设置

@property (strong, nonatomic) CCCaseYSPlayerController *playerController;

- (void)taosetupWithNewsModel:(PXFunHTNewsModel *)newsModel;

- (void)taosetupWithPLMediaInfo:(PLMediaInfo *)mPLMediaInfo;

+ (CGFloat)headerViewHeight:(CGFloat) offset;

- (void)play;

- (void)stop;

- (void)pause;

- (void)shutdown;

-(void)removeCellPlayerView;
-(void)reAddCellPlayerView;

@end
