#import <UIKit/UIKit.h>
#import "HBNewsModel.h"
#import "HBNewsHomeCell.h"

@interface HBNewsHomeCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)setupWithNewsModel:(HBNewsModel *)newsModel mixcode:(NSString *)mixcode;
- (void)onShareButtonTapped:(id)sender mixcode:(NSString *)mixcode;

@end
