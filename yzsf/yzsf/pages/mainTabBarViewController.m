//
//  mainTabBarViewController.m
//  yzsf
//
//  Created by 卿伟明 on 2021/11/27.
//

#import "mainTabBarViewController.h"
#import "homepageController/homepageViewController.h"
#import "personSetController/personSetTableViewController.h"
@interface mainTabBarViewController ()

@end

@implementation mainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    homepageViewController *v1 = [[homepageViewController alloc] initWithNibName:@"homepageViewController" bundle:nil];
    v1.tabBarItem.image = [UIImage imageNamed:@"homepage_unselected_icon"];
    v1.tabBarItem.title = @"主页";
    v1.view.backgroundColor = [UIColor whiteColor];
    
    personSetTableViewController *v2 = [[personSetTableViewController alloc] initWithNibName:@"personSetTableViewController" bundle:nil];
    v2.tabBarItem.image = [UIImage imageNamed:@"personTab_unSelected_icon"];
    v2.tabBarItem.title = @"个人";
    v2.view.backgroundColor = [UIColor whiteColor];
    
    UINavigationController *n1 = [[UINavigationController alloc] initWithRootViewController:v1];
    n1.navigationBar.barTintColor = [UIColor whiteColor];
    UINavigationController *n2 = [[UINavigationController alloc] initWithRootViewController:v2];
    n2.navigationBar.barTintColor = [UIColor whiteColor];
//    n1.navigationBarHidden = YES;
//    n2.navigationBarHidden = YES;
    
//    CGSize size = self.tabBar.frame.size;
//    [self addChildViewController:n1];
//    [self addChildViewController:n2];
    NSArray *array = @[n1,n2];
    self.viewControllers = array;
    
    self.tabBar.tintColor = [UIColor colorWithRed:(10/ 255.0) green:(120/ 255.0) blue:(255 / 255.0) alpha:1.0];
    self.tabBar.barTintColor = [UIColor whiteColor];
}


@end
