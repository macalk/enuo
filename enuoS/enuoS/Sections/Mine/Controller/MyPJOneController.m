//
//  MyPJOneController.m
//  enuoS
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyPJOneController.h"
#import "Macros.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "PJDocTableViewCell.h"
#import "PjDocModel.h"
#import <Masonry.h>
#import "SubzhuiViewController.h"


#define IOS8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0


@interface MyPJOneController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,copy)NSString *pjcid;
@end

@implementation MyPJOneController


- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]init];
    }return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    [self creatTableView];
    [self requestData];
}

- (void)creatTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PJDocTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    
    
    
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PJDocTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    PjDocModel *model = self.dataArray[indexPath.row];
    NSString *url = [NSString stringWithFormat:urlPicture,model.doctor_photo];
    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    cell.nameLabel.text = model.doctor;
    cell.proLabel.text = model.professional;
    cell.deskLabel.text = model.dep_name;
    cell.addressLabel.text = model.content;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (![model.zhui isEqualToString:@""]) {
        UILabel *zhuiLabel = [[UILabel alloc]init];
        UILabel *zhuiTextLabel = [[UILabel alloc]init];
        [cell.bgView addSubview:zhuiLabel];
        [cell.bgView addSubview:zhuiTextLabel];
        zhuiLabel.text = @"追评";
        zhuiLabel.font = [UIFont systemFontOfSize:14.0];
        zhuiTextLabel.text = model.zhui;
        zhuiTextLabel.font = [UIFont systemFontOfSize:13.0];
        zhuiTextLabel.textColor =[UIColor lightGrayColor];
        zhuiTextLabel.numberOfLines = 0;
        cell.markBtn.imageView.image = [UIImage imageNamed:@"bj"];
          //[cell.markBtn setImage:[UIImage imageNamed:@"bj"] forState:UIControlStateNormal];
        [zhuiTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.addressLabel.mas_bottom).with.offset(10);
            make.leading.equalTo(cell.addressLabel);
            make.trailing.equalTo(cell.addressLabel);
            
            
        }];
        
        [zhuiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@42);
            make.centerY.equalTo(zhuiTextLabel);
            make.right.equalTo(zhuiTextLabel.mas_left).with.offset(5);
        }];
    }else{
           cell.markBtn.imageView.image = [UIImage imageNamed:@"bj2"];
    }
     [cell.markBtn addTarget:self action:@selector(handelwithZPBtn: event:) forControlEvents:UIControlEventTouchUpInside];    
    
    return cell;
}

- (void)handelwithZPBtn: (id)sender event:(id)event{
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath= [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath != nil) {
        
        PjDocModel *model = self.dataArray[indexPath.row];
        self.pjcid = model.cid;
        
        if([model.zhui isEqualToString:@""]){
        if(IOS8){
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            // Create the actions.
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
            }];
            
            UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"发布追评" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                SubzhuiViewController *subVC = [[SubzhuiViewController alloc]init];
                
                
                UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:subVC];
                subVC.receiver = @"0";
                subVC.cidReceiver = model.cid;
                [self presentViewController:naNC animated:YES completion:^{
                    
                }];
            }];
            
            // Add the actions.
            [alertController addAction:cancelAction];
            [alertController addAction:destructiveAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }else{
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@""delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"发布追评" otherButtonTitles:nil, nil];
            
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
            [actionSheet showInView:self.view];
        }
        
        }else{
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该评论已追评" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }else{
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"该评论已追评" preferredStyle:UIAlertControllerStyleAlert];
                [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alertView animated:YES completion:^{
                    
                }];
            }

        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"lalal");
    
    
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    SubzhuiViewController *subVC = [[SubzhuiViewController alloc]init];
    
    
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:subVC];
    
    if (buttonIndex == 0) {
        subVC.receiver = @"0";
        subVC.cidReceiver  = self.pjcid;
        [self presentViewController:naNC animated:YES completion:^{
            
        }];
    }else {
        NSLog(@"取消");
    }
    
}


- (void)requestData{
    NSString *url = @"http://www.enuo120.com/index.php/app/Patient/doc_comment";
    NSUserDefaults *userStand = [NSUserDefaults standardUserDefaults];
    
    NSString *name  = [userStand objectForKey:@"name"];
    
    NSDictionary *hearbody = @{@"username":name};
    
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    [manger POST:url parameters:hearbody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithData:responseObject];
        NSLog(@"reeee  =%@",responseObject);
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


//cell点击事件

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    SubzhuiViewController *subVc = [[SubzhuiViewController alloc]init];
//    
//    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:subVc];
//    subVc.receiver= @"1";
//    [self presentViewController:naNC animated:YES completion:^{
//        
//    }];
//    
//    
//    
//}

- (void)handleWithData:(NSDictionary *)dic{
    if ([dic[@"data"]isKindOfClass:[NSNull class]]) {
        [self creatnullView];
    }else{
        
        NSArray *arr = dic[@"data"];
        
        for (NSDictionary *temp in arr) {
            PjDocModel *model  = [PjDocModel pjDocModelWithDic:temp];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
        if (self.dataArray.count ==0) {
            [self creatnullView];
        }else{
            self.view = self.tableView;
        }

    }
   }
- (void)creatnullView{
    UILabel *nullLabel = [[UILabel alloc]init];
    
    nullLabel.text = @"暂无数据";
    nullLabel.textColor = [UIColor lightGrayColor];
    nullLabel.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:nullLabel];
    __weak typeof(self) weakSelf = self;
    
    [nullLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.centerY.equalTo (weakSelf.view).with.offset(-100);
        
    }];
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
