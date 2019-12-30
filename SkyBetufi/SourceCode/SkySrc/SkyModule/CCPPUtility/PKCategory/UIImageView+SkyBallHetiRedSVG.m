#import "UIImageView+SkyBallHetiRedSVG.h"
@implementation UIImageView (SkyBallHetiRedSVG)
- (void)svg_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder {
   
    
    SVGKImage *cacheObject = [SkyBallHetiRedHTUserManager.manager.svgImageCache objectForKey:url];
    if (cacheObject) {
        if(cacheObject.UIImage){
            [self setImage:cacheObject.UIImage];
            return;
        }
       [SkyBallHetiRedHTUserManager.manager.svgImageCache removeObjectForKey:url];
    }
    
    [self setImage:placeholder];
//    [self.svgImageDic removeAllObjects];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        // 处理耗时操作的代码块...
        //通知主线程刷新
//        NSData *svgImageData = [NSData dataWithContentsOfURL:url];
//         SVGKImage *theSvgImage;
//         if (svgImageData) {
//             theSvgImage = [SVGKImage imageWithData:svgImageData];
//         }
        SVGKImage *theSvgImage = [SVGKImage imageWithContentsOfURL:url];

        dispatch_async(dispatch_get_main_queue(), ^{

            //回调或者说是通知主线程刷新
            if (theSvgImage && theSvgImage.UIImage) {
                [self setImage:theSvgImage.UIImage];
                 [SkyBallHetiRedHTUserManager.manager.svgImageCache setObject:theSvgImage forKey:url];
            }
        });

    });

    
 
//    SVGKImage *theSvgImage = [SVGKImage imageWithData:[NSData dataWithContentsOfURL:url]];

}
@end
