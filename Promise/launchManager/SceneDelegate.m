//
//  SceneDelegate.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import "SceneDelegate.h"
#import "PROLoginViewController.h"
#import "PROBookUserInfoViewController.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions  API_AVAILABLE(ios(13.0)){
    if (@available(iOS 13.0, *)) {
        UIWindowScene *windowScene = (UIWindowScene *)scene;
//        self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
//        self.window.backgroundColor = [UIColor whiteColor];
//        self.window.rootViewController = [PROBookUserInfoViewController new];
//        [self.window makeKeyAndVisible];
//
        APCAlertViewController *vc = [APCAlertViewController new];
        vc.
        alertTitle(@"无相册访问权限").
        message(@"无相册访问权限，请在系统设置中修改权限").
        firstButtonTitle(@"退出").
        secondButtonTitle(@"设置").secondButtonHandler(^(id  _Nullable sender) {
            NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:settingsURL]) {
                [[UIApplication sharedApplication] openURL:settingsURL options:@{} completionHandler:nil];
            }
        }).show();
        self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
        self.window.rootViewController = vc;
        [self.window makeKeyAndVisible];
    } else {
        // Fallback on earlier versions
    }
   
    
}


- (void)sceneDidDisconnect:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
