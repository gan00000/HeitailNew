#import "UIImageView+NDeskGlodBuleSVG.h"
@implementation UIImageView (SkyBallHetiRedSVG)
- (void)svg_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder {
   
    NSString *urlKey = [url absoluteString];
    
    SVGKImage *cacheObject = [MMTodayHTUserManager.manager.svgImageCache objectForKey:urlKey];
    if (cacheObject) {
        if(cacheObject.UIImage){
            [self setImage:cacheObject.UIImage];
            return;
        }
       [MMTodayHTUserManager.manager.svgImageCache removeObjectForKey:urlKey];
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
                 [MMTodayHTUserManager.manager.svgImageCache setObject:theSvgImage forKey:urlKey];
            }
        });

    });

    
 
//    SVGKImage *theSvgImage = [SVGKImage imageWithData:[NSData dataWithContentsOfURL:url]];

}
@end
