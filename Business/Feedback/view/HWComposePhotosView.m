//
//  HWCoposePhotosView.m
//  HWeibo
//
//  Created by devzkn on 01/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HWComposePhotosView.h"
#import "UIView+Extension.h"
#import "KNShowImageView.h"
//图片上传接口暂时废弃
//#import "NSMutableURLRequestTool.h"

#define KNPhotosCounts 8  //图片个数限制

@interface HWComposePhotosView ()<KNShowImageViewDelegate>

@property (nonatomic,weak) UIButton *addPhotoButton;

@end

@implementation HWComposePhotosView

#pragma mark - KNShowImageViewDelegate

- (void)KNshowImageViewDidClickDeleteBtn:(KNShowImageView *)imageView{
    self.addPhotoButton.hidden = NO;
}

- (UIButton *)addPhotoButton{
    if (nil == _addPhotoButton) {
        UIButton *tmpView = [[KNUIButton alloc]init];
        _addPhotoButton = tmpView;
        NSString *image = [[NSBundle mainBundle] pathForResource:@"store_add.png" ofType:nil inDirectory:MYBUNDLE_NAME];
        [tmpView setImage:[UIImage imageWithContentsOfFile:image] forState:UIControlStateNormal];
        [tmpView addTarget:self action:@selector(clickAddPhotoButton) forControlEvents:UIControlEventTouchUpInside];
        tmpView.backgroundColor =[UIColor whiteColor];
        [self addSubview:_addPhotoButton];
    }
    return _addPhotoButton;
}

- (void)clickAddPhotoButton{
    if ([self.delegate respondsToSelector:@selector(composePhotosViewDidClickAddPhoto:)]) {
        [self.delegate composePhotosViewDidClickAddPhoto:self];
    }
}

- (NSArray *)getphotos{
    NSMutableArray *tmp = [NSMutableArray array];
    for (KNShowImageView *obj in self.subviews) {
        if ([obj isKindOfClass:[KNShowImageView class]]) {
            //根据图片的type 进行转换成date
//            [tmp addObject:[KNNSMutableURLRequestTool processPictureSizeWithimage:obj.image]];
        }
    }
    return tmp;
}

- (BOOL)hasComposePhotos{
    return  [[self getphotos] count]>0;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    int maxclos = 4;//最大列数
    CGFloat margin = 0;
    CGFloat w = (self.frame.size.width - margin*(maxclos-1))/maxclos;
    CGFloat h = w*(234/132.0);//宽高比 123/234
    //计算子空间frame
    for (int i=1 ; i<self.subviews.count; i++) {
        KNUiImageView *tmp= nil;
        if ([self.subviews[i] isKindOfClass:[KNShowImageView class]]) {
          tmp = (KNUiImageView*)self.subviews[i];
        }else{
            break;
        }
        if (tmp == nil) {
            break;
        }
        //计算frame： 列数决定x,行数决定y
        int row = (i-1)/maxclos;
        int clo = (i-1)%maxclos;
        tmp.KNX = clo*(w+margin);
        tmp.KNY = row*(h+margin);
        tmp.KNWidth = w;
        tmp.KNHeight = h;
        
    }
    
    if (self.subviews.count>=(KNPhotosCounts+1)) {
        self.addPhotoButton.hidden = YES;
        return;
    }
    //设置addButton的frame
    CGFloat tmpw = w- (2*KNDeleteH);
//    CGFloat tmpH = tmpw * (234/132.0);
    CGFloat tmpH = h - (2*KNDeleteH);
    self.addPhotoButton.KNSize = CGSizeMake(tmpw,tmpH);
    long tmprow = (self.subviews.count-1)/maxclos;
    long tmpclo = (self.subviews.count-1)%maxclos;
    self.addPhotoButton.KNX = tmpclo*( w+ margin) +KNDeleteH ;
    self.addPhotoButton.KNY = tmprow *(h +margin) +(KNDeleteH);
    
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //设置自己属性
        //构建子控件
        [self setupAddButton];
    }
    return self;
}



- (void)setupAddButton{
    self.addPhotoButton.hidden = NO;
    
}


/** 往视图增加图片*/
- (void)addPhoto:(UIImage *)image{
    if (self.subviews.count>= (KNPhotosCounts+1)) {
        return;
    }
    if (self.subviews.count<=KNPhotosCounts) {
        self.addPhotoButton.hidden = NO;//显示添加图片按钮
    }else{
        self.addPhotoButton.hidden = YES;
    }
    
    KNShowImageView *tmp = [[KNShowImageView alloc]init];
    tmp.delegate = self;
    tmp.image = image;
    [self addSubview:tmp];
}




@end
