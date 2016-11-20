//
//  ForgetMmViewController.m
//  enuo4
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ForgetMmViewController.h"
#import "ForgetMmOneViewController.h"
#import <AFNetworking.h>
@interface ForgetMmViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *llTextField;
@property (nonatomic,strong)UIAlertView *alertView1;
@property (weak, nonatomic) IBOutlet UITextField *checkCodeField;
@property (nonatomic,strong)UIAlertController *alertView2;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (nonatomic,copy)NSString *dataStr;

@property (nonatomic,strong)NSDictionary *optionDic;//配置项；
@property (nonatomic,copy)NSString *nPhoneField;


@end

@implementation ForgetMmViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"忘记密码";
     self.optionDic =@{@"0":@"C",@"1":@"An",@"2":@"H@",@"3":@"D",@"4":@"R",@"5":@"Vc",@"6":@"XZ",@"7":@"J",@"8":@"m",@"9":@"Q"};
    
    [self.llTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [self.llTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.llTextField setReturnKeyType:UIReturnKeyDone];
    [self.llTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    //关闭首字母大写
    [self.llTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    [self.llTextField setHighlighted:YES];
    self.llTextField.delegate = self;
    self.navigationController.navigationBar.translucent = NO;
    [self.checkCodeField setKeyboardType:UIKeyboardTypeNumberPad];
    [self.checkCodeField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.checkCodeField setReturnKeyType:UIReturnKeyDone];
    [self.checkCodeField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    //关闭首字母大写
    //[self.l setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    [self.checkCodeField setHighlighted:YES];
     self.checkCodeField.delegate = self;
    
    
    
}

- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//取消键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.llTextField resignFirstResponder];
    [self.checkCodeField resignFirstResponder];
}
//验证码
- (IBAction)handleSendCodeBtn:(UIButton *)sender {
   // NSLog(@"phoneText.text = %@",_phoneText.text);
    
    NSString * regex1 = @"[1][3578]\\d{9}";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES  %@", regex1];
    

    
    
    if ([pred1 evaluateWithObject: self.llTextField.text]){
        NSArray *keys = self.optionDic.allKeys;
        self.nPhoneField = self.llTextField.text;
        for (int i = 0; i < keys.count; i++) {
            //逐个的获取键
            NSString * key = [keys objectAtIndex:i];
            
            //通过键，找到相对应的值
            NSString * value = [self.optionDic valueForKey:key];
            //或者
            // NSString * value = [dict objectForKey:key];
            NSLog(@"key = %@，value = %@",key,value);
            self.nPhoneField = [self.nPhoneField stringByReplacingOccurrencesOfString:key withString:value];
            
        }
        NSLog(@"ssssssssssssssssssssssssssself.nphoneField = %@",self.nPhoneField);
        NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
        NSLog(@"uuid =%@",identifierForVendor);
        NSString *uuid = [NSString stringWithFormat:@"ios%@",identifierForVendor];
        NSString *str1= @"http://www.enuo120.com/index.php/phone/json/getcode";
        //NSString *str2 = [NSString stringWithFormat:@"phone=%@",self.llTextField.text];
        AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
            NSMutableDictionary *str3 = [NSMutableDictionary dictionaryWithObject:self.nPhoneField forKey:@"phone"];
       // str3 = [NSDictionary dictionaryWithObject:uuid forKey:@"uuid"];
        [str3 setValue:uuid forKey:@"uuid"];
        NSLog(@"str3 = %@",str3);
        [manger POST:str1 parameters:str3 progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"responseObject = %@",responseObject);
            [self handleCodeMImaWithData:responseObject];
          
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
        
        /*
        [manger GET:str2 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"responseObject = %@",responseObject);
            [self handleCodeMImaWithData:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull  error) {
            NSLog(@"error = %@",error);
        }];
        */
        
    }else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号格式错误" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"手机号格式错误" preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }
    }
}
- (void)handleCodeMImaWithData:(NSDictionary *)data{
    NSLog(@"data = %@",data);
    if ([data[@"data"] isKindOfClass:[NSNull class]]){
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"系统故障" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"系统故障" preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }
        
    }else{
    
    NSString *arr= data[@"data"];
    if (  [arr isEqualToString:@"0"]) {
        __block int timeout = 60; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    self.codeBtn.enabled = YES;
                    [self.codeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                    self.codeBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
                });
            }else{
                
                NSString *strTime = [NSString stringWithFormat:@"%d秒",timeout];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.codeBtn setTitle:strTime forState:UIControlStateNormal];
                    self.codeBtn.backgroundColor = [UIColor grayColor];
                    self.codeBtn.enabled = NO;
                    
                });
                timeout--;
                
            }
        });
        dispatch_resume(_timer);
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发送成功" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"发送成功" preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }
    }else if([arr isEqualToString:@"1"]){
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号未注册" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"手机号未注册" preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }
    }else if([arr isEqualToString:@"2"]){
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"今天验证码获取次数已使用完毕" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"今天验证码获取次数已使用完毕" preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }

    }else if ([arr isEqualToString:@"3"]){
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"今天验证码获取次数已使用完毕" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"今天验证码获取次数已使用完毕" preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }

    }else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"系统故障" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"系统故障" preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }

    }
}
}

- (IBAction)handlePassEmail:(UIButton *)sender {
     [self.llTextField resignFirstResponder];
    [self.checkCodeField resignFirstResponder];
    NSString *str = @"http://www.enuo120.com/index.php/phone/Json/checkcode?phone=%@&code=%@";
    NSString *url = [NSString stringWithFormat:str,self.llTextField.text,self.checkCodeField.text];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       [self handleRequestData: responseObject];
        
        NSLog(@"responseObject = %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
}];
    
    
}
- (void)handleRequestData:(NSDictionary *)data{
    NSString *srr = [data[@"data"] objectForKey:@"message"];
    self.dataStr = [data[@"data"]objectForKey:@"errcode"];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        self.alertView1 = [[UIAlertView alloc]initWithTitle:@"提示" message:srr delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        //self.alertView1.delegate =self;
        [self performSelector:@selector(popVC) withObject:nil afterDelay:0.5];
        
    }else{
        self.alertView2 = [UIAlertController alertControllerWithTitle:@"提示" message:srr
                                                       preferredStyle:UIAlertControllerStyleAlert];
        [self.alertView2 addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           // [self.navigationController popViewControllerAnimated:YES];
            if ([self.dataStr isEqualToString:@"0"]) {
                ForgetMmOneViewController *forGet = [[ForgetMmOneViewController alloc]init];
                forGet.receiver = self.llTextField.text;
                [self.navigationController pushViewController:forGet animated:YES];
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
      ForgetMmOneViewController *forGet = [[ForgetMmOneViewController alloc]init];
    switch (buttonIndex) {
        case 0:
            if ([self.dataStr isEqualToString:@"0"]) {
                 [self.navigationController pushViewController:forGet animated:YES];
                   forGet.receiver = self.llTextField.text;
            }
           // [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            break;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.llTextField resignFirstResponder];
    [self.checkCodeField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
