#import "XRRFATKHTAboutUsViewController.h"
#import "XtgtyCallHeader.h"
@interface XRRFATKHTAboutUsViewController ()
@end
@implementation XRRFATKHTAboutUsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"關於我們";
    
    NSInteger isOj = runOnSky();
    if (isOj == 0) {
        self.title = @"關於我們";
    }else{
        self.title = @" 關於我們 ";
    }
}
@end
