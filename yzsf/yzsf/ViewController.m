//
//  ViewController.m
//  yzsf
//
//  Created by 卿伟明 on 2021/11/24.
//

#import "ViewController.h"
#import "homepageViewController.h"
@interface ViewController ()<UITabBarDelegate>
@property (strong, nonatomic) IBOutlet UIView *MainView;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"213123");
    
    homepageViewController *childView = [[homepageViewController alloc] initWithNibName:@"homepageViewController" bundle:nil];
    [self addChildViewController:childView];
    CGRect rect = self.MainView.frame;
    childView.view.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    [self.MainView addSubview: childView.view];
    
    
    
    self.tabBar.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark -UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
}

@end
