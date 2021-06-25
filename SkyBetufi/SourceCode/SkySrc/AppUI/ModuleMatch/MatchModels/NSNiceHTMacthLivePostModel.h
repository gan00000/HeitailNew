//
//  NSNiceHTMacthLivePostModel.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2019/12/21.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNiceHTMacthLivePostModel : NSObject

@property (nonatomic, copy) NSString *game_id;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *post_id;
@property (nonatomic, strong) NSArray<NSString *> *live_url;
@end

NS_ASSUME_NONNULL_END
