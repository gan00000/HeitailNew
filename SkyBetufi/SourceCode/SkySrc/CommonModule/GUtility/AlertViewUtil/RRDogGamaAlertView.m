//
//
//
//
//
//
//

#import "RRDogGamaAlertView.h"

#define GamaAlertViewShowTime   2.0

@implementation RRDogGamaAlertView

//static NSArray<UIViewController *> *presentViewControllers;


#pragma mark - Alert
//简单显示Alert的方法
//+(UIAlertView *)showAlertWithMessage:(NSString *)message
//{
//
//    NSString *tmp = GAMA_GET_INFO(GAMA_TITLE_ALERT_SURE_BTN_TITLE);
//
//    return [self showAlertWithMessage:message
//                           completion:nil
//                      andButtonTitles:tmp, nil];
//}
//
////显示允许更多定制的方法
//+(UIAlertView *)showAlertWithMessage:(NSString *)message
//                          completion:(GamaAlertViewHandler)handler
//                     andButtonTitles:(NSString *)buttonTitles,...
//{
//
//
//    NSMutableArray *tempArray = [NSMutableArray array];
//
//    va_list args;
//    va_start(args, buttonTitles);
//
//    for (NSString *str = buttonTitles; str != nil; str = va_arg(args,NSString*))
//    {
//        [tempArray addObject:str];
//    }
//    va_end(args);
//
//    return [self _showAlertViewWithTitle:nil
//                                 message:message
//                            buttonTitles:[NSArray arrayWithArray:tempArray]
//                              completion:handler];
//}
//
////yao: 显示定制的alertView
//+ (UIAlertView *)showAlertViewWithTitle:(NSString *)title
//                                message:(NSString *)message
//                             completion:(GamaAlertViewHandler)handler
//                           buttonTitles:(NSString *)buttonTitles,...
//{
//
//
//    NSMutableArray *tempArray = [NSMutableArray array];
//
//    va_list args;
//    va_start(args, buttonTitles);
//
//    for (NSString *str = buttonTitles; str != nil; str = va_arg(args,NSString*))
//    {
//        [tempArray addObject:str];
//    }
//
//    va_end(args);
//
//    return [self _showAlertViewWithTitle:title
//                                 message:message
//                            buttonTitles:[NSArray arrayWithArray:tempArray]
//                              completion:handler];
//}
//
//+ (UIAlertView *)_showAlertViewWithTitle:(NSString *)title
//                                 message:(NSString *)message
//                            buttonTitles:(NSArray *)buttonTitles
//                              completion:(GamaAlertViewHandler)handler
//{
//    if ([GamaFunction getSystemVersion].intValue >= 8)//yao: 用alertController方法
//    {
//
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
//                                                                                 message:message
//                                                                          preferredStyle:UIAlertControllerStyleAlert];
//
//        NSInteger index = 0;
//        //yao: 添加各種按鈕actions
//        for (NSString *str in buttonTitles)
//        {
//            UIAlertAction *action = [UIAlertAction actionWithTitle:str
//                                                             style:UIAlertActionStyleDefault
//                                                           handler:^(UIAlertAction *action)
//                                     {
//                                         if (handler) handler(index);
//                                     }];
//
//            index++;
//
//            [alertController addAction:action];
//        }
//
//        [alertController show];
//        return nil;
//    }
//    else//yao: 用alertView方法
//    {
//        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:title
//                                                      message:message
//                                                     delegate:
//                             [RRDogGamaAlertViewDelegate creatDelegateWithBack:handler]
//                                            cancelButtonTitle:nil
//                                            otherButtonTitles:nil];
//        //添加各種按鈕
//        for (NSString *str in buttonTitles)
//        {
//            [alert addButtonWithTitle:str];
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [alert show];
//            [alert autorelease];
//        });
//        return alert;
//    }
//}

#pragma mark - ActionSheet
+ (void)showActionSheetWithTitle:(NSString *)title
                         message:(NSString *)message
                   callbackBlock:(void(^)(NSInteger btnIndex))block
          destructiveButtonTitle:(NSString *)destructiveBtnTitle
               cancelButtonTitle:(NSString *)cancelBtnTitle
               otherButtonTitles:(NSArray *)otherButtonTitles

{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    //添加按钮
    if (destructiveBtnTitle) {
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveBtnTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            block(0);
        }];
        [alertController addAction:destructiveAction];
    }
    if (cancelBtnTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            if (destructiveBtnTitle) {block(1);}
            else {block(0);}
        }];
        [alertController addAction:cancelAction];
    }
    if (otherButtonTitles.count > 0)
    {
        int count = 1;
        if (!cancelBtnTitle && !destructiveBtnTitle) {count = 0;}
        else if ((cancelBtnTitle && !destructiveBtnTitle) || (!cancelBtnTitle && destructiveBtnTitle)) {count = 1;}
        else if (cancelBtnTitle && destructiveBtnTitle) {count = 2;}
        
        for (NSString *btnTitle in otherButtonTitles) {
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                block(count);
            }];
            [alertController addAction:otherAction];
            
            count ++;
        }
    }
    
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    
    //如果没有按钮，自动延迟消失
//    if (cancelBtnTitle == nil && destructiveBtnTitle == nil && otherButtonTitles == nil) {
//        [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:GamaAlertViewShowTime];
//    }
}

+ (void)dismissAlertView:(UIAlertView*)alertView
{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}
+ (void)dismissActionSheet:(UIActionSheet *)actionSheet
{
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}
+ (void)dismissAlertController:(UIAlertController *)alert
{
    [alert dismissViewControllerAnimated:YES completion:nil];
}

@end
