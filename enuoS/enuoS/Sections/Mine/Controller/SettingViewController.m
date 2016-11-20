//
//  SettingViewController.m
//  enuoS
//
//  Created by apple on 16/8/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SettingViewController.h"
#import <AFNetworking.h>
#import "Macros.h"
#import "MImaViewController.h"
#import "PayMimaViewController.h"
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;


@end

@implementation SettingViewController

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]init];
    }return _tableView;
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
    self.navigationItem.title = @"设置";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:15],
       
       
       NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self creatTaBleView];
}
- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)creatTaBleView{
    
    self.tableView.dataSource =self;
    self.tableView.delegate  = self;
    self.view = self.tableView;
    self.tableView .backgroundColor =[UIColor whiteColor];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, kScreenWidth-100, 40)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    UIImageView *aimage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-30, 10, 10, 15)];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    aimage.image = [UIImage imageNamed:@"下一步"];
    [aView addSubview:aimage];
    
    aView.backgroundColor = [UIColor whiteColor];
    aLabel.font = [UIFont systemFontOfSize:14];
    
    [aView addSubview:aLabel];
    
    [aView addSubview:imageView];

if (indexPath.row == 0) {
        
        aLabel.text = @"修改登录密码";
        imageView.image = [UIImage imageNamed:@"手机号"];
        
        [cell.contentView addSubview:aView];
  }else {
    aLabel.text = @"修改支付密码";
    imageView.image = [UIImage imageNamed:@"修改密码"];

    [cell.contentView addSubview:aView];
  }
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MImaViewController *miaVC = [[MImaViewController alloc]init];
        [self.navigationController pushViewController:miaVC animated:YES];
    }else {
        PayMimaViewController *payVC = [[PayMimaViewController alloc]init];
        
        [self.navigationController pushViewController:payVC animated:YES];
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
