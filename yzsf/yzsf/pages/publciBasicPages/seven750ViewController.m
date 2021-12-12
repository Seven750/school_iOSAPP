//
//  seven750ViewController.m
//  yzsf
//
//  Created by 卿伟明 on 2021/11/30.
//

#import "seven750ViewController.h"
#import "util.h"
@interface seven750ViewController ()

@end

@implementation seven750ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navigationBarAppearanceSet];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)navigationBarAppearanceSet{
    NSDictionary *titleTextAttributes = @{NSFontAttributeName:[UIFont fontWithName:@"PingFang SC" size:18], NSForegroundColorAttributeName:sRGB(66, 66, 66)};
    if (@available(iOS 13.0, *)) {
        //标题的设置在ios13之后有新的方法，之前的不适用了，要注意！！！
     UINavigationBarAppearance *appearance = [UINavigationBarAppearance new];
     appearance.backgroundColor = [UIColor whiteColor];
     appearance.titleTextAttributes = titleTextAttributes;
        self.navigationItem.standardAppearance = appearance;
        self.navigationItem.scrollEdgeAppearance = appearance;
    } else {
     // Fallback on earlier versions
        self.navigationController.navigationBar.barTintColor = sRGB(240, 240, 240);
        [self.navigationController.navigationBar setTitleTextAttributes:titleTextAttributes];
    }
}
@end
