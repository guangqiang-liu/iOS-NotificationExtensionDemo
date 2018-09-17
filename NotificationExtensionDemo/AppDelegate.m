//
//  AppDelegate.m
//  NotificationExtensionDemo
//
//  Created by 刘光强 on 2018/9/17.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@property (nonatomic, strong) AVSpeechSynthesisVoice *synthesisVoice;
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {
     [self addOperation:userInfo[@"aps"][@"alert"][@"body"]];
}

#pragma mark -队列管理推送通知
- (void)addOperation:(NSString *)title {
    [[self mainQueue] addOperation:[self customOperation:title]];
}

- (NSOperationQueue *)mainQueue {
    return [NSOperationQueue mainQueue];
}

- (NSOperation *)customOperation:(NSString *)content {
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        AVSpeechUtterance *utterance = nil;
        @autoreleasepool {
            utterance = [AVSpeechUtterance speechUtteranceWithString:content];
            utterance.rate = 0.5;
        }
        utterance.voice = self.synthesisVoice;
        [self.synthesizer speakUtterance:utterance];
    }];
    return operation;
}

- (AVSpeechSynthesisVoice *)synthesisVoice {
    if (!_synthesisVoice) {
        _synthesisVoice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    }
    return _synthesisVoice;
}

- (AVSpeechSynthesizer *)synthesizer {
    if (!_synthesizer) {
        _synthesizer = [[AVSpeechSynthesizer alloc] init];
    }
    return _synthesizer;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
