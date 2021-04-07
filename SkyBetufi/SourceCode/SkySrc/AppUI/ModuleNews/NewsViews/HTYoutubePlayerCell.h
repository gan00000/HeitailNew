//
//  HTYoutubePlayerCell.h
//  XXXHeiTai
//
//  Created by ganyuanrong on 2021/4/4.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlodBuleHTNewsModel.h"
#import "YTPlayerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTYoutubePlayerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet YTPlayerView *youtubePlayerView;

-(void) setNewsModel:(GlodBuleHTNewsModel *) mGlodBuleHTNewsModel newsDetailModel:(HTNewsDetailModel *)newsDetailModel;

@end

NS_ASSUME_NONNULL_END
