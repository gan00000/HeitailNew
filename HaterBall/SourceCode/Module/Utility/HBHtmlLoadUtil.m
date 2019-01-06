#import "HBHtmlLoadUtil.h"
@interface HBHtmlLoadUtil ()
@property (nonatomic, copy) NSString *svgHtml;
@property (nonatomic, copy) NSString *iframeHtml;
@end
@implementation HBHtmlLoadUtil
+ (instancetype)sharedInstance {
    static HBHtmlLoadUtil *util;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = [[HBHtmlLoadUtil alloc] init];
    });
    return util;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *svgPath = [[NSBundle mainBundle] pathForResource:@"logo_load" ofType:@"html"];
        _svgHtml = [NSString stringWithContentsOfFile:svgPath encoding:NSUTF8StringEncoding error:nil];
        NSString *iframePath = [[NSBundle mainBundle] pathForResource:@"iframe_load" ofType:@"html"];
        _iframeHtml = [NSString stringWithContentsOfFile:iframePath encoding:NSUTF8StringEncoding error:nil];
    }
    return self;
}
- (NSString *)svgHtmlWithUrl:(NSString *)img_url width:(NSInteger)width {
    return [NSString stringWithFormat:self.svgHtml, width, img_url];
}
- (NSString *)iframHtmlWithContent:(NSString *)iframe_content {
    return [NSString stringWithFormat:self.iframeHtml, iframe_content];
}
@end
