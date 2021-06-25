//
//  WSKggHTYoutubePlayerCell.m
//  
//
//  Created by ganyuanrong on 2021/4/4.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import "WSKggHTYoutubePlayerCell.h"

@interface WSKggHTYoutubePlayerCell() <YTPlayerViewDelegate>

@property (nonatomic, assign) BOOL hasLoad;

@end

@implementation WSKggHTYoutubePlayerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.youtubePlayerView.delegate = self;
    self.hasLoad = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNewsModel:(UUaksHTNewsModel *)mHTNewsModel newsDetailModel:(FFlaliHTNewsDetailModel *)newsDetailModel
{
//https://www.youtube.com/embed/FqzH-8kOz5s
//    [self.youtubePlayerView stopVideo];
    if (newsDetailModel.data) {
        
        if (self.hasLoad) {
            return;
        }
        self.hasLoad = YES;
        
        if ([newsDetailModel.data hasPrefix:@"https://www.youtube.com/embed"]) {
            NSString *videoId = [newsDetailModel.data stringByReplacingOccurrencesOfString:@"https://www.youtube.com/embed/"  withString:@""];
            [self.youtubePlayerView loadWithVideoId:videoId];
        }else{
            
            NSString *srcStr = [[RX(@"https://www.youtube.com/embed/\\w+") matches:newsDetailModel.data] firstObject];
            NSString *videoId = [srcStr stringByReplacingOccurrencesOfString:@"https://www.youtube.com/embed/"  withString:@""];
            if (videoId && ![videoId isEqualToString:@""]) {
                [self.youtubePlayerView loadWithVideoId:videoId];
            }
            
        }
    }
    
}

@end
