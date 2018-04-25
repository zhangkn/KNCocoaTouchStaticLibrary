//
//  KNUILabel.m
//  KNCocoaTouchStaticLibrary
//
//  Created by devzkn on 25/04/2018.
//  Copyright © 2018 hisun. All rights reserved.
//

#import "KNUILabel.h"

@implementation KNUILabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setKNX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (void)setKNY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setKNCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setKNCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (void)setKNWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)setKNHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (void)setKNSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (void)setKNOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)KNX{
    return self.frame.origin.x;
}

-(CGFloat)KNY{
    return self.frame.origin.y;
}

- (CGFloat)KNCenterX{
    return self.center.x;
}

-(CGFloat)KNCenterY{
    return self.center.y;
}
- (CGFloat)KNWidth{
    return self.frame.size.width;
}

- (CGFloat)KNHeight{
    return self.frame.size.height;
}
- (CGSize)KNSize{
    return self.frame.size;
}

- (CGPoint)KNOrigin{
    return self.frame.origin;
}



@end
