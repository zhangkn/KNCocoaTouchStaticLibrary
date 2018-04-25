//
//  Const.h  ,只要引用此.h 文件，即可食用本头文件extern的全局变量
//  HWeibo
//  Created by devzkn on 05/10/2016.
//声明需要全局常量，避免多处声明一样的全局常量
//
#import <Foundation/Foundation.h>
#import "KNView.h"
#import "KNUITextView.h"
#import "KNUiImageView.h"
#import "KNUIButton.h"
#import "KNUILabel.h"
/** 即访问其他类定义的全局常量 HWClientId */
//extern NSString * const HWClientId ; //声明全局常量变量（引用某个常量，来避免多处定义同一个全局变量，导致重复定义错误）通常是在定义全局常量的

//RGB 颜色
#define KNColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define KMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define KMainScreenHeight [UIScreen mainScreen].bounds.size.height


//  Created by devzkn on 10/01/2017.
#define weakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;
extern   NSString *const PRODUCTIONBaseURL;
extern   NSString *const PREBaseURL ;
extern   NSString *const UATBaseURL;
extern   NSString *const SITINTRANETBaseURL ;
extern   NSString *const SITEXTRANETBaseURL ;
