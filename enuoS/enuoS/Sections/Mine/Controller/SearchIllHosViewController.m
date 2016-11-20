//
//  SearchIllHosViewController.m
//  enuoS
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchIllHosViewController.h"
#import <AFNetworking.h>
#import "Macros.h"
#import <Masonry.h>
#import <SVProgressHUD.h>
#import "SearchillHosModel.h"
#import "SarchIllHosTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "UIImageView+UIImageView_FaceAwareFill.h"

#import "SearchILLDocController.h"
@interface SearchIllHosViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSArray *hosArr;
@end

@implementation SearchIllHosViewController

- (NSArray *)hosArr{
    if (!_hosArr) {
        self.hosArr = [NSArray array];
    }return _hosArr;
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView =[[UITableView alloc]init];
    }return _tableView;
}



- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }return _dataArray;
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
    [SVProgressHUD show];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self creatTableView];
    [self requestData];
}

- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)creatTableView{
    self.tableView.delegate = self;
    self.tableView .dataSource =self;
    self.view  = self.tableView;
    self.tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SarchIllHosTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}




- (void)requestData{
    NSString *url = @"http://www.enuo120.com/index.php/app/search/many_hospital";
    NSDictionary *heardBody = @{@"ill":self.receiver};
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    [mager POST:url parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"REEEE = %@",responseObject);
        [self handleWithData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)handleWithData:(NSDictionary*)dic{
    if ([dic[@"data"] isKindOfClass:[NSNull class]]) {
        NSLog(@"无数据");
    }else{
        NSDictionary *data = dic[@"data"];
        
        SearchillHosModel *model = [SearchillHosModel searchillHosModelInitWithDic:data];
        [self.dataArray addObject:model];
        
        NSLog(@"MODEL.HOS = %@",model.hos);
        self.hosArr = model.hos;
        NSLog(@"SELF.HOSARR = %@",self.hosArr);
        [self.tableView reloadData];
    }
    
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 75;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.dataArray.count != 0) {
        SearchillHosModel *model = self.dataArray[0];
        UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
        aView.backgroundColor= [UIColor whiteColor];
        UIImageView *imager= [[UIImageView alloc]init];
        UILabel *label = [[UILabel alloc]init];
        [aView addSubview:imager];
        [aView addSubview:label];
        NSString *str = [NSString stringWithFormat:urlPicture,model.photo];
        [imager sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
        UILabel *cycleLabel = [[UILabel alloc]init];
        UILabel *cycletext = [[UILabel alloc]init];
        UILabel *priceLabel = [[UILabel alloc]init];
        UILabel *pricetext = [[UILabel alloc]init];
        
        cycleLabel.text =@"周期:";
        cycleLabel.font = [UIFont systemFontOfSize:11.0f];
        cycleLabel.textColor = [UIColor lightGrayColor];
        cycletext.textColor = [UIColor lightGrayColor];
        
        cycletext.font = [UIFont systemFontOfSize:11.0f];
        cycletext.text  = model.cycle;
        priceLabel.text = @"价格:";
        priceLabel.font = [UIFont systemFontOfSize:11.0f];
        priceLabel.textColor = [UIColor lightGrayColor];
        pricetext.text = [NSString stringWithFormat:@"%@-%@元",model.lowprice,model.heightprice];
        pricetext.font = [UIFont systemFontOfSize:11.0f];
        pricetext.textColor = [UIColor lightGrayColor];
        
        
        [aView addSubview:cycletext];
        [aView addSubview:cycleLabel];
        [aView addSubview:pricetext];
        [aView addSubview:priceLabel];
        
        
        
        imager.layer.borderColor = [UIColor grayColor].CGColor;
        imager.backgroundColor = [UIColor whiteColor];
        imager.layer.borderWidth = 0.5;
        imager.layer.cornerRadius = 30.0;
        
        imager.clipsToBounds = YES;
        
        label.textColor =  [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:14];
        label.text = model.ill;
       // __weak typeof(self) weakSelf = self;
        
        [imager mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(aView.mas_top).with.offset(5);
            make.left.equalTo(aView.mas_left).with.offset(10);
            make.width.mas_equalTo(@60);
            make.height.mas_equalTo(@60);
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(imager);
            make.left .equalTo(imager.mas_right).with.offset(15);
            make.right.equalTo(aView.mas_right).with.offset(15);
            
        }];
        [cycleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(label);
            make.width.mas_equalTo(@30);
            make.top.equalTo (label.mas_bottom);
            
        }];
        [cycletext mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo (cycleLabel.mas_right).with.offset(5);
            make.right.equalTo(aView.mas_right);
            make.top.equalTo(cycleLabel);
        }];
        
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo (cycleLabel);
            make.top.equalTo(cycleLabel.mas_bottom);
            make.width.mas_equalTo(@30);
            
        }];
        [pricetext mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo (priceLabel.mas_right).with.offset(5);
            make.right.equalTo (aView.mas_right);
            make.top.equalTo(priceLabel);
        }];
        
        
        
        
        return aView;

    }else{
        return nil;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"asdasd");
      SearchillHosModel *model = self.dataArray[0];
    SearchILLDocController *sVC = [[SearchILLDocController alloc]init];
    sVC.illReceiver = model.ill;
    sVC.hid = self.hosArr[indexPath.row][@"id"];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:sVC];
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SarchIllHosTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    cell.hosName.text =self.hosArr[indexPath.row][@"hos_name"];
    NSString *str = [NSString stringWithFormat:urlPicture,self.hosArr[indexPath.row][@"hospital_photo"]];
    [cell.hosImage sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
    
    cell.priceLabel.text = [NSString stringWithFormat:@"%@-%@元",self.hosArr[indexPath.row][@"lowprice"],self.hosArr[indexPath.row][@"heightprice"]];
    cell.cycleLabel.text = self.hosArr[indexPath.row][@"cycle"];
    NSString *str1 = [self.hosArr[indexPath.row][@"effect"] stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    
    cell.effectLabel.text = [str1 stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
    cell.contentView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:247/255.0 alpha:1];
    
    
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    // [cell.contentView addSubview:imageD9];
    cell.bgView.layer.cornerRadius = 4.0;
    cell.bgView.layer.borderColor = [UIColor whiteColor].CGColor;
    //cell.bgView.layer.borderWidth = 1.0;
    
    
    cell.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
    cell.bgView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    cell.bgView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    cell.bgView.layer.shadowRadius = 4;
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return self.hosArr.count;
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
