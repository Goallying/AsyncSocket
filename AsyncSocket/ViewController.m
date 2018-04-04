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

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *serverTF;
@property (weak, nonatomic) IBOutlet UITextField *clientTF;
@property (weak, nonatomic) IBOutlet UITextField *IPTF;
@property (weak, nonatomic) IBOutlet UITextField *PortTF;

@property (weak, nonatomic) IBOutlet UIButton *connectBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    

    
    [[TCPSocket shared] setReceiveMessage:^(NSString *msg) {
        _serverTF.text = msg ;
    }];
    
    [self.connectBtn addTarget:self action:@selector(connect) forControlEvents:UIControlEventTouchUpInside];
    [self.sendBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];

}
- (void)connect {
    
    [[TCPSocket shared] connectToHost:_IPTF.text onPort:[_PortTF.text integerValue] timeout:-1 completion:^(NSError *error) {
        if (!error) {
            [CToast showWithText:@"连接成功" duration:3];
        }else{
            [CToast showWithText:error.domain];
        }
    }];
}

- (void)send {
    [[TCPSocket shared] sendText:_clientTF.text];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
