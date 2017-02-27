//
//  WebViewController.m
//  ZMJS-OC
//
//  Created by zm on 2017/2/23.
//  Copyright © 2017年 zm. All rights reserved.
//

#import "WebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol  ZMWebJavaScriptMethods<JSExport>

- (void)sendMessageWithNoParam;
- (void)sendMessageWithOneParam:(id)message;

JSExportAs(sendMessageWithMoreParam,// sendMessageWithMoreParam作为JS调用的方法名
           - (void)sendMessageWithMoreParam:(id)message toSomeOne:(id)someOne
           );

@end

@interface WebViewController ()<UIWebViewDelegate,ZMWebJavaScriptMethods>{
    UIWebView *_webView;
    JSContext *_jsContext; //获取当前js页面上下文
}

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"web" withExtension:@"html"];
    [_webView loadRequest:[[NSURLRequest alloc] initWithURL:url]];
    
    [self.view addSubview:_webView];
    
    self.title = @"UIWebView";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    _jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    _jsContext[@"jsIdentify"] = self; //设定和js通信标识
    _jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception){
        context.exception = exception;
        NSLog(@"异常信息：%@", exception);
    };
}

#pragma mark - ZMWebJavaScriptMethods
- (void)sendMessageWithNoParam{
    [self callJSMothed:@"sendMessageToJSNoParam" params:nil];
}

- (void)sendMessageWithOneParam:(id)message{
    [self callJSMothed:@"sendMessageToJSWithOneParam" params:@[message]];
}

- (void)sendMessageWithMoreParam:(id)message toSomeOne:(id)someOne{
    [self callJSMothed:@"sendMessageToJSWithMoreParam" params:@[message,someOne]];
}

- (void)callJSMothed:(NSString *)mothed params:(NSArray *)params{
    JSValue *callJs = _jsContext[mothed];
    [callJs callWithArguments:params];
}





@end
