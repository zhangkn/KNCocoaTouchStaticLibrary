//
//  Const.m  定义const 全局常量  ,保证只在一处定义，多处进行引用
//  HWeibo
//
//  Created by devzkn on 05/10/2016.
//


//#define HWClientId @"647592779"//宏会在编译时，将所有引用宏变量的地方，进行值的替换，造成很多相同的临时字面量，浪费内存

#import <Foundation/Foundation.h>
NSString *const PRODUCTIONBaseURL = @"https:///merchant/user/service/";
NSString *const PREBaseURL = @"https:///merchant/user/service/";
NSString *const UATBaseURL = @"https://www.baidu.com";
NSString *const SITINTRANETBaseURL = @"https:///merchant/user/service/";
NSString *const SITEXTRANETBaseURL = @"https:///merchant/user/service/";
