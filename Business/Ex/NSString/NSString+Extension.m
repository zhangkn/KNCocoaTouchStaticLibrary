//
//  NSString+Extension.m
//  HWeibo
//
//  Created by devzkn on 9/29/16.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


-(CGSize) sizeWithTextFont:(UIFont *)font{
    /** 方式一*/
    //    NSDictionary *tmpDict = @{NSFontAttributeName: font};
//       return  [self sizeWithAttributes:tmpDict];
    /** 方式2*/
//    return    [self sizeWithFont:font];//过期，表示不再更新潜在bug，但还是仍可使用
    /** 方式3*/
    return  [self sizeWithFont:font maxW:CGFLOAT_MAX];
}
#define  IOSSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]
-(CGSize) sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW{
    CGSize maxSize = CGSizeMake(maxW, CGFLOAT_MAX);
    if (IOSSystemVersion>=7.0) {
        NSDictionary *tmpDict = @{NSFontAttributeName: font};
        return  [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:tmpDict context:nil].size;//NS_AVAILABLE(10_11, 7_0); 7.0  才支持
    }else{
        return [self sizeWithFont:font constrainedToSize:maxSize];
    }
}

@end
