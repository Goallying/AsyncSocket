//
//  TCPSocket.h
//  AsyncSocket
//
//  Created by 朱来飞 on 2018/4/2.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCPSocket : NSObject


+ (instancetype)shared ;

- (void)connectToHost:(NSString *)host
               onPort:(uint16_t)port
              timeout:(NSTimeInterval)timeout
           completion:(void(^)(NSError * error))completion ;

- (void)sendText:(NSString *)txt ;

@property (nonatomic ,copy)void (^receiveMessage)(NSString * msg) ;

@end
