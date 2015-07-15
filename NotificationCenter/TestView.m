//
//  TestView.m
//  NotificationCenter
//
//  Created by YouXianMing on 15/7/15.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "TestView.h"

@interface TestView ()

@property (nonatomic, strong) NotificationCenterObject *centerObject;
@property (nonatomic, strong) NotificationCenterObject *otherObject;

@end

@implementation TestView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
    
        self.centerObject = REGISTER_MSG_CENTER_WITH(FLAG_TEST_VIEW, self, @selector(notificationCenterObjectEvent:));
        self.otherObject  = REGISTER_MSG_CENTER_WITH(FLAG_OTHER_,    self, @selector(notificationCenterObjectEvent:));
    }
    
    return self;
}

- (void)notificationCenterObjectEvent:(id)sender {

    PostObject *postObj = ACCESS_POST_OBJECT(sender);
    
    NSLog(@"%@", postObj.flag);
    NSLog(@"%@", postObj.data);
    
    if ([postObj.flag isEqualToString:@"Y.X.M."]) {
        [self removeFromSuperview];
    }
}

@end
