//
//  NDeskYSPlayerControl.h
//  ijkplayerDemo
//
//  Created by 张延深 on 2020/4/13.
//  Copyright © 2020 张延深. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSPlayerControlProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NDeskYSPlayerControl : UIView <YSPlayerControlProtocol>

- (void)invalidTimer;

@end

NS_ASSUME_NONNULL_END
