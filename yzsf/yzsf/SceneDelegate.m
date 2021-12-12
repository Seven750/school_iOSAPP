//
//  SceneDelegate.m
//  yzsf
//
//  Created by 卿伟明 on 2021/11/24.
//
//在iOS 13（及以后版本）上，SceneDelegate将负责AppDelegate的某些功能。 最重要的是，window（窗口）的概念已被scene（场景）的概念所代替。 一个应用程序可以具有不止一个场景，而一个场景现在可以作为您应用程序的用户界面和内容的载体（背景）。
//
//尤其是一个具有多场景的App的概念很有趣，因为它使您可以在iOS和iPadOS上构建多窗口应用程序。 例如，文档编辑器App中的每个文本文档都可以有自己的场景。 用户还可以创建场景的副本，同时运行一个应用程序的多个实例（类似多开）。


#import "SceneDelegate.h"
#import "mainTabBarViewController.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    //初始化
    if (@available(iOS 13.0, *)) {
        UIWindowScene *windowScene = (UIWindowScene *)scene;
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
        [self.window setWindowScene:windowScene];
        [self.window setBackgroundColor:[UIColor whiteColor]];
        [self.window setRootViewController:[[mainTabBarViewController alloc] init]];

        [self.window makeKeyAndVisible];
    }
    
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    //即将被杀死
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    //已被激活
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
    //即将被挂起
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
    //即将回到前台
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
    //已经进入后台
}


@end
