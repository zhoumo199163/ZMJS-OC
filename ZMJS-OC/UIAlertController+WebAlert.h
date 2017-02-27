//
//  UIAlertController+WebAlert.h
//  ZMJS-OC
//
//  Created by zm on 2017/2/24.
//  Copyright © 2017年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^cancelBlock)();

@interface UIAlertController (WebAlert)
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelTitle
       cancelButtonHandler:(cancelBlock)handler;
@end
