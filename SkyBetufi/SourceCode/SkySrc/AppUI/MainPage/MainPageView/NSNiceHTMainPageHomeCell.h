#import <UIKit/UIKit.h>
#import "UUaksHTNewsModel.h"
#import "PLMediaInfo.h"
#import "UUaksYSPlayerController.h"

#define KMonkeyHTMainPageHomeCell_Height 480.0
#define KMonkeyHTMainPageHomeCell_Width 375.0

#define KMonkeyHTMainPageHomeCell_ContentView_Height 194.0

@class NSNiceHTMainPageHomeCell;

@protocol MainPagePlayerTableViewCellDelegate <NSObject>

- (void)tableViewWillPlay:(NSNiceHTMainPageHomeCell *)cell;

- (void)tableViewCellEnterFullScreen:(NSNiceHTMainPageHomeCell *)cell;

- (void)tableViewCellExitFullScreen:(NSNiceHTMainPageHomeCell *)cell;

@end


@interface NSNiceHTMainPageHomeCell : UITableViewCell

@property (nonatomic, copy) NSString *news_id;

@property (strong, nonatomic) id<MainPagePlayerTableViewCellDelegate> mPlayerTableViewCellDelegate;
@property (weak, nonatomic) IBOutlet UIImageView *addSaveImageView;
@property (weak, nonatomic) IBOutlet UIButton *addSaveBtn;

@property (weak, nonatomic) IBOutlet UIButton *addSaveBtnReplace;//为了点击区域更大而设置

@property (strong, nonatomic) UUaksYSPlayerController *playerController;

//@property(nonatomic,strong) ClickHander mClickHander;

@property(nonatomic,strong) NSMutableArray<UIImageView *> *thumbShowImageViews;

- (void)taosetupWithNewsModel:(UUaksHTNewsModel *)newsModel;

- (void)taosetupWithPLMediaInfo:(PLMediaInfo *)mPLMediaInfo;

+ (CGFloat)headerViewHeight:(CGFloat) offset;

- (void)play;

- (void)stop;

- (void)pause;

- (void)shutdown;

-(void)removeCellPlayerView;
-(void)reAddCellPlayerView;

@end
