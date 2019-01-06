#import <UIKit/UIKit.h>
#import "HBMatchDataLeftCell.h"

@interface HBMatchDataLeftCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)refreshWithName:(NSString *)name row:(NSInteger)row mixcode:(NSString *)mixcode;

@end
