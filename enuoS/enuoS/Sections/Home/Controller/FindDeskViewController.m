//
//  FindDeskViewController.m
//  enuoS
//
//  Created by apple on 16/8/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FindDeskViewController.h"

#import "Macros.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <Masonry.h>
#import "WJDropdownMenu.h"
#import "DeskModel.h"
#import "PromiseHosViewCell.h"
#import <MJRefresh.h>
#import "FindHosModel.h"
#import "DeskTwoModel.h"
#import <UIImageView+WebCache.h>
#import "HosViewController.h"
#import "FindDocModel.h"
#import "PromiseDocViewCell.h"
#import "DoctorViewController.h"
@interface FindDeskViewController ()<UITableViewDataSource,UITableViewDelegate,WJMenuDelegate>

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,weak)WJDropdownMenu *menu;


//医生信息
@property (nonatomic,assign)NSInteger num;
@property (nonatomic,copy)NSString *dep_id;
@property (nonatomic,copy)NSString *sdep_id;
@property (nonatomic,copy)NSString *sort_order;//类型排序
//
@property (nonatomic,strong)NSMutableArray *secondDataArray;
@property (nonatomic,strong)NSMutableArray *secondPIDArray;
@property (nonatomic,strong)NSMutableArray *secondIdArray;


//
@property (nonatomic,strong)NSMutableArray *firstDataArray;
@property (nonatomic,strong)NSMutableArray *firstImageArray;
@property (nonatomic,strong)NSMutableArray *firstIdArray;


@property (nonatomic,strong)NSMutableArray *allHosDataArray;
@end

@implementation FindDeskViewController


- (NSMutableArray *)secondDataArray{
    if (!_secondDataArray) {
        self.secondDataArray = [NSMutableArray array];
    }return _secondDataArray;
}

- (NSMutableArray *)secondIdArray{
    if (!_secondIdArray) {
        self.secondIdArray = [NSMutableArray array];
    }return _secondIdArray;
}
- (NSMutableArray *)secondPIDArray{
    if (!_secondPIDArray) {
        self.secondPIDArray = [NSMutableArray array];
    }return _secondPIDArray;
}
- (NSMutableArray *)firstDataArray{
    if (!_firstDataArray) {
        self.firstDataArray = [NSMutableArray array];
    }return _firstDataArray;
}

- (NSMutableArray *)firstIdArray{
    if (!_firstIdArray) {
        self.firstIdArray = [NSMutableArray array];
    }return  _firstIdArray;
}

- (NSMutableArray *)firstImageArray{
    if (!_firstImageArray) {
        self.firstImageArray = [NSMutableArray array];
    }return _firstImageArray;
}

- (NSMutableArray *)allHosDataArray{
    if (!_allHosDataArray) {
        self.allHosDataArray = [NSMutableArray array];
    }return _allHosDataArray;
}


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }return _dataArray;
}

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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
     [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [SVProgressHUD show];
    self.num = 1;
    self.sdep_id = @"";
    self.dep_id = self.receiver;
    [self requestDeskData];
    [self requestAllHosData];
    [self requestDeskDetailDataWith:self.receiver];

    [self creatTableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"PromiseDocViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.frame = CGRectMake(0, 40, kScreenWidth, kScreenHeigth-155);
    [self.view addSubview:self.tableView];
    self.navigationController.navigationBar.translucent = NO;
    // 创建menu
    WJDropdownMenu *menu = [[WJDropdownMenu alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    menu.delegate = self;
    
    //  设置代理
    [self.view addSubview:menu];
    self.menu = menu;
    // 设置属性(可不设置)
    menu.caverAnimationTime = 0.2;             //  增加了展开动画时间设置   不设置默认是  0.15
    menu.hideAnimationTime = 0.2;              //  增加了缩进动画时间设置   不设置默认是  0.15
    menu.menuTitleFont = 12;                   //  设置menuTitle字体大小    不设置默认是  11
    menu.tableTitleFont = 11;                  //  设置tableTitle字体大小   不设置默认是  10
    menu.cellHeight = 38;                      //  设置tableViewcell高度   不设置默认是  40
    menu.menuArrowStyle = menuArrowStyleSolid; //  旋转箭头的样式(空心箭头 or 实心箭头)
    menu.tableViewMaxHeight = 200;             //  tableView的最大高度(超过此高度就可以滑动显示)
    menu.menuButtonTag = 100;                  //  menu定义了一个tag值如果与本页面的其他button的值有冲突重合可以自定义设置
    menu.CarverViewColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];//设置遮罩层颜色
    menu.selectedColor = [UIColor redColor];   //  选中的字体颜色
    menu.unSelectedColor = [UIColor grayColor];//  未选中的字体颜色
    // 第二中方法net网络请求一级一级导入数据，先在此导入菜单数据，然后分别再后面的net开头的代理方法中导入一级一级子菜单的数据
    NSArray *twoMenuTitleArray =@[ self.retitle];
    [menu netCreateMenuTitleArray:twoMenuTitleArray];
    
    
    //[self creatSegement];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    

}


- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)creatTableView{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    

    
}

- (void)refresh{
    //NSLog(@"你是个大逗逼");
    [self.allHosDataArray removeAllObjects];
    _num = 1;
    [self requestAllHosData];
}

- (void)loadMore{
    // NSLog(@"都比都比");
    _num ++;
    [self requestAllHosData];
}


#pragma mark ---------menu 代理的方法 返回点击时对应得index

- (void)menuCellDidSelected:(NSInteger)MenuTitleIndex firstIndex:(NSInteger)firstIndex secondIndex:(NSInteger)secondIndex thirdIndex:(NSInteger)thirdIndex{
    
    
    
    
    //self.dep_id  = [NSString stringWithFormat:@"%@",self.secondPIDArray[(long)MenuTitleIndex]];
    self.sdep_id  = [NSString stringWithFormat:@"%@",self.secondIdArray[(long)firstIndex]];
    
    
    
    [self.allHosDataArray removeAllObjects];
    [self requestAllHosData];
    
    
};
#pragma mark -- 代理方法2 返回点击时对应的内容
- (void)menuCellDidSelected:(NSString *)MenuTitle firstContent:(NSString *)firstContent secondContent:(NSString *)secondContent thirdContent:(NSString *)thirdContent{
    //
    //    NSLog(@"菜单title:%@       一级菜单:%@         二级子菜单:%@    三级子菜单:%@",MenuTitle,firstContent,secondContent,thirdContent);
    // NSLog(@"222222222222222");
    
    //    self.data = [NSMutableArray array];
    //    [self.data addObject:[NSString stringWithFormat:@"%@ 的 detail data 1",secondContent]];
    //    [self.data addObject:[NSString stringWithFormat:@"%@ 的 detail data 2",secondContent]];
    //    [self.data addObject:[NSString stringWithFormat:@"%@ 的 detail data 3",secondContent]];
    [self.tableView reloadData];
    
};

#pragma mark -- net网络获取数据代理方法返回点击时菜单对应的index(导入子菜单数据)
- (void)netMenuClickMenuIndex:(NSInteger)menuIndex menuTitle:(NSString *)menuTitle{
    
    // 模拟网络加载数据延时0.5秒，相当于传一个menuIndex的参数返回数据之后 调用netLoadFirstArray方法，将网络请求返回数据导入一级数据到菜单
    
    
    
     // [self.menu netLoadSecondArray:self.secondDataArray];
    
    [self.menu netLoadFirstArray:self.secondDataArray FirstImageArray:nil];
    
  //  [self.menu netLoadSecondArray:self.firstIdArray[self.receiver]];
    
}

#pragma mark -- net网络获取数据代理方法返回点击时菜单和一级子菜单分别对应的index(导入子菜单数据)
- (void)netMenuClickMenuIndex:(NSInteger)menuIndex menuTitle:(NSString *)menuTitle FirstIndex:(NSInteger)FirstIndex firstContent:(NSString *)firstContent{
    
    // 模拟网络加载数据延时0.5秒，相当于传menuIndex、FirstIndex的两个参数返回数据之后，调用 netLoadSecondArray 方法，将网络请求返回数据导入二级数据到菜单
    
    
    NSLog(@"firstIndex = %ld",(long)FirstIndex);
//    [self.secondDataArray removeAllObjects];
//    [self.secondIdArray removeAllObjects];
//    [self.secondPIDArray removeAllObjects];
    // self.secondDataArray = [NSMutableArray arrayWithObject:@"全部"];
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
    
    
        NSLog(@"self.secondArray = %@",self.secondDataArray);
    //NSArray  *secondArrTwo = @[@"a二级菜单21",@"a二级菜单22"];
    
    if (menuIndex == 0) {
        
        
        [self.allHosDataArray removeAllObjects];
        [self requestAllHosData];
//        [self.tableView reloadData];
        // NSLog(@"self.secondArray = %@",self.secondDataArray);
        //NSArray  *secondArrTwo = @[@"a二级菜单21",@"a二级菜单22"];
        
        
        
        
    }else{
        [self.menu netLoadSecondArray:nil];
    }

    
    
    
    // });
}


-(void)requestDeskData{
    NSString *str = @"http://www.enuo120.com/index.php/app/index/find_keshi";
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    [manger POST:str parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithDeskWithData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}






- (void)handleWithDeskWithData:(NSDictionary *)data{
    
    
    NSArray *arr = data[@"data"];
    for (NSDictionary *temp in arr) {
        DeskModel *model = [DeskModel deskModelInitWithDic:temp];
        
        [self.firstImageArray addObject:model.photo];
        [self.firstIdArray addObject:model.cid];
        [self.firstDataArray addObject:model.department];
    }
    if (self.firstIdArray.count != 0) {
        
        
    }
    
    
    // NSLog(@"self.firstDataArray = %@",self.firstDataArray);
}

//科室分类

- (void)requestDeskDetailDataWith:(NSString *)Cid{
    NSString *str = @"http://www.enuo120.com/index.php/App/index/get_sdep_list";
    AFHTTPSessionManager *manegr = [AFHTTPSessionManager manager];
    
    NSString *strHeader =  [NSString stringWithFormat:@"dep_id=%@",Cid];
    NSDictionary *heardBody = @{@"dep_id":self.receiver};
    NSLog(@"strHeader = %@",strHeader);
    [manegr POST:str parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self handleDataWithDeskDetailWith:responseObject];
      
        NSLog(@"self.secondDataArray  = %@",self.secondDataArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)handleDataWithDeskDetailWith:(NSDictionary *)data{
    
    if ([data[@"data"]isKindOfClass:[NSNull class]]
        ) {
        NSLog(@"无数据");
    }else{
        NSArray *arr = data[@"data"];
        
        
        
        for (NSDictionary *temp in arr) {
            DeskTwoModel *model = [DeskTwoModel deskTwoModelWithDic:temp];
            [self.secondDataArray addObject:model.sDepName];
            [self.secondIdArray addObject:model.cid];
            [self.secondPIDArray addObject:model.PID];
        }
        
    }//[self.tableView reloadData];
    
    
    
}
//请求所有医院的数据
- (void)requestAllHosData{
    NSString *url = @"http://www.enuo120.com/index.php/app/index/find_keshi_doc";
    
    //    NSString *sort = @"sort_order";
    //    NSString *sdep = @"sdep_id";
    //    NSString *dep = @"dep_id";
    NSString * page = [NSString stringWithFormat:@"%ld",(long)self.num];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    //     manger.responseSerializer.acceptableContentTypes = [NSSetsetWithObject:@"text/html"];
    NSDictionary *heardBody = @{@"page":page, @"dep_id":self.receiver,@"sdep_id":self.sdep_id};
    
    NSLog(@"heardBody = %@",heardBody);
    [manger POST:url parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithDataWithDoc: responseObject];
        //NSLog(@"resp[nde = %@",responseObject);
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
    
    
}

- (void)handleWithDataWithDoc:(NSDictionary *)data{
    if ([data[@"data"]isKindOfClass:[NSNull class]]
        ) {
        NSLog(@"无数据");
        [self endRefresh];
    }else{
        NSArray *arr = data[@"data"];
        
        
        
        for (NSDictionary *temp in arr) {
           FindDocModel *model = [FindDocModel findDocModelInitWithDic: temp];
            
            [self.allHosDataArray addObject:model];
        }
    }[self.tableView reloadData];
    [self endRefresh];
    
}

- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}


#pragma mark -----dataSource ------delegate---------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.allHosDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PromiseDocViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
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
    FindDocModel *model = self.allHosDataArray[indexPath.row];
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
    

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   DoctorViewController *hosVC = [[DoctorViewController alloc]init];
    
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:hosVC];
    
    FindDocModel *model =self.allHosDataArray[indexPath.row];
    
    hosVC.receiver = model.cid;
    
    [self presentViewController:naNC animated:YES completion:^{
        
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
