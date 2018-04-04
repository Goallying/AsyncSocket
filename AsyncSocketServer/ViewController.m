//
//  ViewController.m
//  AsyncSocketServer
//
//  Created by 朱来飞 on 2018/4/4.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "ViewController.h"
#import "TCPSocketServer.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *ClientTF;
@property (weak, nonatomic) IBOutlet UITextField *ServerTF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[TCPSocketServer shared] startServer];
    
    [[TCPSocketServer shared] setReceiveMessage:^(NSString *msg) {
        _ClientTF.text = msg;
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
}
- (IBAction)sendToClient:(UIButton *)sender {
    [[TCPSocketServer shared] sendText:_ServerTF.text];
}

@end
