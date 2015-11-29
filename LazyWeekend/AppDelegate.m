//
//  AppDelegate.m
//  LazyWeekend
//
//  Created by lunarboat on 15/11/8.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import "AppDelegate.h"
#import <WeiboSDK.h>
#import <UMSocial.h>
#import <UMSocialSinaSSOHandler.h>
#define LoginViewControllerID @"LunchViewController"
#define MainViewControllerID @"MainViewController"

#define kWeiboAppkey @"2145734371"
#define kWeiboAppSecret @"600ed8eec6598ad965d20dc0d64484c7"

@interface AppDelegate ()<WeiboSDKDelegate>{
    BOOL _isLogin;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //注册微博信息
    [WeiboSDK registerApp:kWeiboAppkey];
    //友盟第三方SSO登录注册
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:kWeiboAppkey RedirectURL:kRedirectURL];
    //注册友盟
    [UMSocialData setAppKey:kUmengAppkey];
    
    //先拿到storyBoard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //判断是否登录，来对应不同的操作视图
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"accessToken"] != nil && ![[[NSUserDefaults standardUserDefaults]objectForKey:@"accessToken"] isEqualToString:@""] ) {
        _isLogin = YES;
    }
    NSString *loadViewControllerName = _isLogin? MainViewControllerID : LoginViewControllerID;
    id viewController = [storyboard instantiateViewControllerWithIdentifier:loadViewControllerName];
    self.window.rootViewController = viewController;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [WeiboSDK handleOpenURL:url delegate:self];
    //友盟第三方SSO登录
//    BOOL result = [UMSocialSnsService handleOpenURL:url];
//    return result;
}
#pragma mark - 微博sdk代理（官方回调方法）
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}
- (void)didReceiveWeiboResponse:(WBAuthorizeResponse *)response{
    if ([response isKindOfClass:[WBAuthorizeResponse class]]) {
        if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:response.accessToken forKey:@"accessToken"];
            [userDefaults setObject:response.userID forKey:@"userID"];
            [userDefaults synchronize];
        }
    }
}


@end
