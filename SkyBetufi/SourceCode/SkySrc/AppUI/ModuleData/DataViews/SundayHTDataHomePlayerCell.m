#import "SundayHTDataHomePlayerCell.h"
#import "PXFunHTDataCellPlayerView.h"
@interface SundayHTDataHomePlayerCell ()
@property (nonatomic, strong) NSMutableArray *cells;
@end
@implementation SundayHTDataHomePlayerCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.clipsToBounds = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)taosetupWithDatas:(NSArray<PXFunHTDataHomeModel *> *)datas {
    if (datas.count == 0) {
        return;
    }
    CGFloat width = SCREEN_WIDTH / 5;
    for (NSInteger i=self.cells.count; i<datas.count; i++) {
        PXFunHTDataCellPlayerView *cell = [PXFunHTDataCellPlayerView dataCellViewWithFrame:CGRectMake(i*width, 0, width, self.jx_height)
                                                           addToView:self];
        [self.cells addObject:cell];
    }
    for (NSInteger i=0; i<datas.count; i++) {
        PXFunHTDataHomeModel *model = datas[i];
        PXFunHTDataCellPlayerView *cell = self.cells[i];
        [cell taosetupWithDataModel:model];
    }
}
- (NSMutableArray *)cells {
    if (!_cells) {
        _cells = [NSMutableArray array];
    }
    return _cells;
}
@end
