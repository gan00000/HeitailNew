#import "XRRFATKHTDataHomeTeamCell.h"
#import "XRRFATKHTDataCellTeamView.h"
@interface XRRFATKHTDataHomeTeamCell ()
@property (nonatomic, strong) NSMutableArray *cells;
@end
@implementation XRRFATKHTDataHomeTeamCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.clipsToBounds = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)skargsetupWithDatas:(NSArray<XRRFATKHTDataHomeModel *> *)datas {
    if (datas.count == 0) {
        return;
    }
    CGFloat width = SCREEN_WIDTH / 5;
    for (NSInteger i=self.cells.count; i<datas.count; i++) {
        XRRFATKHTDataCellTeamView *cell = [XRRFATKHTDataCellTeamView dataCellViewWithFrame:CGRectMake(i*width, 0, width, self.jx_height)
                                                                       addToView:self];
        [self.cells addObject:cell];
    }
    for (NSInteger i=0; i<datas.count; i++) {
        XRRFATKHTDataHomeModel *model = datas[i];
        XRRFATKHTDataCellTeamView *cell = self.cells[i];
        [cell skargsetupWithDataModel:model];
    }
}
- (NSMutableArray *)cells {
    if (!_cells) {
        _cells = [NSMutableArray array];
    }
    return _cells;
}
@end
