//
//

#import "HCPPopLoadingDialog.h"

@implementation HCPPopLoadingDialog

@synthesize superView;
@synthesize backgroundView;
@synthesize backgroundImage;
@synthesize contentView;

static HCPPopLoadingDialog *_sharedClient = nil;

/** 
 
 Unknown class MyClass in Interface Builder file.
 由于静态框架采用静态链接，linker会剔除所有它认为无用的代码。不幸的是，linker不会检查xib文件，因此如果类是在xib中引用，而没有在O-C代码中引用，linker将从最终的可执行文件中删除类。这是linker的问题，不是框架的问题（当你编译一个静态库时也会发生这个问题）。苹果内置框架不会发生这个问题，因为他们是运行时动态加载的，存在于iOS设备固件中的动态库是不可能被删除的。
 有两个解决的办法：
 1.让框架的最终用户关闭linker的优化选项，通过在他们的项目的Other Linker Flags中添加-ObjC和-all_load。
 2.在框架的另一个类中加一个该类的代码引用。例如，假设你有个MyTextField类，被linker剔除了。假设你还有一个MyViewController，它在xib中使用了MyTextField，MyViewController并没有被剔除。你应该这样做：
 在MyTextField中：
 + (void)forceLinkerLoad_ {}
 在MyViewController中：
 +(void) initialize {     [MyTextField forceLinkerLoad_]; }
 他们仍然需要添加-ObjC到linker设置，但不需要强制all_load了。
 第2种方法需要你多做一点工作，但却让最终用户避免在使用你的框架时关闭linker优化（关闭linker优化会导致object文件膨胀）。
 */
+ (void)initialize{
    [HCPCMPayProgress class];
}


+ (instancetype)sharedClient {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[HCPPopLoadingDialog alloc] init];
    });
    
    return _sharedClient;
}

-(UIImage *) pngWithPath:(NSString *)path{
    NSString *fileLocation = [[NSBundle mainBundle]pathForResource:path ofType:@"png"];
    NSData *imageData = [NSData dataWithContentsOfFile:fileLocation];
    UIImage *img=[UIImage imageWithData:imageData];
    
    return img;
}


-(id)init
{
    if (self=[super init]) {
        
//        
//#define MYBUNDLE_NAME @"KNStaticBundle.bundle"
//        
//#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
//#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]
        

        //内容view
//        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//        NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:MYBUNDLE_NAME withExtension:nil]];
//        self = [bundle loadNibNamed:@"PassWordKeyBoard" owner:nil options:nil].firstObject;
//        self.cmpayProgress = [[bundle loadNibNamed:@"CMPayProgress" owner:nil options:nil] firstObject];
        self.cmpayProgress = [[MYBUNDLE loadNibNamed:@"HCPCMPayProgress" owner:nil options:nil] firstObject];
        CGRect fullRect = [UIScreen mainScreen].bounds;
        self.contentView = [[UIView alloc] initWithFrame:fullRect];
//
        [self.cmpayProgress.layer masksToBounds];
        self.cmpayProgress.layer.cornerRadius = 4.0;
        
        self.cmpayProgress.center = CGPointMake(fullRect.size.width / 2, fullRect.size.height / 2);//只能设置中心
//        self.indicatorView.color = [UIColor grayColor]; // 改变圈圈的颜色为红色； iOS5引入
        
//        [self.contentView addSubview:self.indicatorView];
        
        //蒙版 透明
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.contentView.bounds.size.width,self.contentView.bounds.size.height)];
        [bgView setBackgroundColor:[UIColor clearColor]];
//        [bgView setAlpha:0];
        [self.contentView addSubview:bgView];
        
        [self.contentView addSubview:self.cmpayProgress];
        
        //初始化主屏幕
        [self setFrame:[UIScreen mainScreen].bounds];
        self.windowLevel =UIWindowLevelStatusBar;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        
        //添加根view，并且将背景设为透明.
        UIView *rv = [[UIView alloc]initWithFrame:[self bounds]];
        self.superView = rv;
        [superView setAlpha:0.0f];
        [self addSubview:superView];
        
        //设置background view.
        CGFloat offset = -6.0f;
        UIView *bv = [[UIView alloc]initWithFrame:CGRectInset(CGRectMake(0,0,self.contentView.bounds.size.width,self.contentView.bounds.size.height), offset, offset)];
        self.backgroundView = bv;
        
        
//        用圆角png图片设为弹出窗口背景.
        UIImageView *bi = [[UIImageView alloc]initWithImage:[[self pngWithPath:@"alert_window_bg"]stretchableImageWithLeftCapWidth:13.0 topCapHeight:9.0]];
        
        self.backgroundImage = bi;
        
        [backgroundImage setFrame:[backgroundView bounds]];
        
        [backgroundView insertSubview:backgroundImage atIndex:0];
        
        
        [backgroundView setCenter:CGPointMake(superView.bounds.size.width/2,superView.bounds.size.height/2)];
        
//        [backgroundView setBackgroundColor:[UIColor blackColor]];
//        [backgroundView setAlpha:0.6];
        
        [superView addSubview:backgroundView];
        
        CGRect frame =CGRectInset([backgroundView bounds], -1 * offset, -1 * offset);
        //显示内容view
        [backgroundView addSubview:self.contentView];
        [self.contentView setFrame:frame];
        
        closed =NO;
    }
    return self;
}

//显示弹出窗口
//+(void)show {
//    [[PopLoadingDialog sharedClient] makeKeyAndVisible];
//    [[PopLoadingDialog sharedClient].superView setAlpha:1.0f];
//
//    [[PopLoadingDialog sharedClient].hebaoProgress Show];
////    [[PopLoadingDialog sharedClient].indicatorView startAnimating];
//}
+(void)show{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[HCPPopLoadingDialog sharedClient] makeKeyAndVisible];
    });

    [[HCPPopLoadingDialog sharedClient].superView setAlpha:1.0f];
    [[HCPPopLoadingDialog sharedClient].cmpayProgress Show];
}



+(void)dismiss{
    //    [[PopLoadingDialog sharedClient].indicatorView stopAnimating];
    //    [[PopLoadingDialog sharedClient].hebaoProgress Hide];
    [[HCPPopLoadingDialog sharedClient].cmpayProgress Hide];
    dispatch_async(dispatch_get_main_queue(), ^{
        [HCPPopLoadingDialog sharedClient].hidden = YES;
    });
}

+(BOOL) isShown {
    return ![HCPPopLoadingDialog sharedClient]->closed;
}

@end
