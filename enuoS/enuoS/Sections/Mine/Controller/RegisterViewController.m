//
//  RegisterViewController.m
//  enuoS
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RegisterViewController.h"
#import "Macros.h"
#import <AFNetworking.h>
#import <Masonry.h>
#import "ReSSSSViewController.h"





@interface RegisterViewController ()<UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic,strong)UITextField *numText;
@property (nonatomic,strong)UITextField *codeText;

@property (nonatomic,strong)UITextField *passText;


@property (nonatomic,strong)NSDictionary *optionDic;//配置项；
@property (nonatomic,copy)NSString *nPhoneField;

@property (nonatomic,strong)UIButton *secButton;

@property (nonatomic,copy)NSString *markStr;


@end

@implementation RegisterViewController





- (NSDictionary *)optionDic{
    if (!_optionDic) {
        self.optionDic = [NSDictionary dictionary];
    }return _optionDic;
}

- (UITextField *)passText{
    if (!_passText) {
        self.passText = [[UITextField alloc]init];
    }return _passText;
}

- (UITextField *)numText {
    if ( !_numText) {
        self.numText = [[UITextField alloc]init];
    }return _numText;
    
}


- (UITextField *)codeText{
    if (!_codeText) {
        self.codeText = [[UITextField alloc]init];
    }return _codeText;
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }return self;
}





- (void)viewDidLoad {
    [super viewDidLoad];
     self.optionDic =@{@"0":@"C",@"1":@"An",@"2":@"H@",@"3":@"D",@"4":@"R",@"5":@"Vc",@"6":@"XZ",@"7":@"J",@"8":@"m",@"9":@"Q"};
    self.markStr = @"1";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    //    让黑线消失的方法
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    
    [self creatRegisterView];
}

- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (void)creatRegisterView{
    
    UIImageView *imageBelow = [[UIImageView alloc]init];
    self.view = imageBelow;
    imageBelow.userInteractionEnabled = YES;//打开响应者链
    imageBelow.image = [UIImage imageNamed:@"组-4"];
    
    
    UIImageView *numImage = [[UIImageView alloc]init];
    UIImageView *passWordImage = [[UIImageView alloc]init];
    UIImageView *mimaImage = [[UIImageView alloc]init];
    mimaImage.userInteractionEnabled = YES;
    numImage.userInteractionEnabled = YES;
    passWordImage.userInteractionEnabled = YES;
    numImage.image = [UIImage imageNamed:@"账号"];
    passWordImage.image = [UIImage imageNamed:@"验证码"];
    mimaImage.image = [UIImage imageNamed:@"密码"];
    
    UIButton *pressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pressButton setImage:[UIImage imageNamed:@"勾-(1)"] forState:UIControlStateNormal];
    [pressButton addTarget:self action:@selector(handleWithPress:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *pressLabel = [[UILabel alloc]init];
    pressLabel.text = @"已阅读并同意";
    pressLabel.textColor = [UIColor grayColor];
    pressLabel.font = [UIFont systemFontOfSize:11.0];
    UIButton *textButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [textButton setTitle:@"使用条款及隐私政策" forState: UIControlStateNormal ];
    textButton.titleLabel.font = [UIFont systemFontOfSize:11.0];
    [textButton setTitleColor:[UIColor colorWithRed:35/255.0 green:157/255.0 blue:233/255.0 alpha:1] forState:UIControlStateNormal];
    [textButton addTarget:self action:@selector(handleWithtext:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
     _secButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_secButton setImage:[UIImage imageNamed:@"点击获取"] forState:UIControlStateNormal];
   
    [_secButton addTarget:self action:@selector(handleWithVerify:) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setImage:[UIImage imageNamed:@"注册"] forState:UIControlStateNormal];
    
    
    [registerButton addTarget:self action:@selector(handleWithRegister:) forControlEvents:UIControlEventTouchUpInside];
    
    self.numText.placeholder = @"请输入手机号";
    self.codeText.placeholder = @"请输入验证码";
    self.passText.placeholder = @"请输入密码";
    self.numText.font = [UIFont systemFontOfSize:13.0];
    self.codeText.font = [UIFont systemFontOfSize:13.0];
    self.passText.font = [UIFont systemFontOfSize:13.0];
    
    
    
    
    
    
    [imageBelow addSubview:numImage];
    [imageBelow addSubview:passWordImage];
    [imageBelow addSubview:pressLabel];
    [imageBelow addSubview:pressButton];
    [imageBelow addSubview:textButton];
    [imageBelow addSubview:registerButton];
    [imageBelow addSubview:mimaImage];
    
    [numImage addSubview:self.numText];
    [passWordImage addSubview:self.codeText];
    [passWordImage addSubview:_secButton];
    [mimaImage addSubview:self.passText];
    
    
        __weak typeof (self) weakSelf = self;
   // weakSelf.numText.backgroundColor = [UIColor yellowColor];
    [weakSelf.numText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numImage.mas_left).with.offset(85);
        make.right.equalTo(numImage.mas_right);
        
        make.centerY.equalTo(numImage);
        make.height.mas_equalTo(@40);
        
        
    }];
   // weakSelf.passWordText.backgroundColor = [UIColor yellowColor];
    
    [weakSelf.codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passWordImage.mas_left).with.offset(85);
        make.right.equalTo(weakSelf.secButton.mas_left);
        make.centerY.equalTo(passWordImage);
        make.height.mas_equalTo(@40);
        make.width.mas_equalTo(@85);
        
        
    }];
    [weakSelf.passText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mimaImage.mas_left).with.offset(85);
        make.right.equalTo(mimaImage.mas_right);
        
        make.centerY.equalTo(mimaImage);
        make.height.mas_equalTo(@40);
        
        
    }];

    [ weakSelf.secButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo( weakSelf.codeText.mas_right);
        make.top.equalTo (passWordImage.mas_top);
        make.right.equalTo (passWordImage.mas_right);
        make.bottom.equalTo (passWordImage.mas_bottom);
        
        
        
    }];
    
    [numImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (imageBelow);
        make.centerY.mas_equalTo(imageBelow).with.offset(-80);
        make.width.mas_equalTo(@250);
        make.height.mas_equalTo(@40);
    }];
    [passWordImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (imageBelow);
        make.centerY.mas_equalTo(imageBelow).with.offset(-30);
        make.width.mas_equalTo(@250);
        make.height.mas_equalTo(@40);
    }];
    [mimaImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (imageBelow);
        make.centerY.mas_equalTo(imageBelow).with.offset(20);
        make.width.mas_equalTo(@250);
        make.height.mas_equalTo(@40);
    }];
    [pressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo (imageBelow).with.offset(-65);
        make.centerY.mas_equalTo(imageBelow).with.offset(50);
        make.width.mas_equalTo(@15);
        make.height.mas_equalTo(@15);
    }];
    [pressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(pressButton);
        make.left.mas_equalTo (pressButton.mas_right).with.offset(5);
        make.width.mas_equalTo(@75);
    }];
    [textButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(pressLabel);
        make.left.equalTo(pressLabel.mas_right);
        make.trailing.equalTo(passWordImage);
    }];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (imageBelow);
        make.centerY.mas_equalTo(imageBelow).with.offset(90);
        make.width.mas_equalTo(@250);
        make.height.mas_equalTo(@40);
    }];
}

- (void)handleWithtext:(UIButton *)sender{
    ReSSSSViewController *ssVC = [[ReSSSSViewController alloc]init];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:ssVC];
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
}

//注册按钮!!!!!!!!!!!!!!!
- (void)handleWithRegister:(UIButton *)sender{
    if ([self.markStr isEqualToString:@"2"]) {
        NSString * regex2 = @"^[a-zA-Z0-9]{6,16}$";
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES  %@", regex2];
        if (![pred2 evaluateWithObject: _passText.text]&&_passText.text.length>0){
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码格式不对" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }else{
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码格式不对" preferredStyle:UIAlertControllerStyleAlert];
                [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alertView animated:YES completion:^{
                    
                }];
            }
        }else
        {
            NSString *url  = @"http://www.enuo120.com/index.php/app/Patient/insert";
            NSMutableDictionary *str3 = [NSMutableDictionary dictionaryWithObject:self.numText.text forKey:@"username"];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            //登陆成功后把用户名和密码存储到UserDefault
            [userDefaults setObject:self.numText.text forKey:@"nameOne"];
            [str3 setValue:self.passText.text forKey:@"password"];
            AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
            [str3 setValue:self.codeText.text forKey:@"code"];
            
            [manger POST:url parameters:str3 progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"responseObject = %@",responseObject);
                [self handleWithRegisterOfData:responseObject];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
            
            
            
        }
    }else{
        NSLog(@"");
    }
}
//处理注册返回信息
- (void)handleWithRegisterOfData:(NSDictionary *)data{
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
        
        if (  [ data[@"data"][@"errcode"] integerValue] == 0 ) {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }else{
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
                [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                }]];
                [self presentViewController:alertView animated:YES completion:^{
                    
                }];
            }
            
        }else{
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:data[@"data"][@"message"] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }else{
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:data[@"data"][@"message"] preferredStyle:UIAlertControllerStyleAlert];
                [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alertView animated:YES completion:^{
                    
                }];
            }

        }
    }
}

//勾选同意协定
- (void)handleWithPress:(UIButton *)sender{
    if(sender.isSelected == NO){
        //记得昨晚操作之后，改变按钮的点击状态
        [sender setImage:[UIImage imageNamed:@"勾"] forState:UIControlStateNormal];
        //self.registerButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
   self.markStr = @"2";
        sender.selected = YES;
    }else{
        
           [sender setImage:[UIImage imageNamed:@"勾-(1)"] forState:UIControlStateNormal];
       // self.imageAcc.image = [UIImage imageNamed:@"check"];
       self.markStr = @"1";
        
        sender.selected = NO;
    }

    
    
}
//验证码
- (void)handleWithVerify:(UIButton *)sender{
    
    NSString * regex1 = @"[1][3578]\\d{9}";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES  %@", regex1];
    if ([pred1 evaluateWithObject: _numText.text]){
        //        if ([sender.titleLabel.text isEqualToString:@"免费获取"]||[sender.titleLabel.text isEqualToString:@"重新发送"]) {
        NSArray *keys = self.optionDic.allKeys;
        self.nPhoneField = self.numText.text;
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
        NSString *str1= @"http://www.enuo120.com/index.php/app/public/send_msg";
        // NSString *str2 = [NSString stringWithFormat:str1,self.phoneText.text];
        NSMutableDictionary *str3 = [NSMutableDictionary dictionaryWithObject:self.nPhoneField forKey:@"phone"];
        [str3 setValue:uuid forKey:@"uuid"];
        AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
        [str3 setValue:@"register" forKey:@"type"];
        NSLog(@"str3 = %@",str3);
        [manger POST:str1 parameters:str3 progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleCodeMImaWithData:responseObject];
            NSLog(@"responseObject = %@",responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error = %@",error);
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"验证过于频繁，请稍后再试" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }else{
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证过于频繁，请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
                [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alertView animated:YES completion:^{
                    
                }];
            }
        }];
        
        
        
        
    }else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确手机号" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确手机号" preferredStyle:UIAlertControllerStyleAlert];
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
        
       // NSArray *arr  = data[@"data"];
        if (  [ data[@"data"][@"errcode"] integerValue] == 0 ) {
              //  NSLog(@"更换图片！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！");
            __block int timeout = 60; //倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        self.secButton.enabled = YES;
                        [self.secButton setTitle:nil forState:UIControlStateNormal];
                        [self.secButton setImage:[UIImage imageNamed:@"点击重新获取"] forState:UIControlStateNormal];
                        NSLog(@"更换图片！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！");
                        //self.secButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
                    });
                }else{
                    
                    NSString *strTime = [NSString stringWithFormat:@"%d秒",timeout];
                    dispatch_async(dispatch_get_main_queue(), ^{
                       //  NSLog(@"第一次更换图片！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！");
                        
                        
                        
                        [self.secButton setImage:[UIImage imageNamed:@"圆角矩形-4"] forState:UIControlStateNormal];
                        self.secButton.titleLabel.font = [UIFont systemFontOfSize:11.0];
                        [self.secButton setTitle:strTime forState:UIControlStateNormal];
                        _secButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
                        [self.secButton setTitleEdgeInsets:UIEdgeInsetsMake(0 ,-self.secButton.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
                        [_secButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, -_secButton.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
                        //self.secButton.backgroundColor = [UIColor grayColor];
                        self.secButton.enabled = NO;
                        
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
        
        }else {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:data[@"data"][@"message"] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }else{
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:data[@"data"][@"message"] preferredStyle:UIAlertControllerStyleAlert];
                [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alertView animated:YES completion:^{
                    
                }];
            }
        }
    }

}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            break;
            
        default:
            break;
    }
}

// 配置键盘协议
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_codeText resignFirstResponder];
    [_numText resignFirstResponder];
    [_passText resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
