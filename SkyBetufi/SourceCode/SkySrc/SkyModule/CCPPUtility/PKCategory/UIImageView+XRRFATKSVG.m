#import "UIImageView+XRRFATKSVG.h"
@implementation UIImageView (XRRFATKSVG)
- (void)svg_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder {
    SVGKImage *theSvgImage = [SVGKImage imageWithData:[NSData dataWithContentsOfURL:url]];
    if (theSvgImage && theSvgImage.UIImage) {
        [self setImage:theSvgImage.UIImage];
    }else
    {
        [self setImage:placeholder];
    }
}
@end
