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

@end
