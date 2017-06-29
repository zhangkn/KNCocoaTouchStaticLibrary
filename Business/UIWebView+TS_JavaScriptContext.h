//
//  UIWebView+TS_JavaScriptContext.h
//  HeJuBao
//
//  Created by devzkn on 4/13/16.
//  Copyright © 2016 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol TSWebViewDelegate <UIWebViewDelegate>

@optional

- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext*) ctx;

@end


@interface UIWebView (TS_JavaScriptContext)

@property (nonatomic, readonly) JSContext* ts_javaScriptContext;

@end
