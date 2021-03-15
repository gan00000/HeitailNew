//
//
//
//
//
//
//

/*
 －弹出提示视图类
 －该弹出提示视图类提供两种类型提示
 简单提示：提示内容＋确定按钮
 代理提示：提示内容＋一个或多个选择按钮，选择按钮以后会有其他执行操作
 */
#import <Foundation/Foundation.h>

@interface GamaAlertView : NSObject


/**
 *	@brief	显示提示筐
    简单显示的方法，只提供一个显示的内容，和一个确定的按钮。
    按钮的文字读取“GamaCentreInfo.h”的配置。
 *
 *	@param 	message 	字符串，需要显示的提示内容。
 *
 *	@return	一个AlertView。
 */
//+(UIAlertView *)showAlertWithMessage:(NSString *)message;


/**
 *	@brief	显示提示筐 复杂的。
 可以展示提示内容，允许创建多个按钮，并且允许提供回调black，可获知用户点击了哪个按钮
 *
 *	@param 	message 	字符串，需要显示的提示内容。
 *	@param 	handler 	回调black函数，当用户点击了某个按钮以后，会返回按钮的index
 *	@param 	buttonTitles 	按钮的名称参数列表
 *
 *	@return	一个AlertView。
 */
//+(UIAlertView *)showAlertWithMessage:(NSString *)message
//                          completion:(GamaAlertViewHandler)handler
//                     andButtonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 *  yao:显示自定义的提示框，既有title又有message
 *
 *  @param title        大写的提示
 *  @param message      小写的提示
 *  @param handler      回调black函数，当用户点击了某个按钮以后，会返回按钮的index
 *  @param buttonTitles 按钮的名称参数列表
 *
 *  @return 一个AlertView
 */
//+ (UIAlertView *)showAlertViewWithTitle:(NSString *)title
//                                message:(NSString *)message
//                             completion:(GamaAlertViewHandler)handler
//                           buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;



+ (void)showActionSheetWithTitle:(NSString *)title
                         message:(NSString *)message
                   callbackBlock:(void(^)(NSInteger btnIndex))block
          destructiveButtonTitle:(NSString *)destructiveBtnTitle
               cancelButtonTitle:(NSString *)cancelBtnTitle
               otherButtonTitles:(NSArray *)otherButtonTitles;

@end
