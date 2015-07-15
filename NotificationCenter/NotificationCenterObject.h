//
//  NotificationCenterObject.h
//  NotificationCenter
//
//  Created by YouXianMing on 15/7/15.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PostObject : NSObject


@property (nonatomic, strong) NSString *flag;
@property (nonatomic, weak)   id        data;


/**
 *  便利构造器初始化对象
 *
 *  @param flag 识别标签
 *  @param data 数据
 *
 *  @return 实例对象
 */
+ (instancetype)postObjectWithFlag:(NSString *)flag data:(id)data;


/**
 *  处理通知中心事件
 *
 *  @param sender 通知中心的通知对象
 *
 *  @return 实例对象
 */
+ (instancetype)accessNotificationCenterObject:(id)sender;


@end


///////////////////////////////////////////////////////////////////////////////////////////


@interface NotificationCenterObject : NSObject


/**
 *  === 必须先使用此方法进行初始化 ===
 *
 *  初始化通知中心
 *
 *  @param observer 观察对象
 *  @param name     注册标签
 *  @param selector 执行用selector
 *
 *  @return 实例对象
 */
+ (instancetype)withObserver:(id)observer
                registerName:(NSString *)name
                    selector:(SEL)selector;


/**
 *  给指定注册标签发信息
 *
 *  @param name     注册标签
 *  @param postData 发送的对象
 */
+ (void)postToRegisterName:(NSString *)name data:(PostObject *)postData;


@property (nonatomic, readonly, strong) NSString *name;
@property (nonatomic, readonly, weak)   id        observer;


/**
 *  移除
 */
- (void)remove;


/**
 *  重新添加上
 */
- (void)reAdd;


@end


///////////////////////////////////////////////////////////////////////////////////////////

/**
 *  创建通知对象
 *
 *  @param flag 标签
 *  @param data 传递的数据
 *
 *  @return 通知对象
 */
static inline PostObject * POST_OBJECT(NSString *flag, id data) {
    
    return [PostObject postObjectWithFlag:flag data:data];
}

/**
 *  处理通知的对象
 *
 *  @param sender 接收的通知对象
 *
 *  @return 通知对象
 */
static inline PostObject * ACCESS_POST_OBJECT(id sender) {
    
    return [PostObject accessNotificationCenterObject:sender];
}

/**
 *  发送通知消息
 *
 *  @param name       指定的标签
 *  @param postObject 通知的对象
 *
 */
static inline void POST_MSG_TO(NSString *name, PostObject *postObject) {

    [NotificationCenterObject postToRegisterName:name data:postObject];
}

/**
 *  注册通知中心
 *
 *  @param name     指定的标签
 *  @param observer 被注册的对象
 *  @param selector 执行的句柄
 *
 *  @return 实例对象
 */
static inline NotificationCenterObject * REGISTER_MSG_CENTER_WITH(NSString *name, id observer, SEL selector) {
    
    return [NotificationCenterObject withObserver:observer registerName:name selector:selector];
}
