#import <UIKit/UIKit.h>
#import "GlodBuleHTNewsModel.h"
@interface GlodBuleHTNewsHomeCell : UITableViewCell
- (void)taosetupWithNewsModel:(GlodBuleHTNewsModel *)newsModel;

@property (weak, nonatomic) IBOutlet UILabel *topLabel;

@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewLabel;
@property (weak, nonatomic) IBOutlet UIView *shareButtonContentView;
@property (weak, nonatomic) IBOutlet UIImageView *view_icon;
@property (nonatomic, weak) GlodBuleHTNewsModel *newsModel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLongLabel;
@property (weak, nonatomic) IBOutlet UIImageView *news_time_icon;

+(CGFloat)xHTNewsHomeCellHeight;

@end
