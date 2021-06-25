#import "UIImageView+BlysaNDeskSVG.h"
@implementation UIImageView (NDeskSVG)
- (void)svg_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder {
   
    NSString *urlKey = [url absoluteString];
    
    SVGKImage *cacheObject = [NSNiceHTUserManager.manager.svgImageCache objectForKey:urlKey];
    if (cacheObject) {
        if(cacheObject.UIImage){
            [self setImage:cacheObject.UIImage];
            return;
        }
       [NSNiceHTUserManager.manager.svgImageCache removeObjectForKey:urlKey];
    }
    
    [self setImage:placeholder];
//    [self.svgImageDic removeAllObjects];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        // 处理耗时操作的代码块...
        //通知主线程刷新
        NSData *svgImageData = [NSData dataWithContentsOfURL:url];
        SVGKImage *theSvgImage;
         if (svgImageData) {
             theSvgImage = [SVGKImage imageWithData:svgImageData];
         }
//        SVGKImage *theSvgImage = [SVGKImage imageWithContentsOfURL:url];

        dispatch_async(dispatch_get_main_queue(), ^{

            //回调或者说是通知主线程刷新
            if (theSvgImage && theSvgImage.UIImage) {
                [self setImage:theSvgImage.UIImage];
//                [NSUserDefaults.standardUserDefaults setObject:svgImageData forKey:];
                 [NSNiceHTUserManager.manager.svgImageCache setObject:theSvgImage forKey:urlKey];
            }
        });

    });

    
 
//    SVGKImage *theSvgImage = [SVGKImage imageWithData:[NSData dataWithContentsOfURL:url]];

}
@end
