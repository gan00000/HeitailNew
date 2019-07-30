#import "XRRFATKHTDataCellTeamView.h"
#import <WebKit/WebKit.h>
#import <UIImageView+XRRFATKSVG.h>
@interface XRRFATKHTDataCellTeamView ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (nonatomic, assign) NSInteger width;
@end
@implementation XRRFATKHTDataCellTeamView
+ (instancetype)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view {
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
    XRRFATKHTDataCellTeamView *cellView = kLoadXibWithName(@"XRRFATKHTDataCellTeamView");
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
- (void)skargsetupWithDataModel:(XRRFATKHTDataHomeModel *)dataModel {
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f", dataModel.pts];
    self.teamNameLabel.text = dataModel.teamName;
    [dataModel skargimageUrlFixWithWidth:self.width-30];
    self.imageView.hidden = NO;
    if ([dataModel.team_logo hasSuffix:@"svg"]) {
         [self.imageView svg_setImageWithURL:[NSURL URLWithString:dataModel.team_logo] placeholderImage:HT_DEFAULT_IMAGE];
    }else{
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:dataModel.team_logo] placeholderImage:HT_DEFAULT_IMAGE];
    }
}
@end
