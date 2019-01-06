#import <UIKit/UIKit.h>
#import "HBDataHomeModel.h"
#import "HBDataHomeTeamCell.h"
#import "HBDataCellTeamView.h"

@interface HBDataHomeTeamCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)setupWithDatas:(NSArray<HBDataHomeModel *> *)datas mixcode:(NSString *)mixcode;
- (void)cellsMixcode:(NSString *)mixcode;

@end
