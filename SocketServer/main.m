//
//  main.m
//  SocketServer
//
//  Created by 朱来飞 on 2018/4/3.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCPSocketServer.h"

//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        // insert code here...
//        NSLog(@"Hello, World!");
//
//        //    // 1. socket最早集成在unix里面，系统向外提供了socket抽象编程接口，在系统中创建一个socket。如果创建成功返回一个正值创建一个socket句柄可以看做一个文件。
//    int serverSocketFD = socket(AF_INET, SOCK_STREAM, 0);
//    if (serverSocketFD < 0) { // 创建socket文件句柄失败
//        NSLog(@"%d", serverSocketFD);
//        perror("无法创建套接字!!!\n");
//        exit(1);
//    }
//
//    //2. 为socket创建一个通信地址接口包含了几个主要元素 1.协议， 2. 端口 3. IP地址。
//    struct sockaddr_in serverAddr;
//    serverAddr.sin_family = AF_INET;
//    serverAddr.sin_port = htons(SERVER_PORT);
//    serverAddr.sin_addr.s_addr = htonl(INADDR_ANY); //默认IP地址为回环地址！127.0.0.1 localhost
//
//    // 3. 把socket address接口绑定到系统的socket句柄上。
//    int ret = bind(serverSocketFD, (struct sockaddr *)&serverAddr,
//                   sizeof serverAddr);
//    if (ret < 0) {
//        perror("无法将套接字绑定到指定的地址!!!\n");
//        close(serverSocketFD);
//        exit(1);
//    }
//
//    //4. 让系统监听这个socket文件句柄，并且设定最大的队列长度
//    ret = listen(serverSocketFD, MAX_Q_LEN);
//    if (ret < 0) {
//        perror("无法开启监听!!!\n");
//        close(serverSocketFD);
//        exit(1);
//    }
//
//    //5.设定一个死循环，让客户端可以不断输入内容给服务端。
//    while(true) {
//        struct sockaddr_in clientAddr; //创建一个客户端的端口地址
//        socklen_t clientAddrLen = sizeof clientAddr; // 设定客户端的地址长度
//        int clientSocketFD = accept(serverSocketFD, (struct sockaddr *)&clientAddr, &clientAddrLen);
//        if (clientSocketFD < 0) {
//            perror("接受客户端连接时发生错误!!!\n");
//        }
//        else {
//            //将处理客户端内容放在子线程中异步执行。
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                handle_client_connection(clientSocketFD);
//            });
//        }
//    }

//    }
//    return 0;
//}
int main(){
    
    [[TCPSocketServer shared] startServer];
    [[NSRunLoop currentRunLoop] run];
    
}
