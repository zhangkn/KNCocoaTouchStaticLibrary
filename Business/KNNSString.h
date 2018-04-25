//
//  KNNSString.h
//  KNCocoaTouchStaticLibrary
//
//  Created by devzkn on 25/04/2018.
//  Copyright © 2018 hisun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface KNNSString : NSString

-(CGSize) sizeWithTextFont:(UIFont *)font;
/** 根据字体和给定的最大宽度计算字符串的size*/
-(CGSize) sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;



@end
