//
//  ForgetMmOneViewController.m
//  enuo4
//
//  Created by apple on 16/5/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ForgetMmOneViewController.h"
#import <AFNetworking.h>



@interface ForgetMmOneViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *oldTextField;
@property (weak, nonatomic) IBOutlet UITextField *changeTextField;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (nonatomic,strong)UIAlertView *alertView1;
@property (nonatomic,strong)UIAlertController *alertView2;

@property (nonatomic,copy)NSString *strTwo;
@end







@implementation ForgetMmOneViewController



//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        
//    }return self;
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    //设置密码框
    [self.oldTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    self.oldTextField.secureTextEntry = YES;
    [self.oldTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.oldTextField setReturnKeyType:UIReturnKeyDone];
    [self.oldTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    //关闭首字母大写
    [self.oldTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    [self.oldTextField setHighlighted:YES];
    self.oldTextField.delegate = self;
    
    
    
    
    
    //设置确认密码框
    [self.changeTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    self.changeTextField.secureTextEntry = YES;
    [self.changeTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.changeTextField setReturnKeyType:UIReturnKeyDone];
    [self.changeTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    //关闭首字母大写
    [self.changeTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    [self.changeTextField setHighlighted:YES];
    self.changeTextField.delegate = self;
    
}
- (IBAction)handleBtnWithSure:(UIButton *)sender {
    
    if (![self.oldTextField.text isEqualToString:self.changeTextField.text]) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"两次密码输入不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次密码输入不一致" preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }
    }else{
        

    
        [self.oldTextField resignFirstResponder];
        [self.changeTextField resignFirstResponder];
    
    NSString *str = @"http://www.enuo120.com/index.php/phone/json/setNewPass?phone=%@&password=%@";
    NSString *url = [NSString stringWithFormat:str,self.receiver, self.changeTextField.text];
    NSLog(@"str = %@",url);
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    }
}


- (void)handleWithData:(NSDictionary *)data{
    [self.oldTextField resignFirstResponder];
    [self.changeTextField resignFirstResponder];
    NSString *strOne = [data[@"data"]objectForKey:@"message" ];
    self.strTwo = [data[@"data"]objectForKey:@"errcode"];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        self.alertView1 = [[UIAlertView alloc]initWithTitle:@"提示" message:strOne delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        //self.alertView1.delegate =self;
        [self performSelector:@selector(popVC) withObject:nil afterDelay:0.5];
        
    }else{
        self.alertView2 = [UIAlertController alertControllerWithTitle:@"提示" message:strOne
                                                       preferredStyle:UIAlertControllerStyleAlert];
        [self.alertView2 addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // [self.navigationController popViewControllerAnimated:YES];
            if ([self.strTwo isEqualToString:@"0"]) {
               [self dismissViewControllerAnimated:YES completion:^{
                   
               }];
            }
        }]];
        [self performSelector:@selector(popVCcc) withObject:nil afterDelay:0.5];
        
    }

    
}
- (void)popVCcc{
    [self presentViewController:self.alertView2 animated:YES completion:^{
        
    }];
}
- (void)popVC{
    [self.alertView1 show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            if ([self.strTwo isEqualToString:@"0"]) {
              [self dismissViewControllerAnimated:YES completion:^{
                  
              }];
            }
            break;
            
        default:
            break;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.oldTextField resignFirstResponder];
    [self.changeTextField resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
