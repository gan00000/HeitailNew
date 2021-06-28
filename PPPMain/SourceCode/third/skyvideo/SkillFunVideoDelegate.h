//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

@import UIKit;

#import "PlayerEventLogger.h"
#import "NowPlayingInfoCenterProvider.h"

@interface SkillFunVideoDelegate : NSObject

@property (nonatomic, readonly) PlayerEventLogger *playerEventLogger;
@property (nonatomic, readonly) NowPlayingInfoCenterProvider *nowPlayingInfoCenterProvider;

@end
