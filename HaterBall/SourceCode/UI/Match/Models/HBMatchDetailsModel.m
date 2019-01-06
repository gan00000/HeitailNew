#import "HBMatchDetailsModel.h"
@implementation HBMatchDetailsModel
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
    if (!_name) {
        _name = [NSString stringWithFormat:@"%@ %@", self.firstname, self.lastname];
    }
    return _name;
}
- (NSString *)time {
    if (!_time) {
        _time = [NSString stringWithFormat:@"%ld:%ld", self.minseconds/60, self.minseconds%60];
    }
    return _time;
}
@end
