//
//  HWPlaceholderTextView.h
//  HWeibo
//
//  Created by devzkn on 9/30/16.
//
#import <UIKit/UIKit.h>
#import "UIView+Extension.h"
#import "NSString+Extension.h"
#import "Const.h"

#define HWTextViewFont  [UIFont systemFontOfSize:14]
#define  KNFeedBackColor   KNColor(174, 175, 175)

@interface HWPlaceholderTextView : KNUITextView
/** 占位符内容*/
@property (nonatomic,copy) NSString *textViewPalceHolder;
/** 占位符的颜色*/
@property (nonatomic,strong) UIColor *textViewPalceHolderColor;

@property (nonatomic,assign) BOOL hiddentextViewPalceHolder;

+ (instancetype) placeholderTextView;
/**
 通过数据模型设置视图内容，可以让视图控制器不需要了解视图的细节
 */
+ (instancetype) placeholderTextViewWithTextViewPalceHolder:(NSString *) textViewPalceHolder;







@end
