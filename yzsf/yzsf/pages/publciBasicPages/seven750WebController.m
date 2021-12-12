//
//  seven750WebController.m
//  yzsf
//
//  Created by 卿伟明 on 2021/12/7.
//

#import "seven750WebController.h"
#import "util.h"

@interface seven750WebController ()

@property (strong,nonatomic)  WKWebView *webView;
@end

@implementation seven750WebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self webViewInit];
}

-(NSString *)getWebUrl
{
    //一定要加协议http才可以
    return @"https://www.baidu.com";
}

-(void)webViewInit
{
    //初始化
   self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) configuration:[self webViewConfigurationInit]];
    [self.view addSubview:self.webView];
    // UI代理
    self.webView.UIDelegate = self;
    // 导航代理
    self.webView.navigationDelegate = self;
    // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
    self.webView.allowsBackForwardNavigationGestures = NO;
    //可返回的页面列表, 存储已打开过的网页
//   WKBackForwardList * backForwardList = [self.webView backForwardList];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self getWebUrl]]];

    [self.webView loadRequest:request];
    //页面后退
//    [self.webView goBack];
    //页面前进
//     [self.webView goForward];
    //刷新当前页面
//    [self.webView reload];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"JStoOC.html" ofType:nil];
//    NSString *htmlString = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  //加载本地html文件
//    [self.webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
}

- (WKWebViewConfiguration *)webViewConfigurationInit
{
    //创建网页配置对象
   WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
   
   // 创建设置对象
   WKPreferences *preference = [[WKPreferences alloc]init];
   //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
   preference.minimumFontSize = 0;
   //设置是否支持javaScript 默认是支持的
//   preference.javaScriptEnabled = YES;
   // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
   preference.javaScriptCanOpenWindowsAutomatically = YES;
   config.preferences = preference;
   
   // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
   config.allowsInlineMediaPlayback = YES;
   //设置视频是否需要用户手动播放  设置为NO则会允许自动播放
    config.mediaTypesRequiringUserActionForPlayback = YES;
   //设置是否允许画中画技术 在特定设备上有效
   config.allowsPictureInPictureMediaPlayback = YES;
   //设置请求的User-Agent信息中应用程序名称 iOS9后可用
   config.applicationNameForUserAgent = @"ChinaDailyForiPad";
    //自定义的WKScriptMessageHandler 是为了解决内存不释放的问题
//   WeakWebViewScriptMessageDelegate *weakScriptMessageDelegate = [[WeakWebViewScriptMessageDelegate alloc] initWithDelegate:self];
   //这个类主要用来做native与JavaScript的交互管理
//   WKUserContentController * wkUController = [[WKUserContentController alloc] init];
   //注册一个name为jsToOcNoPrams的js方法
//   [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"jsToOcNoPrams"];
//   [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"jsToOcWithPrams"];
//  config.userContentController = wkUController;
    return config;
           
}


@end
