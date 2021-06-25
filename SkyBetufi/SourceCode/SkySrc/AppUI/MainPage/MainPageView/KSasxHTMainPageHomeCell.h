#import <UIKit/UIKit.h>
#import "CfipyHTNewsModel.h"
#import "PLMediaInfo.h"
#import "YeYeeYSPlayerController.h"

#define KMonkeyHTMainPageHomeCell_Height 480.0
#define KMonkeyHTMainPageHomeCell_Width 375.0

#define KMonkeyHTMainPageHomeCell_ContentView_Height 194.0

@class KSasxHTMainPageHomeCell;

@protocol MainPagePlayerTableViewCellDelegate <NSObject>

- (void)tableViewWillPlay:(KSasxHTMainPageHomeCell *)cell;

- (void)tableViewCellEnterFullScreen:(KSasxHTMainPageHomeCell *)cell;

- (void)tableViewCellExitFullScreen:(KSasxHTMainPageHomeCell *)cell;

@end


@interface KSasxHTMainPageHomeCell : UITableViewCell

@property (nonatomic, copy) NSString *news_id;

@property (strong, nonatomic) id<MainPagePlayerTableViewCellDelegate> mPlayerTableViewCellDelegate;
@property (weak, nonatomic) IBOutlet UIImageView *addSaveImageView;
@property (weak, nonatomic) IBOutlet UIButton *addSaveBtn;

@property (weak, nonatomic) IBOutlet UIButton *addSaveBtnReplace;//为了点击区域更大而设置

@property (strong, nonatomic) YeYeeYSPlayerController *playerController;

//@property(nonatomic,strong) ClickHander mClickHander;

@property(nonatomic,strong) NSMutableArray<UIImageView *> *thumbShowImageViews;

- (void)taosetupWithNewsModel:(CfipyHTNewsModel *)newsModel;

- (void)taosetupWithPLMediaInfo:(PLMediaInfo *)mPLMediaInfo;

+ (CGFloat)headerViewHeight:(CGFloat) offset;

- (void)play;

- (void)stop;

- (void)pause;

- (void)shutdown;

-(void)removeCellPlayerView;
-(void)reAddCellPlayerView;

@end
