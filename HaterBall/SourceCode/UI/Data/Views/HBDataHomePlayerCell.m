#import "HBDataHomePlayerCell.h"
#import "HBDataCellPlayerView.h"
@interface HBDataHomePlayerCell ()
@property (nonatomic, strong) NSMutableArray *cells;
@end
@implementation HBDataHomePlayerCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.clipsToBounds = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setupWithDatas:(NSArray<HBDataHomeModel *> *)datas {
    if (datas.count == 0) {
        return;
    }
    CGFloat width = SCREEN_WIDTH / 5;
    for (NSInteger i=self.cells.count; i<datas.count; i++) {
        HBDataCellPlayerView *cell = [HBDataCellPlayerView dataCellViewWithFrame:CGRectMake(i*width, 0, width, self.jx_height)
                                                           addToView:self];
        [self.cells addObject:cell];
    }
    for (NSInteger i=0; i<datas.count; i++) {
        HBDataHomeModel *model = datas[i];
        HBDataCellPlayerView *cell = self.cells[i];
        [cell setupWithDataModel:model];
    }
}
- (NSMutableArray *)cells {
    if (!_cells) {
        _cells = [NSMutableArray array];
    }
    return _cells;
}
@end
