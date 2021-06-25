#import "FFlaliHTDataCellPlayerView.h"
#import <WebKit/WebKit.h>
@interface FFlaliHTDataCellPlayerView ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@end
@implementation FFlaliHTDataCellPlayerView
+ (instancetype)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view {
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
    FFlaliHTDataCellPlayerView *cellView = kLoadXibWithName(@"FFlaliHTDataCellPlayerView");
    cellView.frame = cellView.bounds;
    [contentView addSubview:cellView];
    [view addSubview:contentView];
    return cellView;
}
- (void)taosetupWithDataModel:(NSNiceHTDataHomeModel *)dataModel {
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f", dataModel.score];
    self.nameLabel.text = dataModel.name;
    self.teamNameLabel.text = dataModel.teamName;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:dataModel.officialImagesrc]
                      placeholderImage:HT_DEFAULT_IMAGE];
}
@end
