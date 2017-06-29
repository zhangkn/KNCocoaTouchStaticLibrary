//
//  HSSingleton.h
//  20160504非ARC的单例模式
//
//  Created by devzkn on 5/4/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#ifndef HSSingleton_h
#define HSSingleton_h


//头文件的单例内容
#define HSSingletonH(classname) +(instancetype)share##classname

//.m文件的单例代码
#if __has_feature(objc_arc)

#define HSSingletonM(classname) \
static id _instance;\
+(instancetype)share##classname{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[self alloc]init];\
});\
return _instance;\
}\
- (id)copyWithZone:(NSZone *)zone{\
return _instance;\
}\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}

#else

#define HSSingletonM(classname) \
static id _instance;\
+(instancetype)share##classname{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instance = [[self alloc]init];\
    });\
    return _instance;\
}\
- (id)copyWithZone:(NSZone *)zone{\
    return _instance;\
}\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instance = [super allocWithZone:zone];\
    });\
    return _instance;\
}\
- (oneway void)release{\
}\
- (instancetype)retain{\
    return self;\
}\
- (NSUInteger)retainCount{\
    return 1;\
}\
- (instancetype)autorelease{\
    return self;\
}
#endif
#endif /* HSSingleton_h */
