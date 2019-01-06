#import <UIKit/UIKit.h>
#import "HBNewsModel.h"
#import "HBFilmHomeCell.h"
#import <WebKit/WebKit.h>

@interface HBFilmHomeCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)setupWithNewsModel:(HBNewsModel *)newsModel mixcode:(NSString *)mixcode;
- (void)onShareButtonTapped:(id)sender mixcode:(NSString *)mixcode;
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation mixcode:(NSString *)mixcode;
- (void)webViewMixcode:(NSString *)mixcode;

@end
