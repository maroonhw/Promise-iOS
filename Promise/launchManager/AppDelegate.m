//
//  AppDelegate.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import "AppDelegate.h"
#import "PRORegisterNumberViewController.h"
#import "PROLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AVOSCloud setAllLogsEnabled:YES];
    [AVOSCloud setApplicationId:@"lsd35U0ivr7L0GdUSs9ePfA2-gzGzoHsz"
                      clientKey:@"ICbMovlvjMiyqWYPXIMnwk5q"
                serverURLString:@"https://lsd35u0i.lc-cn-n1-shared.com"];
    [self cerateAppWindow];
    return YES;
}


- (void)cerateAppWindow {
    if (@available(iOS 13.0, *)) {
        
    } else {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.rootViewController = [PROLoginViewController new];
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
    }
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
