//
//  HWCoposePhotosView.h
//  HWeibo
//
//  Created by devzkn on 01/10/2016.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Const.h"

@class HWComposePhotosView;


@protocol HWComposePhotosViewDelegate <NSObject>

@optional
- (void)composePhotosViewDidClickAddPhoto:(HWComposePhotosView*)composePhotosView;

@end

/** 九宫格 展示图片，用于发微博页面*/
@interface HWComposePhotosView : KNView

@property (nonatomic,assign) id<HWComposePhotosViewDelegate> delegate;

/** 往视图增加图片*/
- (void)addPhoto:(UIImage*)image;
/** */
- (NSArray*)getphotos;

- (BOOL)hasComposePhotos;





@end
