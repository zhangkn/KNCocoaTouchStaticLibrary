//
//  KNBaseViewController.m
//  KNCocoaTouchStaticLibrary
//
//  Created by devzkn on 25/04/2018.
//  Copyright © 2018 hisun. All rights reserved.
//

#import "KNBaseViewController.h"

@interface KNBaseViewController ()

@end

@implementation KNBaseViewController


-(void)ShowSysMessageBox:(NSString*)strText
{
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:strText delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [av show];
}

@end
