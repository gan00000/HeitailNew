#import "KSasxHTDataHomePlayerCell.h"
#import "FFlaliHTDataCellPlayerView.h"
@interface KSasxHTDataHomePlayerCell ()
@property (nonatomic, strong) NSMutableArray *cells;
@end
@implementation KSasxHTDataHomePlayerCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.clipsToBounds = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)taosetupWithDatas:(NSArray<NSNiceHTDataHomeModel *> *)datas {
    if (datas.count == 0) {
        return;
    }
    CGFloat width = SCREEN_WIDTH / 5;
    for (NSInteger i=self.cells.count; i<datas.count; i++) {
        FFlaliHTDataCellPlayerView *cell = [FFlaliHTDataCellPlayerView dataCellViewWithFrame:CGRectMake(i*width, 0, width, self.jx_height)
                                                           addToView:self];
        [self.cells addObject:cell];
    }
    for (NSInteger i=0; i<datas.count; i++) {
        NSNiceHTDataHomeModel *model = datas[i];
        FFlaliHTDataCellPlayerView *cell = self.cells[i];
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
