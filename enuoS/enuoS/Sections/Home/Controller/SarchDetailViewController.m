//
//  SarchDetailViewController.m
//  enuoS
//
//  Created by apple on 16/8/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SarchDetailViewController.h"
#import "Macros.h"
#import "FindDocModel.h"
#import "FindHosModel.h"
#import "PromiseDocViewCell.h"
#import "PromiseHosViewCell.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "illSeaModel.h"
#import "ILLSearchTableViewCell.h"
#import "DoctorViewController.h"
#import "HosViewController.h"
#import "SearchIllHosViewController.h"

@interface SarchDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;


@end

@implementation SarchDetailViewController


- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView  = [[UITableView alloc]init];
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
    [self creatTableView];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self requestData];
}
- (void)handleWithBack:(UIBarButtonItem *)sender{
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)creatTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.view = self.tableView;
   self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"ILLSearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"illcell"];
        [self.tableView registerNib:[UINib nibWithNibName:@"PromiseHosViewCell" bundle:nil] forCellReuseIdentifier:@"hoscell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"PromiseDocViewCell" bundle:nil] forCellReuseIdentifier:@"doccell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.receiveMark isEqualToString:@"0"]) {
        ILLSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"illcell" forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:247/255.0 alpha:1];
        cell.bgView.layer.cornerRadius = 4.0;
        cell.bgView.layer.borderColor = [UIColor clearColor].CGColor;
        cell.bgView.layer.borderWidth = 1.0;
        
        cell.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
        cell.bgView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        cell.bgView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
        cell.bgView.layer.shadowRadius = 4;
        illSeaModel *model = self.dataArray[indexPath.row];
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        NSString *str = [NSString stringWithFormat:urlPicture,model.photo];
        [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
        cell.illLabel.text = model.ill;
        cell.priceLabel.text = [NSString stringWithFormat:@"不高于%@元",model.heightprice];
        cell.cycleLabel.text = model.cycle;
     
    NSString *strOne = [model.effect stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
           cell.effectLabel.text = [strOne stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
        return cell;
        
    }else if ([self.receiveMark isEqualToString:@"1"]){
        PromiseHosViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hoscell" forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:247/255.0 alpha:1];
        cell.bgView.layer.cornerRadius = 4.0;
        cell.bgView.layer.borderColor = [UIColor clearColor].CGColor;
        cell.bgView.layer.borderWidth = 1.0;
        
        cell.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
        cell.bgView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        cell.bgView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
        cell.bgView.layer.shadowRadius = 4;
        FindHosModel *model = self.dataArray[indexPath.row];
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        cell.hosNameLabel.text = model.hos_name;
        cell.numLabel.text = model.zhen;
        cell.rankLabel.text = model.rank;
        cell.ybLabel.text = model.yb;
        cell.addressLabel.text = model.address;
        cell.illLabel.text = model.ill;
        
        NSString *str = [NSString stringWithFormat:urlPicture,model.photo];
        [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
        
        
        
        return cell;

    }else{
        PromiseDocViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"doccell" forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:247/255.0 alpha:1];
        
        
    
        
        // [cell.contentView addSubview:imageD9];
        cell.bgView.layer.cornerRadius = 4.0;
        cell.bgView.layer.borderColor = [UIColor whiteColor].CGColor;
        //cell.bgView.layer.borderWidth = 1.0;
        
        
        cell.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
        cell.bgView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        cell.bgView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
        cell.bgView.layer.shadowRadius = 4;
        FindDocModel *model = self.dataArray[indexPath.row];
        cell.nameLabel.text = model.name;
        cell.nuoNumber.text = model.nuo;
        
        NSString *str0ne = [NSString stringWithFormat:urlPicture,model.photo];
        
        cell.illLabel.text = model.ill;
        
        [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:str0ne] placeholderImage:nil];
        NSLog(@"model.professinaol = %@",model.professional);
        cell.proLabel.text = model.professional;
        cell.deskLabel.text = model.dep_name;
        cell.pepLaebl.text = model.zhen;
        cell.hosLabel.text = model.hos_name;
        
        return  cell;

    }
}


- (void)requestData{
    NSString *url = @"http://www.enuo120.com/index.php/app/search/search_result";
    NSDictionary *heardBody = @{@"type":self.receiveMark,@"search_val":self.resualt};
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    
    [mager POST:url parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"ress = %@",responseObject);
        [self handleWithDic:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}

- (void)handleWithDic:(NSDictionary *)dic{
    NSArray *arr = dic[@"data"];
    if ([dic[@"data"]isEqual:[NSNull null]]) {
        [self creatnullView];
    }else{
        self.view = self.tableView;
    if ([self.receiveMark isEqualToString:@"0"]) {
        for (NSDictionary *temp  in arr) {
            illSeaModel *model = [illSeaModel IllinItWithDic:temp];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
    }else if ([self.receiveMark isEqualToString:@"1"]){
        for (NSDictionary *temp  in arr) {
           FindHosModel *model = [FindHosModel findHosModelInithWithDic:temp];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
       
    }else{
        for (NSDictionary *temp  in arr) {
           FindDocModel *model = [FindDocModel findDocModelInitWithDic: temp];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.receiveMark isEqualToString:@"0"]) {
        illSeaModel *model = self.dataArray[indexPath.row];
        SearchIllHosViewController *sar = [[SearchIllHosViewController alloc]init];
        sar.receiver = model.ill;
        UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:sar];
        [self presentViewController:naNC animated:YES completion:^{
            
        }];
    }else if ([self.receiveMark isEqualToString:@"1"]){
        HosViewController *hosVC = [[HosViewController alloc]init];
        
        UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:hosVC];
        
        FindHosModel *model =self.dataArray[indexPath.row];
        
        hosVC.receiver = model.cid;
        
        [self presentViewController:naNC animated:YES completion:^{
            
        }];
        
    }else{
        DoctorViewController *docVC = [[DoctorViewController alloc]init];
        
        
        UINavigationController *navNC = [[UINavigationController alloc]initWithRootViewController:docVC];
        FindDocModel *monder = self.dataArray[indexPath.row];
        docVC.receiver = monder.cid;
        
        [self presentViewController:navNC animated:YES completion:^{
            
        }];

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
