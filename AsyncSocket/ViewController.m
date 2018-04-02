//
//  ViewController.m
//  AsyncSocket
//
//  Created by 朱来飞 on 2018/4/2.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "ViewController.h"
#import "TCPSocket.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    _serverHost = @"www.baidu.com";
//    _serverPort = 80;
    [[TCPSocket shared] connectToHost:@"115.239.210.26" onPort:80 timeout:-1 completion:^(NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
