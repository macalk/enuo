//
//  FindHosTableController.m
//  enuoS
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FindHosTableController.h"
#import "PromiseHosViewCell.h"
#import "Macros.h"

#import <AFNetworking.h>
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "HosViewController.h"
#import "FindHosModel.h"
#import "SarchDetailViewController.h"


@interface FindHosTableController ()<UISearchBarDelegate>
@property (nonatomic,strong)NSMutableArray *dataArray;

@property (assign, nonatomic) NSInteger num;


@end

@implementation FindHosTableController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }return _dataArray;
}

- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"PromiseHosViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.translucent = NO;
    self.num = 1;
      [self requestData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
}


- (void)refresh{
    //NSLog(@"你是个大逗逼");
    [self.dataArray removeAllObjects];
    _num = 1;
    [self requestData];
}

- (void)loadMore{
    // NSLog(@"都比都比");
    _num ++;
    [self requestData];
}






- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (void)requestData{
    NSString *str = @"http://www.enuo120.com/index.php/app/index/find_hospital";
    NSString * page = [NSString stringWithFormat:@"%ld",(long)self.num];
      NSDictionary *heardBody = @{@"page":page};
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger POST:str parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithDic:responseObject];
        [self endRefresh];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}

- (void)handleWithDic:(NSDictionary *)dic{
    if ([dic[@"data"]isKindOfClass:[NSNull class]]) {
        NSLog(@"taang wywiwiwjopakkksmn");
    }else{
        NSArray *arr = dic[@"data"];
        for (NSDictionary *temp in arr) {
            FindHosModel *model = [FindHosModel findHosModelInithWithDic:temp];
            [self.dataArray addObject:model];
        }[self.tableView reloadData];
        
     
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *searckView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(20, 2, kScreenWidth-40, 40)];
    [searchBar setSearchBarStyle:  UISearchBarStyleMinimal ];
    searchBar.placeholder = @"搜索医院";
    searchBar.delegate = self;
    searckView.backgroundColor = [UIColor colorWithRed:205/255.0 green:247/255.0 blue:249/255.0 alpha:1];

    
    
    
    
    
    searchBar.keyboardType = UIKeyboardTypeDefault;
    
    [searckView addSubview:searchBar];
    
    return searckView;
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    SarchDetailViewController *saVC = [[SarchDetailViewController alloc]init];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:saVC];
    
    saVC.receiveMark = @"1";
    saVC.resualt = searchBar.text;
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PromiseHosViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
  
    FindHosModel *model = self.dataArray[indexPath.row];
    
    
    cell.hosNameLabel.text = model.hos_name;
    cell.numLabel.text = model.zhen;
    cell.rankLabel.text = model.rank;
    cell.ybLabel.text = model.yb;
    cell.addressLabel.text = model.address;
    cell.illLabel.text = model.ill;
    
    NSString *str = [NSString stringWithFormat:urlPicture,model.photo];
    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
    
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
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HosViewController *hosVC = [[HosViewController alloc]init];

    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:hosVC];
    
    FindHosModel *model =self.dataArray[indexPath.row];

    hosVC.receiver = model.cid;
    
    [self presentViewController:naNC animated:YES completion:^{
        
    }];



}




-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
