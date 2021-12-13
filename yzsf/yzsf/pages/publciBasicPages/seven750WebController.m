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

//添加进度条
@property(nonatomic,strong) UIProgressView *  progressView;
@end

@implementation seven750WebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self webViewInit];
    [self processViewInit];
    [self makefourbtn];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
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
    self.backForwardList = [self.webView backForwardList];

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
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)processViewInit
{
    // 创建进度条
    if (!self.progressView) {
        LLog(@"%f",navigationBarHeight);
        self.progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        self.progressView.frame = CGRectMake(0, navigationBarHeight, self.view.bounds.size.width, 0.3);
        // 设置进度条的色彩
        CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 0.5f);
        self.progressView.transform = transform;
        [self.progressView setTrackTintColor:[UIColor clearColor]];
        self.progressView.progressTintColor = sRGBHex(0x009Dff);
        [self.view addSubview:self.progressView];
    }
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

-(void)makefourbtn{
    //在底部生成几个button用来控制web页面的操作
    NSArray * WkWeb_Title = @[@"后退",@"重载",@"前进",@"首页"];
    for (int i= 0 ; i<4; i ++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+i*((self.view.bounds.size.width-50)/4+10), self.view.bounds.size.height- safeAreaInsetsBottom - 45, (self.view.bounds.size.width-50)/4, 40);
        [button setTitle:WkWeb_Title[i] forState:UIControlStateNormal];
        button.layer.borderWidth = 0.5;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(ClicK:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}
-(void)ClicK:(UIButton *)Btn{
    switch (Btn.tag) {
        case 0:{
//            //这个是带缓存的验证
//            [self.webView reloadFromOrigin];
            // 是不带缓存的验证，刷新当前页面
            if (self.webView.canGoBack) {
                [self.webView goBack];
            }
        }
            break;
        case 1:{
           // 后退
            // 首先判断网页是否可以后退
            [self.webView reload];
        }
            break;
        case 2:{
            // 前进
            // 判断是否可以前进
            if (self.webView.canGoForward) {
                [self.webView goForward];
            }
        }
            break;
        case 3:{
            //进行跳转,我们设置跳转的返回到第一个界面
            NSLog(@"%@",self.webView.backForwardList.backList);
            if (self.webView.backForwardList.backList.count >2) {
                [self.webView goToBackForwardListItem:self.webView.backForwardList.backList[0]];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
//    [util showLoading];
    self.progressView.hidden = NO;
    NSLog(@"开始加载");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
//    [util dismissLoading];
    NSLog(@"加载完成");
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
//    [util dismissLoading];
    NSLog(@"加载失败");
}

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    // 接收到服务器跳转请求即服务重定向时之后调用
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
        if (![frameInfo isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
        return nil;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    // 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
    if (!navigationAction.targetFrame.isMainFrame) {
          [webView evaluateJavaScript:@"var a = document.getElementsByTagName('a');for(var i=0;i<a.length;i++){a[i].setAttribute('target','');}" completionHandler:nil];
      }
      decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (object == self.webView) {
            LLog(@"进度信息%f",self.webView.estimatedProgress);
            if (self.webView.estimatedProgress == 1) {
                self.progressView.hidden = YES;
            }else{
                self.progressView.progress = self.webView.estimatedProgress;
            }
        }
    }
}

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
@end
