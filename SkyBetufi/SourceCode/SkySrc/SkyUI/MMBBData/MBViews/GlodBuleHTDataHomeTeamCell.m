#import "GlodBuleHTDataHomeTeamCell.h"
#import "GlodBuleHTDataCellTeamView.h"
@interface GlodBuleHTDataHomeTeamCell ()
@property (nonatomic, strong) NSMutableArray *cells;
@end
@implementation GlodBuleHTDataHomeTeamCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.clipsToBounds = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)waterSkysetupWithDatas:(NSArray<GlodBuleHTDataHomeModel *> *)datas {
    if (datas.count == 0) {
        return;
    }
    CGFloat width = SCREEN_WIDTH / 5;
    for (NSInteger i=self.cells.count; i<datas.count; i++) {
        GlodBuleHTDataCellTeamView *cell = [GlodBuleHTDataCellTeamView dataCellViewWithFrame:CGRectMake(i*width, 0, width, self.jx_height)
                                                                       addToView:self];
        [self.cells addObject:cell];
    }
    for (NSInteger i=0; i<datas.count; i++) {
        GlodBuleHTDataHomeModel *model = datas[i];
        GlodBuleHTDataCellTeamView *cell = self.cells[i];
        [cell waterSkysetupWithDataModel:model];
    }
}
- (NSMutableArray *)cells {
    if (!_cells) {
        _cells = [NSMutableArray array];
    }
    return _cells;
}
@end
