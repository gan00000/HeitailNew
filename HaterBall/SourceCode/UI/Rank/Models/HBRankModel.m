#import "HBRankModel.h"
@implementation HBRankModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"rank_id": @"id"
             };
}
- (NSString *)win {
    if (!_win) {
        _win = @"0";
        if (self.wins > 0) {
            _win = [NSString stringWithFormat:@"%ld", self.wins];
        }
    }
    return _win;
}
- (NSString *)loss {
    if (!_loss) {
        _loss = @"0";
        if (self.losses > 0) {
            _loss = @(self.losses).stringValue;
        } else if (self.Losses > 0) {
            _loss = @(self.Losses).stringValue;
        }
    }
    return _loss;
}
- (NSString *)winRate {
    if (!_winRate) {
        _winRate = @"0.0%";
        if (self.wins + self.loss.integerValue > 0) {
            CGFloat rate = 100.0 * self.wins / (self.wins + self.loss.integerValue);
            _winRate = [NSString stringWithFormat:@"%.1f%%", rate];
        }
    }
    return _winRate;
}
- (NSString *)home_matches {
    if (!_home_matches) {
        _home_matches = [NSString stringWithFormat:@"%ld-%ld", self.homewin, self.homelose];
    }
    return _home_matches;
}
- (NSString *)away_matches {
    if (!_away_matches) {
        _away_matches = [NSString stringWithFormat:@"%ld-%ld", self.awaywin, self.awaylose];
    }
    return _away_matches;
}
- (NSString *)area_matches {
    if (!_area_matches) {
        _area_matches = [NSString stringWithFormat:@"%ld-%ld", self.homewin+self.awaywin, self.homelose+self.awaylose];
    }
    return _area_matches;
}
- (NSString *)avg_pts {
    if (!_avg_pts) {
        _avg_pts = @"0.0";
        if (self.matches > 0) {
            _avg_pts = [NSString stringWithFormat:@"%.1f", self.pts / self.matches];
        }
    }
    return _avg_pts;
}
- (NSString *)avg_against_pts {
    if (!_avg_against_pts) {
        _avg_against_pts = @"0.0";
        if (self.matches > 0) {
            _avg_against_pts = [NSString stringWithFormat:@"%.1f", self.against_pts / self.matches];
        }        
    }
    return _avg_against_pts;
}
- (NSInteger)matches {
    if (self.gamesplayed > 0) {
        return self.gamesplayed;
    }
    return self.GamesPlayed;
}
- (CGFloat)against_pts {
    if (self.ptsagainst > 0) {
        return self.ptsagainst;
    }
    return self.PtsAgainst;
}
@end
