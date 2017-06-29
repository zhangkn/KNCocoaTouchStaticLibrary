//
//  KNBaseWebViewController.h
//  KNUIWebViewWithFileInput
//
//  Created by devzkn on 27/03/2017.
//  Copyright © 2017 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIWebView+TS_JavaScriptContext.h"
#import "HCPPopLoadingDialog.h"


/**
 
 问题：苹果的一个特性。当模态出N个ViewController之后，只需要dismiss任意一个，都会dismiss它之后的所有模态试图
 
 因此会导致modal模态出来的UIViewController中WebView的H5弹出Camera/ImagePicker 时，当UIDocumentMenuViewController消失的时候会导致WebView 所在的控制器也被干掉。
 
 总的解决思路
 所以使dismissViewControllerAnimated调用一次，或者让UIDocumentMenuViewController找不到presentingViewController即可。
 */
@interface KNBaseWebViewController : UIViewController <TSWebViewDelegate,UIAlertViewDelegate>

@end
