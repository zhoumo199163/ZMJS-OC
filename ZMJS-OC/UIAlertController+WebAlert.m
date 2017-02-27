//
//  UIAlertController+WebAlert.m
//  ZMJS-OC
//
//  Created by zm on 2017/2/24.
//  Copyright © 2017年 zm. All rights reserved.
//

#import "UIAlertController+WebAlert.h"
#import "AppDelegate.h"

@implementation UIAlertController (WebAlert)

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
               cancelButtonTitle:(NSString *)cancelTitle
       cancelButtonHandler:(cancelBlock)handler{
    AppDelegate *appDelegate =(AppDelegate *) [UIApplication sharedApplication].delegate;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if(cancelTitle){
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            handler();
        }];
        [alertController addAction:cancelAction];
    }
    [appDelegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}

@end
