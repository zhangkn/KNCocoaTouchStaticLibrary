
//
//  Created by devzkn on 04/11/2016.
//  Copyright © 2016 Hisun. All rights reserved.
//

#import "KNShowImageView.h"
#import "Const.h"
@interface KNShowImageView ()
@property (nonatomic,weak) KNUiImageView *imageView;

@property (nonatomic,weak) KNUIButton *deleteBtn;



@end


@implementation KNShowImageView
- (UIImageView *)imageView{
    if (nil == _imageView) {
        UIImageView *tmpView = [[KNUiImageView alloc]init];
        _imageView = tmpView;
        tmpView.contentMode = UIViewContentModeScaleAspectFill;
        tmpView.clipsToBounds = YES;
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UIButton *)deleteBtn{
    if (nil == _deleteBtn) {
        UIButton *tmpView = [[KNUIButton alloc]init];
        _deleteBtn = tmpView;
        [tmpView addTarget:self action:@selector(clickDeleteBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_deleteBtn];
    }
    return _deleteBtn;
}

- (void)clickDeleteBtn{
    if ([self.delegate respondsToSelector:@selector(KNshowImageViewDidClickDeleteBtn:)]) {
        [self.delegate KNshowImageViewDidClickDeleteBtn:self];
    }
    [self removeFromSuperview];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //设置自己属性
        //构建子控件
//        self.backgroundColor = [UIColor redColor];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    self.imageView.hidden = NO;
    
    [self.deleteBtn setImage:[self imageWithImageName:@"deleteX.png"] forState:UIControlStateNormal];
}

- (UIImage*)imageWithImageName:(NSString*)name{
    NSString *image = [[NSBundle mainBundle] pathForResource:name ofType:nil inDirectory:MYBUNDLE_NAME];
    return  [UIImage imageWithContentsOfFile:image];
}

- (void)setImage:(UIImage *)image{
    _image = image;
    
    self.imageView.image = image;
}


- (void)layoutSubviews{
    [super layoutSubviews];
//    self.imageView.frame = self.bounds;
    self.imageView.KNWidth = self.frame.size.width-(KNDeleteH*2);
    self.imageView.KNHeight = self.frame.size.width-(KNDeleteH*2);//宽高比 123/234;
    self.imageView.KNX =KNDeleteH;
    self.imageView.KNY = KNDeleteH;
    //布局btn
    self.deleteBtn.KNWidth = (2*KNDeleteH);
    self.deleteBtn.KNHeight = self.deleteBtn.KNWidth;
    self.deleteBtn.KNY = 0;
    self.deleteBtn.KNX = self.frame.size.width-(self.deleteBtn.KNWidth);
}
@end
