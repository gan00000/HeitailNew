#import <UIKit/UIKit.h>
#import <SVGKit/SVGKImage.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIImageView (NDeskSVG)

//@property (nonatomic) NSMutableDictionary *svgImageDic;
- (void)svg_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder;
@end
NS_ASSUME_NONNULL_END
