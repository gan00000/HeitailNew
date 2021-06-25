#import <UIKit/UIKit.h>
#import "UUaksHTNewsModel.h"
@interface KSasxHTNewsHomeCell : UITableViewCell
- (void)taosetupWithNewsModel:(UUaksHTNewsModel *)newsModel;

@property (weak, nonatomic) IBOutlet UILabel *topLabel;

@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewLabel;
@property (weak, nonatomic) IBOutlet UIView *shareButtonContentView;
@property (weak, nonatomic) IBOutlet UIImageView *view_icon;
@property (nonatomic, weak) UUaksHTNewsModel *newsModel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLongLabel;
@property (weak, nonatomic) IBOutlet UIImageView *news_time_icon;

+(CGFloat)xHTNewsHomeCellHeight;

@end
