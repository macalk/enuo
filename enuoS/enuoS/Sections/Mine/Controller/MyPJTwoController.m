//
//  MyPJTwoController.m
//  enuoS
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyPJTwoController.h"
#import "Macros.h"

#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "SubzhuiViewController.h"
#import "pjHosModel.h"
#import "PJHosTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>


#define IOS8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0


@interface MyPJTwoController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,copy)NSString *pjcid;
@end

@implementation MyPJTwoController

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
    [self creataTableView];
    [self requestData];
 
}

- (void)creataTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
   
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PJHosTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PJHosTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    pjHosModel *model = self.dataArray[indexPath.row];
    
    NSString *url = [NSString stringWithFormat:urlPicture,model.hospital_photo];
    
    cell.hosLabel.text = model.hospital;
    [cell.hosPhoto sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.centLabel.text = model.hos_content;
    
    if (![model.hos_zhui isEqualToString:@""]) {
        UILabel *zhuiLabel = [[UILabel alloc]init];
        UILabel *zhuiTextLabel = [[UILabel alloc]init];
        [cell.bgView addSubview:zhuiLabel];
        [cell.bgView addSubview:zhuiTextLabel];
        zhuiLabel.text = @"追评";
        zhuiLabel.font = [UIFont systemFontOfSize:14.0];
        zhuiTextLabel.text = model.hos_zhui;
        zhuiTextLabel.font = [UIFont systemFontOfSize:13.0];
        zhuiTextLabel.textColor =[UIColor lightGrayColor];
        zhuiTextLabel.numberOfLines = 0;
        [cell.markBtn setImage:[UIImage imageNamed:@"bj.png"] forState:UIControlStateNormal];
        [zhuiTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.centLabel.mas_bottom).with.offset(10);
            make.leading.equalTo(cell.centLabel);
            make.trailing.equalTo(cell.centLabel);
            
            
        }];
        
        [zhuiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@42);
            make.centerY.equalTo(zhuiTextLabel);
            make.right.equalTo(zhuiTextLabel.mas_left).with.offset(5);
        }];

    }else{
          [cell.markBtn setImage:[UIImage imageNamed:@"bj2"] forState:UIControlStateNormal];
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
        pjHosModel *model = self.dataArray[indexPath.row];
        self.pjcid = model.cid;
        if ([model.hos_zhui isEqualToString:@""]) {
            if(IOS8){
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                
                // Create the actions.
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"发布追评" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                    SubzhuiViewController *subVC = [[SubzhuiViewController alloc]init];
                    
                    
                    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:subVC];
                    subVC.receiver = @"1";
                    subVC.cidReceiver = model.cid;
                    [self presentViewController:naNC animated:YES completion:^{
                        
                    }];
                    
                }];
                
                UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    NSLog(@"取消");
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
        subVC.receiver = @"1";
        subVC.cidReceiver = self.pjcid;
        [self presentViewController:naNC animated:YES completion:^{
            
        }];
    }else {
        NSLog(@"取消");
    }
    
}

- (void)requestData{
    NSString *url = @"http://www.enuo120.com/index.php/app/Patient/hos_comment";
    NSUserDefaults *userStand = [NSUserDefaults standardUserDefaults];
    
    NSString *name  = [userStand objectForKey:@"name"];
    
    NSDictionary *hearbody = @{@"username":name};
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger POST:url parameters:hearbody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithData:responseObject];
        NSLog(@"resss = %@",responseObject);
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];


}

- (void)handleWithData:(NSDictionary *)dic{
    if ([dic[@"data"]isKindOfClass:[NSNull class]]) {
        [self creatnullView];
    }else{
    NSArray *arr = dic[@"data"];
    for (NSDictionary *temp in arr) {
        pjHosModel *model =  [pjHosModel pjHosModelInitWith:temp];
        [self.dataArray addObject:model];
    }[self.tableView reloadData];
    if (self.dataArray.count == 0) {
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
