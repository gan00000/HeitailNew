//
//
//
//
//
//
//

/*
 自定义的UIAlertView代理类，可以直接放在uiAlertView Delegate中使用，Alert多按钮时候，不用烦恼指定谁为代理。
 通过block返回用户触发的按钮；点击按钮以后，这个代理对象会自动释放掉。
 这个类的对象，直接被“GamaAlertView”调用了。
 */

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

/**
 *	@brief	回调函数，自定义black
 *
 *	@param 	^GamaAlertViewHandler
 */
typedef void (^GamaAlertViewHandler)(NSInteger clickedBtnIndex);


@interface GamaAlertViewDelegate : NSObject
<UIAlertViewDelegate,UIActionSheetDelegate>

/**
 *	@brief	代理对象自己保存的black，用于回调。
 */
@property (nonatomic,copy) GamaAlertViewHandler handler;

/**
 *	@brief	创建一个AlertView代理对象，并且为该代理对象传递一个回调函数：
 回调函数：当用户点击了某个按钮以后，可以通过回调，返回用户点击的按钮位置。
 之后该对象会自己释放掉。
 *
 *	@param 	oneHandler 	回调函数，定义类型参考上面
 *
 *	@return	一个代理类型的对象。
 */
+(GamaAlertViewDelegate *)creatDelegateWithBack:(GamaAlertViewHandler)oneHandler;


@end
