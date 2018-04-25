//

//

#import <UIKit/UIKit.h>
#define KNDeleteH 7 //删除按钮的高度的一半
#import "Const.h"

@class KNShowImageView;
//KNShowImageViewDelegate
@protocol  KNShowImageViewDelegate <NSObject>

- (void) KNshowImageViewDidClickDeleteBtn:(KNShowImageView*)imageView;

@end

@interface KNShowImageView :KNView
/** 展示的图片*/
@property (nonatomic,copy) UIImage *image;

@property (nonatomic,assign) id<KNShowImageViewDelegate> delegate;


@end
