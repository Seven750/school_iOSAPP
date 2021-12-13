//
//  seven750WebController.h
//  yzsf
//
//  Created by 卿伟明 on 2021/12/7.
//

#import "seven750ViewController.h"
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface seven750WebController : seven750ViewController<WKUIDelegate,WKNavigationDelegate>

@property (strong,nonatomic) WKBackForwardList * backForwardList;

-(NSString *)getWebUrl;

@end

NS_ASSUME_NONNULL_END
