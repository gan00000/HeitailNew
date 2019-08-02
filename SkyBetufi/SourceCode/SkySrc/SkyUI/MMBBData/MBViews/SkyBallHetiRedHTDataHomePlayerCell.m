#import "SkyBallHetiRedHTDataHomePlayerCell.h"
#import "SkyBallHetiRedHTDataCellPlayerView.h"
@interface SkyBallHetiRedHTDataHomePlayerCell ()
@property (nonatomic, strong) NSMutableArray *cells;
@end
@implementation SkyBallHetiRedHTDataHomePlayerCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.clipsToBounds = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)waterSkysetupWithDatas:(NSArray<SkyBallHetiRedHTDataHomeModel *> *)datas {
    if (datas.count == 0) {
        return;
    }
    CGFloat width = SCREEN_WIDTH / 5;
    for (NSInteger i=self.cells.count; i<datas.count; i++) {
        SkyBallHetiRedHTDataCellPlayerView *cell = [SkyBallHetiRedHTDataCellPlayerView dataCellViewWithFrame:CGRectMake(i*width, 0, width, self.jx_height)
                                                           addToView:self];
        [self.cells addObject:cell];
    }
    for (NSInteger i=0; i<datas.count; i++) {
        SkyBallHetiRedHTDataHomeModel *model = datas[i];
        SkyBallHetiRedHTDataCellPlayerView *cell = self.cells[i];
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
