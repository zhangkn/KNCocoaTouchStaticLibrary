//

#import "HCPCMPayProgress.h"

//#define MYBUNDLE_NAME @"KNStaticBundle.bundle"
//
//#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
//#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]



@interface HCPCMPayProgress()

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, retain) NSTimer *timer;


@end

@implementation HCPCMPayProgress


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}


-(void)Show
{
    if (self.timer) {
        [self.timer setFireDate:[NSDate distantPast]];
    }else{
        self.index = 1;
        self.timer = [NSTimer timerWithTimeInterval:0.25 target:self selector:@selector(startAnimation) userInfo:nil repeats:YES];
         [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

-(void)Hide
{
//    self.index = 0;
    [self.timer setFireDate:[NSDate distantFuture]];
//    [self.timer invalidate];
//    [UIView animateWithDuration:0.25 animations:^{
//        
//    } completion:^(BOOL finished) {
////        self.alpha=0;
//        self.index = 0;
//        if (self.superview!=nil)
//        {
//            [self removeFromSuperview];
//        }
//    }];
}

- (void)startAnimation{
    
    [UIView animateWithDuration:0.15 animations:^{
        if (self.index == 1) {
            self.image1.image =[UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", MYBUNDLE_NAME, @"hebaoWhitePoint"]];
            self.image2.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", MYBUNDLE_NAME, @"hebaoGrayPoint"]];
            self.image3.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", MYBUNDLE_NAME, @"hebaoGrayPoint"]];
            self.index = self.index + 1;
        }else if (self.index == 2){
            self.image1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", MYBUNDLE_NAME, @"hebaoGrayPoint"]];
            self.image2.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", MYBUNDLE_NAME, @"hebaoWhitePoint"]];
            self.image3.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", MYBUNDLE_NAME, @"hebaoGrayPoint"]];
            self.index = self.index + 1;
        }else if (self.index == 3){
            self.image1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", MYBUNDLE_NAME, @"hebaoGrayPoint"]];
            self.image2.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", MYBUNDLE_NAME, @"hebaoGrayPoint"]];
            self.image3.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", MYBUNDLE_NAME, @"hebaoWhitePoint"]];
            self.index = 1;
        }else{
            return;
        }
        //递归
//        [self startAnimation];
    }];
    
}








@end
