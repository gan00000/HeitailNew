#import <UIKit/UIKit.h>
#import "GlodBuleHTNewsModel.h"
@interface GlodBuleHTNewsHomeCell : UITableViewCell
- (void)taosetupWithNewsModel:(GlodBuleHTNewsModel *)newsModel;

@property (weak, nonatomic) IBOutlet UILabel *topLabel;

@end
