//
//  ToolAlert.h
//  YSHTZImagePickerController_Example
//
//  Created by shuhui on 2018/12/29.
//  Copyright © 2018 793983383@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToolAlert : NSObject
/**
 UIAlertController的封装
 
 @param vc 视图控制器
 @param title 标题
 @param message 二级标题
 @param style  UIAlertControllerStyle UIAlertActionStyleDefault = 0,UIAlertActionStyleCancel,UIAlertActionStyleDestructive
 @param callBlock 点击事件 -1  取消 -2 确定 0 ,1 后面顺序为准
 @param confirmButtonTitle 确认按钮标题
 @param cancelButtonTitle 取消按钮标题
 @param otherButtonTitlesArray 其他按钮标题标题数组
 */
+(UIAlertController*)AlertControllerWithVC:(UIViewController *)vc
                                     title:(NSString *)title
                                   message:(NSString *)message
                                     style:(UIAlertControllerStyle)style
                                 callBlock:(void(^)(NSInteger tag))callBlock
                        confirmButtonTitle:(nullable NSString *)confirmButtonTitle
                         cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                    otherButtonTitlesArray:(nullable NSArray <NSString *>*)otherButtonTitlesArray;
@end

NS_ASSUME_NONNULL_END
