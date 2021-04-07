//
//  HTYoutubePlayerCell.m
//  XXXHeiTai
//
//  Created by ganyuanrong on 2021/4/4.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import "HTYoutubePlayerCell.h"

@implementation HTYoutubePlayerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNewsModel:(GlodBuleHTNewsModel *)mGlodBuleHTNewsModel newsDetailModel:(HTNewsDetailModel *)newsDetailModel
{
//https://www.youtube.com/embed/FqzH-8kOz5s
//    [self.youtubePlayerView stopVideo];
    if (newsDetailModel.data) {
        NSString *videoId = [newsDetailModel.data stringByReplacingOccurrencesOfString:@"https://www.youtube.com/embed/"  withString:@""];
        [self.youtubePlayerView loadWithVideoId:videoId];
    }
    
}

@end
