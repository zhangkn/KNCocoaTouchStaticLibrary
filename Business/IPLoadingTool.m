//
//  IPLoadingTool.m
//  iCloudPay
//
//  Created by devzkn on 24/03/2017.
//  Copyright © 2017 Kevin. All rights reserved.
//

#import "IPLoadingTool.h"
#import <UIKit/UIKit.h>

@interface IPLoadingTool ()


@end

@implementation IPLoadingTool


static  UIWindow *_winLoading ;



+(void)StartLoading
{
    //------------------------------
    // 模式窗口的loading
    _winLoading = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _winLoading.windowLevel = UIWindowLevelAlert;
    
    // 菊花
    UIActivityIndicatorView * aivMSG = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    aivMSG.transform = CGAffineTransformMakeScale(2, 2);
    aivMSG.center = _winLoading.center;
    [aivMSG startAnimating];
    
    [_winLoading addSubview:aivMSG];
    
    [_winLoading makeKeyAndVisible];
    
    
}


+(void)StopLoading
{
    _winLoading.hidden = YES;
    _winLoading = nil;
}


@end
