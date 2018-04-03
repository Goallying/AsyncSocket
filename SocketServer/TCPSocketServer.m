//
//  TCPSocketServer.m
//  001--SocketDemo
//
//  Created by 朱来飞 on 2018/4/3.
//  Copyright © 2018年 Adolf. All rights reserved.
//

#import "TCPSocketServer.h"
#import "GCDAsyncSocket.h"

#define Port 1234
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
- (void)startServer {
    NSError * error = nil ;
    [_serverSocket acceptOnPort:Port error:&error];
    
    if (!error) {
        NSLog(@"服务开启成功");
    }else{
        NSLog(@"服务开启失败");
    }
}

#pragma mark -- GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket{
    
    _clientSocket = newSocket ;
    
    [_clientSocket  readDataWithTimeout:-1 tag:0];
    
}
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    [sock readDataWithTimeout:-1 tag:0];
}
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    //接收到数据
    
    NSString *receiverStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"length:%ld",receiverStr.length);
    // 把回车和换行字符去掉，接收到的字符串有时候包括这2个，导致判断quit指令的时候判断不相等
    receiverStr = [receiverStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    receiverStr = [receiverStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSLog(@"==== %@",receiverStr);
    
    [_clientSocket readDataWithTimeout:-1 tag:0];
//    //判断是登录指令还是发送聊天数据的指令。这些指令都是自定义的
//    //登录指令
//    if([receiverStr hasPrefix:@"iam:"]){
//        // 获取用户名
//        NSString *user = [receiverStr componentsSeparatedByString:@":"][1];
//        // 响应给客户端的数据
//        NSString *respStr = [user stringByAppendingString:@"has joined"];
//        [sock writeData:[respStr dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
//    }
//    //聊天指令
//    if ([receiverStr hasPrefix:@"msg:"]) {
//        //截取聊天消息
//        NSString *msg = [receiverStr componentsSeparatedByString:@":"][1];
//        [sock writeData:[msg dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
//    }
//    //quit指令
//    if ([receiverStr isEqualToString:@"quit"]) {
//        //断开连接
//        [sock disconnect];
//        //移除socket
//        [_serverSocket removeObject:sock];
//    }
}
@end
