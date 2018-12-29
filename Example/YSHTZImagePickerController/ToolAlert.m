//
//  ToolAlert.m
//  YSHTZImagePickerController_Example
//
//  Created by shuhui on 2018/12/29.
//  Copyright © 2018 793983383@qq.com. All rights reserved.
//

#import "ToolAlert.h"

@implementation ToolAlert

+(UIAlertController*)AlertControllerWithVC:(UIViewController *)vc
                                     title:(NSString *)title
                                   message:(NSString *)message
                                     style:(UIAlertControllerStyle)style
                                 callBlock:(void(^)(NSInteger tag))callBlock
                        confirmButtonTitle:(nullable NSString *)confirmButtonTitle
                         cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                    otherButtonTitlesArray:(nullable NSArray <NSString *>*)otherButtonTitlesArray

{
    
    
    
    
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:style];
    
    
    
    
    if (otherButtonTitlesArray) {
        for (NSInteger i = 0 ; i<otherButtonTitlesArray.count; i++) {
            NSString * title = otherButtonTitlesArray[i];
            UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {
                                                                       
                                                                       if (callBlock) {
                                                                           callBlock(i);
                                                                       }                                                               }];
            
//            [defaultAction1 setValue:[UIColor colorWithHexString:@"#333333"]
//                              forKey:@"titleTextColor"];
            [alert addAction:defaultAction1];
            
        }
    }
    
    
    if (cancelButtonTitle) {
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * action) {
                                                           
                                                           if (callBlock) {
                                                               callBlock(-1);
                                                           }
                                                           
                                                       }];
//        [cancel setValue:[UIColor colorWithHexString:@"#ff7300"] forKey:@"titleTextColor"];
        
        
        [alert addAction:cancel];
        
    }
    
    if (confirmButtonTitle) {
        UIAlertAction* confirmButton = [UIAlertAction actionWithTitle:confirmButtonTitle style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                                  if (callBlock) {
                                                                      callBlock(-2);
                                                                  }
                                                                  
                                                              }];
//        [confirmButton setValue:[UIColor colorWithHexString:@"#21ba65"] forKey:@"titleTextColor"];
        
        
        [alert addAction:confirmButton];
        
    }
    
    //修改message
    if (alert.message) {
        
        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:alert.message];
        [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:UIColor.redColor range:NSMakeRange(0, alert.message.length)];
        [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, alert.message.length)];
        [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];
    }
    
    
    
    [vc presentViewController:alert animated:YES completion:nil];
    
    return alert;
    
    
}
@end
