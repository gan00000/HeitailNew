#import "SundayHTMatchDetailsModel.h"
#import "PXFunConfigCoreUtil.h"
@implementation SundayHTMatchDetailsModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"detail_id": @"id"
             };
}
- (NSString *)fgmade_show {
    if (!_fgmade_show) {
        _fgmade_show = [NSString stringWithFormat:@"%@-%@", self.fgmade, self.fgatt];
    }
    return _fgmade_show;
}
- (NSString *)fg3ptmade_show {
    if (!_fg3ptmade_show) {
        _fg3ptmade_show = [NSString stringWithFormat:@"%@-%@", self.fg3ptmade, self.fg3ptatt];
    }
    return _fg3ptmade_show;
}
- (NSString *)ftmade_show {
    if (!_ftmade_show) {
        _ftmade_show = [NSString stringWithFormat:@"%@-%@", self.ftmade, self.ftatt];
    }
    return _ftmade_show;
}
- (NSString *)name {
    
    if ([[PXFunConfigCoreUtil share].matchType isEqualToString:@"3"]) { //CBA的话先获取中文，中文没有用英文
        if (self.ch_name && ![self.ch_name isEqualToString:@""]) {
            return self.ch_name;
        }
    }

    if (!_name && self.firstname && ![self.firstname isEqualToString:@""]) {
        _name = [NSString stringWithFormat:@"%@.%@", [self.firstname substringToIndex:1], self.lastname];
    }
    return _name;
}
- (NSString *)time {
    if (!_time) {
        _time = [NSString stringWithFormat:@"%ld", self.minseconds/60];
    }
    return _time;
}
@end