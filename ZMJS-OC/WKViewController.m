//
//  WKViewController.m
//  ZMJS-OC
//
//  Created by zm on 2017/2/23.
//  Copyright © 2017年 zm. All rights reserved.
//

#import "WKViewController.h"
#import <WebKit/WebKit.h>
#import "UIAlertController+WebAlert.h"

@interface WKViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>{
    WKWebView *_wkWebView;
}

@end

@implementation WKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 交互对象设置
    [config.userContentController addScriptMessageHandler:self name:@"handlerName"];
    _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    _wkWebView.UIDelegate = self;
    _wkWebView.navigationDelegate = self;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"web" withExtension:@"html"];
    [_wkWebView loadRequest:[[NSURLRequest alloc] initWithURL:url]];

    [self.view addSubview:_wkWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:message.body];
    NSString *js = [NSString stringWithFormat:@"%@(\'%@\')", dic[@"functionName"],dic[@"param"]];
    [_wkWebView evaluateJavaScript:js completionHandler:nil];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
}

#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    [UIAlertController showAlertWithTitle:@"WK" message:message cancelButtonTitle:@"确定" cancelButtonHandler:completionHandler];
}

@end
