#import "HBDataPlayerRankModel.h"
@implementation HBDataPlayerRankModel
- (NSString *)name {
    if (!_name) {
        _name = [NSString stringWithFormat:@"%@ %@", self.firstname, self.lastname];
    }
    return _name;
}
@end
