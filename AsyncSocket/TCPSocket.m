//
//  TCPSocket.m
//  AsyncSocket
//
//  Created by 朱来飞 on 2018/4/2.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "TCPSocket.h"
#import "GCDAsyncSocket.h"

@interface TCPSocket()<GCDAsyncSocketDelegate>

@property (nonatomic ,strong)GCDAsyncSocket * tcpSocket ;
@property (nonatomic ,strong)NSTimer * heartBeatTimer ;
@property (nonatomic ,copy) void(^cmp)(NSError * error);


@end

static TCPSocket * _tcpSocketManager = nil ;

@implementation TCPSocket

#pragma mark -- Life Circle
+ (instancetype)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tcpSocketManager = [[super allocWithZone:NULL]init];
    });
    return _tcpSocketManager ;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self shared];
}

- (instancetype)init{
    if (self = [super init]) {
        _tcpSocket = [[GCDAsyncSocket alloc]initWithSocketQueue:dispatch_get_main_queue()];
    }
    return self ;
}
#pragma mark -- Connect
- (void)connectToHost:(NSString *)host
               onPort:(uint16_t)port
              timeout:(NSTimeInterval)timeout
           completion:(void(^)(NSError * error))completion{
    
    _cmp = completion  ;
    if ([_tcpSocket isConnected]) {
        [self disconnect];
    }
    NSError * error = nil ;
    BOOL cnt = [_tcpSocket connectToHost:host onPort:port withTimeout:timeout error:&error];
    if (cnt) {
        NSLog(@"链接中。。。");
    }else{
        if (_cmp) {
            _cmp(error);
        }
        NSLog(@"未创建链接");
    }
}
- (void)disconnect {
    
    [_tcpSocket disconnect];
    _tcpSocket.delegate = nil ;
    _tcpSocket = nil ;
    
    if (_heartBeatTimer) {
        [_heartBeatTimer invalidate] ;
        _heartBeatTimer = nil ;
    }
}
- (void)sendText:(NSString *)txt{
    
    NSData * data = [txt dataUsingEncoding:NSUTF8StringEncoding];
    [_tcpSocket writeData:data withTimeout:-1 tag:0];
    
}
#pragma mark -- GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"链接成功");
    if (_cmp) {
        _cmp(nil);
    }
    
    [self installHeartBeat];
}
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    
    if (_cmp) {
        _cmp(err);
    }
    [self disconnect];
    
}


#pragma mark -- Connect Heart Beat
- (void)installHeartBeat {
    
    _heartBeatTimer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(heartBeat:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_heartBeatTimer forMode:NSRunLoopCommonModes];
    
}
- (void)heartBeat:(NSTimer *)timer {
    NSString * beatString = [NSString stringWithFormat:@"%@",@"beatString"];
    NSData * beatData = [beatString dataUsingEncoding:NSUTF8StringEncoding];
    [_tcpSocket writeData:beatData withTimeout:-1 tag:0];
}
@end
