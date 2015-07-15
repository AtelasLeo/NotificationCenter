//
//  NotificationCenterObject.m
//  NotificationCenter
//
//  Created by YouXianMing on 15/7/15.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "NotificationCenterObject.h"

@implementation PostObject

+ (instancetype)postObjectWithFlag:(NSString *)flag data:(id)data {

    PostObject *postObject = [PostObject new];
    postObject.flag        = flag;
    postObject.data        = data;
    
    return postObject;
}

+ (instancetype)accessNotificationCenterObject:(id)sender {

    PostObject *postData = nil;
    
    if ([sender isKindOfClass:[NSNotification class]]) {
    
        NSNotification *notiData = sender;
        
        if ([notiData.object isKindOfClass:[PostObject class]]) {
            
            postData = notiData.object;
        }
    }
    
    return postData;
}

@end

@interface NotificationCenterObject ()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, weak)   id        observer;
@property (nonatomic)         SEL       observerSelector;

@property (nonatomic)         BOOL      haveAddObserver;

@end

@implementation NotificationCenterObject

+ (void)postToRegisterName:(NSString *)name data:(PostObject *)postData {

    [[NSNotificationCenter defaultCenter] postNotificationName:name object:postData];
}

+ (instancetype)withObserver:(id)observer registerName:(NSString *)name selector:(SEL)selector {

    NotificationCenterObject *notificationCenterObject = [NotificationCenterObject new];
    notificationCenterObject.name                      = name;
    notificationCenterObject.observer                  = observer;
    notificationCenterObject.observerSelector          = selector;
    
    notificationCenterObject.haveAddObserver           = YES;
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:name object:nil];
    
    return notificationCenterObject;
}

- (void)remove {

    if (self.haveAddObserver == YES && _name && _observer) {
        self.haveAddObserver = NO;
        [[NSNotificationCenter defaultCenter] removeObserver:_observer name:_name object:nil];
    }
}

- (void)reAdd {

    if (self.haveAddObserver == NO && _name && _observer) {
        self.haveAddObserver = YES;
        [[NSNotificationCenter defaultCenter] addObserver:_observer selector:_observerSelector name:_name object:nil];
    }
}

- (void)dealloc {
    
    if (self.haveAddObserver == YES) {
        
        NSLog(@"已经释放");
        [[NSNotificationCenter defaultCenter] removeObserver:_observer name:_name object:nil];
    }
}

@end
