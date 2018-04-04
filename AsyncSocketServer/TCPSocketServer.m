//
//  TCPSocketServer.m
//  001--SocketDemo
//
//  Created by 朱来飞 on 2018/4/3.
//  Copyright © 2018年 Adolf. All rights reserved.
//

#import "TCPSocketServer.h"
#import "GCDAsyncSocket.h"

#define HeartBeatTag  @"beatString"

static TCPSocketServer * _tcpSocketServer = nil ;

@interface TCPSocketServer()<GCDAsyncSocketDelegate>

@property (nonatomic ,strong)GCDAsyncSocket * serverSocket ;
@property (nonatomic ,strong)GCDAsyncSocket * clientSocket ;

@end

@implementation TCPSocketServer

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tcpSocketServer = [[super allocWithZone:NULL]init];
    });
    return _tcpSocketServer ;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self shared];
}
- (instancetype)init{
    if (self = [super init]) {
        _serverSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        
    }
    return self ;
}
- (void)startServerOnport:(NSInteger)port {
    NSError * error = nil ;
    [_serverSocket acceptOnPort:port error:&error];
    
    if (!error) {
        NSLog(@"服务开启成功");
    }else{
        NSLog(@"服务开启失败");
    }
}
- (void)sendText:(NSString *)txt{
    NSData * data = [txt dataUsingEncoding:NSUTF8StringEncoding];
    [_clientSocket writeData:data withTimeout:-1 tag:0];
    
}
#pragma mark -- GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket{
    
    _clientSocket = newSocket ;
    
    [_clientSocket  readDataWithTimeout:-1 tag:0];
    
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    //接收到数据
    
    NSString *receiverStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"length:%ld",receiverStr.length);
    // 把回车和换行字符去掉，接收到的字符串有时候包括这2个，导致判断quit指令的时候判断不相等
    receiverStr = [receiverStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    receiverStr = [receiverStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    [_clientSocket readDataWithTimeout:-1 tag:0];

    if (![receiverStr isEqualToString:HeartBeatTag]) {
        if (self.receiveMessage) {
            self.receiveMessage(receiverStr);
        }
    }
    
}
@end
