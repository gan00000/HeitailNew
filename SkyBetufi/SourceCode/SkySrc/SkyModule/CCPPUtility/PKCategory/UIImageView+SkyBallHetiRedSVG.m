#import "UIImageView+SkyBallHetiRedSVG.h"
@implementation UIImageView (SkyBallHetiRedSVG)
- (void)svg_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder {
   
    NSData *svgImageData = [NSData dataWithContentsOfURL:url];
    SVGKImage *theSvgImage;
    if (svgImageData) {
        theSvgImage = [SVGKImage imageWithData:svgImageData];
    }
    
//    SVGKImage *theSvgImage = [SVGKImage imageWithData:[NSData dataWithContentsOfURL:url]];
    if (theSvgImage && theSvgImage.UIImage) {
        [self setImage:theSvgImage.UIImage];
    }else
    {
        [self setImage:placeholder];
    }
}
@end
