//
//  KNBaseWebViewController.m
//  KNUIWebViewWithFileInput
//
//  Created by devzkn on 27/03/2017.
//

#import "KNBaseWebViewController.h"
#import "UIWebView+TS_JavaScriptContext.h"
#import "HCPEnvrionmentalVariables.h"
#import "Const.h"
#import "IPLoadingTool.h"

@interface KNBaseWebViewController ()

@property (nonatomic,strong) UIView  *statusBarView;
@property (nonatomic,weak) UIWebView  *webView;
@property (nonatomic,strong) UIAlertView *meaasgeAlertView;

@property (nonatomic,assign) BOOL flagged;
@end





@implementation KNBaseWebViewController

static  CGFloat const statusBarViewHeight = 20;


- (void)setY:(CGFloat)y  view :(UIView*)view{
    CGRect frame = view.frame;
    frame.origin.y = y;
    view.frame = frame;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self setY: CGRectGetMaxY(self.statusBarView.frame) view:self.webView];
}
//
//-(UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}

- (UIView *)statusBarView{
    if (nil == _statusBarView) {
        
//        如果View controller-based status bar appearance为YES。
//        
//        则[UIApplication sharedApplication].statusBarStyle 无效。
        //设置状态栏为白色
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];//此方法展示的效果更明显
        
        /** 
         
         三、设置状态栏字体颜色
         
         
         方式一：
         
         （在info.plist中，将View controller-based status bar appearance设为YES，或者没有设置。View controller-based status bar appearance的默认值就是YES。）
         
         1、在info.plist中，将View controller-based status bar appearance设为NO.
         2、在app delegate中：[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
         方式二：
         1.VC中重写     -- webView 控制器就可以用此种方法
         -(UIStatusBarStyle)preferredStatusBarStyle
         2、在viewDidload中调用：[self setNeedsStatusBarAppearanceUpdate];
         
         但是：当vc在nav中时，上面方法没用，vc中的preferredStatusBarStyle方法根本不用被调用。
         原因是，[self setNeedsStatusBarAppearanceUpdate]发出后，只会调用navigation controller中的preferredStatusBarStyle方法，vc中的preferredStatusBarStyley方法跟本不会被调用。
         
         解决方法：
         self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
         或者
         定义一个nav bar的子类，在这个子类中重写preferredStatusBarStyle方法：
         
         
         */
        
        
        
        _statusBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, statusBarViewHeight)];
//        _statusBarView.hidden = YES;
        [self.view addSubview:_statusBarView];
    }
    return _statusBarView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setNeedsStatusBarAppearanceUpdate];
//    self.statusBarView.hidden = NO;

    
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;//禁止UIWebView滚动和回弹方法
    [self setupRequest];
    
    
    
    
}


- (void)setupRequest{
    
    NSString *strurl = @"";
    
    switch ([HCPEnvrionmentalVariables shareEnvrionmentalVariables].envrionmentalVariables) {
        case ENVRIONMENTAL_VARIABLES_PRODUCTION:
            strurl = PRODUCTIONBaseURL;
            break;
            
        case ENVRIONMENTAL_VARIABLES_PRE:
            strurl = PREBaseURL;
            NSLog(@"%@",strurl);
            break;
        case ENVRIONMENTAL_VARIABLES_UAT:
            strurl = UATBaseURL;
            
            break;
        case ENVRIONMENTAL_VARIABLES_SIT_INTRANET:
            strurl = SITINTRANETBaseURL;
            
            break;
            
        case ENVRIONMENTAL_VARIABLES_SIT_EXTRANET:
            strurl = SITEXTRANETBaseURL;
            
            break;
    }
    
    //／    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:strurl]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:strurl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    
    //     NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    
    [self.webView loadRequest:request];
    
}





- (UIWebView *)webView{
    if (nil == _webView) {
        UIWebView *tmpView = [[UIWebView alloc]init];
        _webView = tmpView;
        //        tmpView.delegate = self;
        tmpView.frame = self.view.bounds;
//        tmpView.scalesPageToFit = YES;//A Boolean value determining whether the webpage scales to fit the view and the user can change the scale.
        [self.view addSubview: _webView];
    }
    return _webView;
}




#pragma mark - TSWebViewDelegate
//@import JavaScriptCore;
//1、定义
//@protocol JavaScriptObjectExport <JSExport>  使用这个定义与js 的交互。提供接口给js 调用
// NSObject <JavaScriptObjectExport>
//2、注入
//JSContext *context=[self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//context[@"__app"] = self.javaScriptObj;
- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext *)ctx{
    //js 接口
    
    /**对于非ARC下, 为了防止循环引用, 我们使用__block来修饰在Block中使用的对象:
     *对于ARC下, 为了防止循环引用, 我们使用__weak来修饰在Block中使用的对象。
     */
    weakSelf(weakSelf); // 声明对象赋值self,使用__block修饰，目的是在block内部使用的时候不会造成控制器引用计数+1
    //// 回到登陆控制器
    ctx[@"backCoudIPSAPP"] = ^() {
        [self exitSelf];
    };
    
}

- (void)exitSelf{
    
    [super dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

#pragma mark - webView代理方法



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //    [MBProgressHUD hideHUD];
//    [IPLoadingTool StopLoading];
    [HCPPopLoadingDialog dismiss];

    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //    [MBProgressHUD showMessage:@"正在加载..."];
//    [IPLoadingTool StartLoading];
    
    [HCPPopLoadingDialog show];


}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [IPLoadingTool StopLoading];
    //    网络连接超时，请刷新重试
    NSString *strText =@"网络连接失败，请检查网络，或刷新重试";
    self.meaasgeAlertView = [[UIAlertView alloc]initWithTitle:@"" message:strText delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"刷新", nil];
    [self.meaasgeAlertView show];
    
    
}

#pragma mark -alertViewDeleagte

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0){
    
    
    if(self.meaasgeAlertView == alertView){
        
        if(buttonIndex == 1){
            [self setupRequest];
        }else if(buttonIndex == 0){
            //退出本控制器
            [super dismissViewControllerAnimated:YES completion:^{
                
            }];
            
        }
        return;
    }
    
    
}

#pragma mark - ******** overriding following in the view controller containing the uiwebview

/**
 从消失dismissViewControllerAnimated方法来解决 webView 控制器消息
 
 UIDocumentMenuViewController关闭后不仅调用了自己的，dismissViewControllerAnimated，还调用了，上层或者上上层presentingViewController的dismissViewControllerAnimated。
 
 
 方法一，使dismissViewControllerAnimated调用一次
 当前ViewController的所有presentedViewController都正常执行dismissViewControllerAnimated，当前ViewController本身执行dismissViewControllerAnimated，不进行dismiss，不做处理。
 
 除非用户自己要求退出self.exitKNBaseWebViewControllerflagged = yes  或者 当想dismiss掉当前ViewController的时候，不能调用本身的dismissViewControllerAnimated ，直接调用父类的dismissViewControllerAnimated
 
 
 */
#if 1
-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    /**presentedViewController   本控制器即将present展示的控制器
     
     思路，第一次 UIDocumentMenuViewController 展示拍照和photo界面的控制器 消失
     第二次    self.presentedViewController nil  此时不调用dismissViewControllerAnimated,, 如果自己要消失的话，需要新增个标识，表示是用户要返回
     
     第三次 UIImagePickerController  相册、拍照控制器 消失
     
     */
    
    if ( self.presentedViewController )
    {
        [super dismissViewControllerAnimated:flag completion:completion];
    }
    
//    if (self.exitKNBaseWebViewControllerflagged) {
//        self.exitKNBaseWebViewControllerflagged = NO;
//        [super dismissViewControllerAnimated:flag completion:completion];
//    }
    
}
#endif



#pragma mark - Avoiding iOS bug
#if 0

/**
 从控制器展示的方法presentViewController，解决
 
 方法二，使UIDocumentMenuViewController找不到presentingViewController  
 
 */
- (UIViewController *)presentingViewController {
    
    // Avoiding iOS bug. UIWebView with file input doesn't work in modal view controller
    
    if (_flagged) {
        return nil;
    } else {
        return [super presentingViewController];
    }
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    
    // Avoiding iOS bug. UIWebView with file input doesn't work in modal view controller
    
    if ([viewControllerToPresent isKindOfClass:[UIDocumentMenuViewController class]]
        ||[viewControllerToPresent isKindOfClass:[UIImagePickerController class]]) {
        _flagged = YES;
    }
    
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}




#endif




@end
