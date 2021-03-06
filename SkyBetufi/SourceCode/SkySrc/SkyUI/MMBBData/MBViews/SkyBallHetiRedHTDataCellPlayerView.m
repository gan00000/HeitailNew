#import "SkyBallHetiRedHTDataCellPlayerView.h"
#import <WebKit/WebKit.h>
@interface SkyBallHetiRedHTDataCellPlayerView ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@end
@implementation SkyBallHetiRedHTDataCellPlayerView
+ (instancetype)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view {
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
    SkyBallHetiRedHTDataCellPlayerView *cellView = kLoadXibWithName(@"SkyBallHetiRedHTDataCellPlayerView");
    cellView.frame = cellView.bounds;
    [contentView addSubview:cellView];
    [view addSubview:contentView];
    return cellView;
}
- (void)waterSkysetupWithDataModel:(SkyBallHetiRedHTDataHomeModel *)dataModel {
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f", dataModel.score];
    self.nameLabel.text = dataModel.name;
    self.teamNameLabel.text = dataModel.teamName;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:dataModel.officialImagesrc]
                      placeholderImage:HT_DEFAULT_IMAGE];
}
@end
