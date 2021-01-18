#import "GlodBuleHTDataCellTeamView.h"
#import <WebKit/WebKit.h>
#import <UIImageView+GlodBuleSVG.h>
@interface GlodBuleHTDataCellTeamView ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (nonatomic, assign) NSInteger width;
@end
@implementation GlodBuleHTDataCellTeamView
+ (instancetype)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view {
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
    GlodBuleHTDataCellTeamView *cellView = kLoadXibWithName(@"GlodBuleHTDataCellTeamView");
    cellView.frame = cellView.bounds;
    cellView.width = ceil(frame.size.width);
    [contentView addSubview:cellView];
    [view addSubview:contentView];
    return cellView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}
- (void)waterSkysetupWithDataModel:(GlodBuleHTDataHomeModel *)dataModel {
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f", dataModel.pts];
    self.teamNameLabel.text = dataModel.teamName;
    [dataModel waterSkyimageUrlFixWithWidth:self.width-30];
    self.imageView.hidden = NO;
    if ([dataModel.team_logo hasSuffix:@"svg"]) {
         [self.imageView svg_setImageWithURL:[NSURL URLWithString:dataModel.team_logo] placeholderImage:HT_DEFAULT_IMAGE];
    }else{
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:dataModel.team_logo] placeholderImage:HT_DEFAULT_IMAGE];
    }
}
@end
