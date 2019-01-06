#import <UIKit/UIKit.h>
#import "HBRankModel.h"
#import "HBRankHomeCell.h"
#import "HBRankLeftCell.h"
#import "HBRankRightCell.h"

@interface HBRankHomeCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)drawRect:(CGRect)rect mixcode:(NSString *)mixcode;
- (void)setupWithTitle:(NSString *)title rankList:(NSArray<HBRankModel *> *)rankList mixcode:(NSString *)mixcode;
- (void)setupLeftTableViewMixcode:(NSString *)mixcode;
- (void)setupRightTableViewMixcode:(NSString *)mixcode;
- (void)addLabelToView:(UIView *)view withFrame:(CGRect)frame text:(NSString *)text mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath mixcode:(NSString *)mixcode;
- (void)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section mixcode:(NSString *)mixcode;

@end
