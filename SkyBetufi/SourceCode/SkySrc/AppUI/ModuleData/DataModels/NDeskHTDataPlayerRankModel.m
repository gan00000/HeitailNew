#import "NDeskHTDataPlayerRankModel.h"
@implementation NDeskHTDataPlayerRankModel
- (NSString *)name {
    if (!_name) {
        _name = [NSString stringWithFormat:@"%@.%@", [self.firstname substringToIndex:1], self.lastname];
    }
    return _name;
}
@end