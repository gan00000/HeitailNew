#import <UIKit/UIKit.h>
#import "HBNewsModel.h"
#import "HBNewsHeaderCell.h"

@interface HBNewsHeaderCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)setupWithNewsModel:(HBNewsModel *)newsModel mixcode:(NSString *)mixcode;

@end
