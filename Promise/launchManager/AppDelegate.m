//
//  AppDelegate.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import "AppDelegate.h"
#import "PRORegisterNumberViewController.h"
#import "PROLoginViewController.h"
#import "PROBookUserInfoViewController.h"

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
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [PROBookUserInfoViewController new];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}



@end
