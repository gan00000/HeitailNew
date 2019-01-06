#import <UIKit/UIKit.h>
#import "HBDataHomeModel.h"
#import "HBDataHomePlayerCell.h"
#import "HBDataCellPlayerView.h"

@interface HBDataHomePlayerCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)setupWithDatas:(NSArray<HBDataHomeModel *> *)datas mixcode:(NSString *)mixcode;
- (void)cellsMixcode:(NSString *)mixcode;

@end
