#import "UIImageView+SkyBallHetiRedSVG.h"
@implementation UIImageView (SkyBallHetiRedSVG)
- (void)svg_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder {
   
//    if (!self.svgImageDic) {
//        self.svgImageDic = [[NSMutableDictionary alloc] initWithCapacity:0];
//    }
    
//    SVGKImage *cacheObject = [self.svgImageDic objectForKey:url];
//    if (cacheObject) {
//        [self setImage:cacheObject.UIImage];
//        return;
//    }
    
//    [self.svgImageDic removeAllObjects];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        // 处理耗时操作的代码块...
        //通知主线程刷新
        NSData *svgImageData = [NSData dataWithContentsOfURL:url];
         SVGKImage *theSvgImage;
         if (svgImageData) {
             theSvgImage = [SVGKImage imageWithData:svgImageData];
         }


        dispatch_async(dispatch_get_main_queue(), ^{

//            [self.svgImageDic setObject:theSvgImage forKey:url];
            //回调或者说是通知主线程刷新
            if (theSvgImage && theSvgImage.UIImage) {
                [self setImage:theSvgImage.UIImage];
            }else
            {
                [self setImage:placeholder];
            }

        });

    });

    
 
//    SVGKImage *theSvgImage = [SVGKImage imageWithData:[NSData dataWithContentsOfURL:url]];

}
@end
