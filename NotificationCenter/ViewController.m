//
//  ViewController.m
//  NotificationCenter
//
//  Created by YouXianMing on 15/7/15.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "ViewController.h"
#import "NotificationCenterObject.h"
#import "TestView.h"

#define MSG_ViewController   @"MSG_ViewController"

@interface ViewController ()

@property (nonatomic, strong) NotificationCenterObject *notiObj;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    TestView *testView       = [[TestView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];
    
    
    // 注册通知中心
    self.notiObj = REGISTER_MSG_CENTER_WITH(MSG_ViewController, self, @selector(notiEvent:));
    
    // 发送通知
    POST_MSG_TO(MSG_ViewController, POST_OBJECT(@"Y", @[@"1", @"2"]));
    POST_MSG_TO(MSG_ViewController, POST_OBJECT(@"X", @[@"C", @"D"]));
    
    // 延时两秒执行
    [self performSelector:@selector(event) withObject:nil afterDelay:2.f];
}

- (void)event {
    
    POST_MSG_TO(FLAG_TEST_VIEW, POST_OBJECT(@"YouXianMing", @[@"A", @"B"]));
    POST_MSG_TO(FLAG_OTHER_,    POST_OBJECT(@"Y.X.M.",      @{@"A" : @"B"}));
}

- (void)notiEvent:(id)sender {

    // 处理通知对象
    PostObject *obj = ACCESS_POST_OBJECT(sender);
    
    if ([obj.flag isEqualToString:@"Y"]) {
        
        NSLog(@"1");
        
    } else if ([obj.flag isEqualToString:@"X"]) {
    
        NSLog(@"2");
    }
}

@end
