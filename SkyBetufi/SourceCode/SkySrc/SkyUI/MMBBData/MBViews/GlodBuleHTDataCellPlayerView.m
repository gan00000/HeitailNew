#import "GlodBuleHTDataCellPlayerView.h"
#import <WebKit/WebKit.h>
@interface GlodBuleHTDataCellPlayerView ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@end
@implementation GlodBuleHTDataCellPlayerView
+ (instancetype)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view {
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
    GlodBuleHTDataCellPlayerView *cellView = kLoadXibWithName(@"GlodBuleHTDataCellPlayerView");
    cellView.frame = cellView.bounds;
    [contentView addSubview:cellView];
    [view addSubview:contentView];
    return cellView;
}
- (void)waterSkysetupWithDataModel:(GlodBuleHTDataHomeModel *)dataModel {
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f", dataModel.score];
    self.nameLabel.text = dataModel.name;
    self.teamNameLabel.text = dataModel.teamName;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:dataModel.officialImagesrc]
                      placeholderImage:HT_DEFAULT_IMAGE];
}
@end
