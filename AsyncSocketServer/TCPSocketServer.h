//
//  TCPSocketServer.h
//  001--SocketDemo
//
//  Created by 朱来飞 on 2018/4/3.
//  Copyright © 2018年 Adolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCPSocketServer : NSObject

+ (instancetype)shared ;

- (void)startServer ;
- (void)sendText:(NSString *)txt ;

@property (nonatomic ,copy)void (^receiveMessage)(NSString * msg) ;
@end
