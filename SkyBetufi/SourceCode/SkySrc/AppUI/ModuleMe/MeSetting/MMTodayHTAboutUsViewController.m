#import "MMTodayHTAboutUsViewController.h"
#import "PlayerEventLogger.h"
#import "NowPlayingInfoCenterProvider.h"


@import AVFoundation;
//#import <XCDLumberjackNSLogger/XCDLumberjackNSLogger.h>
#import <XCDYouTubeKit/XCDYouTubeKit.h>
#import "ContextLogFormatter.h"

@interface MMTodayHTAboutUsViewController ()

@property (nonatomic, readonly) PlayerEventLogger *playerEventLogger;
@property (nonatomic, readonly) NowPlayingInfoCenterProvider *nowPlayingInfoCenterProvider;

@end
@implementation MMTodayHTAboutUsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"關於我們";
    
//    NSInteger isOj = runOnSky();
    if (!self.title) {
        
        _playerEventLogger = [PlayerEventLogger new];
        _nowPlayingInfoCenterProvider = [NowPlayingInfoCenterProvider new];
//
//        DDTTYLogger *ttyLogger = [DDTTYLogger sharedInstance];
//        DDLogLevel defaultLogLevel = LogLevelForEnvironmentVariable(@"DefaultLogLevel", DDLogLevelInfo);
//        DDLogLevel youTubeLogLevel = LogLevelForEnvironmentVariable(@"XCDYouTubeLogLevel", DDLogLevelWarning);
//        ttyLogger.logFormatter = [[ContextLogFormatter alloc] initWithLevels:@{ @(XCDYouTubeKitLumberjackContext) : @(youTubeLogLevel) } defaultLevel:defaultLogLevel];
//        ttyLogger.colorsEnabled = YES;
//        [DDLog addLogger:ttyLogger];
//
//        NSString *bonjourServiceName = [[NSUserDefaults standardUserDefaults] objectForKey:@"NSLoggerBonjourServiceName"];
//        NSLog(@"..%@",bonjourServiceName);
//        XCDLumberjackNSLogger *logger = [[XCDLumberjackNSLogger alloc] initWithBonjourServiceName:bonjourServiceName];
//        logger.tags = @{ @0: @"Movie Player", @(XCDYouTubeKitLumberjackContext) : @"XCDYouTubeKit" };
//        [DDLog addLogger:logger];
        
        self.title = @" 關於我們 ";
    }
}
@end
