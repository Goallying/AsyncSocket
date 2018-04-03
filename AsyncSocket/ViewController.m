//
//  ViewController.m
//  AsyncSocket
//
//  Created by 朱来飞 on 2018/4/2.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "ViewController.h"
#import "TCPSocket.h"
#import "CToast.h"
#define IPAddr  @"127.0.0.1"
#define Port    1234

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    _serverHost = @"www.baidu.com";
//    _serverPort = 80;
    [[TCPSocket shared] connectToHost:IPAddr onPort:Port timeout:-1 completion:^(NSError *error) {
        if (!error) {
            [CToast showWithText:@"连接成功" duration:3];
        }else{
            [CToast showWithText:error.domain];
        }
    }];
}




@end
