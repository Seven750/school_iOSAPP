//
//  websiteWebController.m
//  yzsf
//
//  Created by 卿伟明 on 2021/12/7.
//

#import "websiteWebController.h"
#import "util.h"

@interface websiteWebController ()

@end

@implementation websiteWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"官网";
}

- (NSString *)getWebUrl
{
    return @"http://www.zzu.edu.cn";
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
//    [util showLoading];
    NSLog(@"开始加载");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
//    [util dismissLoading];
    NSLog(@"加载完成");
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [util dismissLoading];
    NSLog(@"加载失败");
}
@end
