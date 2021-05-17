//
//  SundayHTYoutubePlayerCell.h
//  
//
//  Created by ganyuanrong on 2021/4/4.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXFunHTNewsModel.h"
#import "YTPlayerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SundayHTYoutubePlayerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet YTPlayerView *youtubePlayerView;

-(void) setNewsModel:(PXFunHTNewsModel *) mGlodBuleHTNewsModel newsDetailModel:(YYPackageHTNewsDetailModel *)newsDetailModel;

@end

NS_ASSUME_NONNULL_END
