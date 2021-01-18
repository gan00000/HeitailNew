#import "GlodBuleHTNewsHomeCell.h"

#import "NSString+GlodBuleMessageDigest.h"
@interface GlodBuleHTNewsHomeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewLabel;
@property (weak, nonatomic) IBOutlet UIView *shareButtonContentView;
@property (weak, nonatomic) IBOutlet UIImageView *view_icon;
@property (nonatomic, weak) GlodBuleHTNewsModel *newsModel;
@end
@implementation GlodBuleHTNewsHomeCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([GlodBuleHTNewsModel waterSkycanShare]) {
        self.shareButtonContentView.hidden = NO;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)waterSkysetupWithNewsModel:(GlodBuleHTNewsModel *)newsModel {
    self.newsModel = newsModel;
    NSString *tmpUrl = [newsModel.img_url stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    [self.thumbImageView sd_setImageWithURL:[NSURL URLWithString:tmpUrl] placeholderImage:HT_DEFAULT_IMAGE];
    self.titleLabel.text = newsModel.title;
    self.timeLabel.text = newsModel.time;
    self.viewLabel.text = newsModel.view_count;
    if (!newsModel.view_count.length) {
        self.view_icon.hidden = YES;
    }
    self.view_icon.hidden = YES;
    self.viewLabel.hidden = YES;
}
- (IBAction)onShareButtonTapped:(id)sender {
    [self.newsModel waterSkyshare];
}
@end
