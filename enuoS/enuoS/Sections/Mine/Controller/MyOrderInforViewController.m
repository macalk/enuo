//
//  MyOrderInforViewController.m
//  enuoS
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyOrderInforViewController.h"
#import "TitleButtomView.h"
#import "BaseRequest.h"
#import "MyOrderInfoModel.h"
#import "UIColor+Extend.h"
#import "OrderView.h"

#import "ChoosePayWayViewController.h"
#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MyOrderInforViewController ()<titleButtonDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) TitleButtomView *titleButtonView;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) BaseRequest *request;

@property (nonatomic,strong) MyOrderInfoModel *myOrderModel;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) OrderView *orderView;


@property (nonatomic,strong) NSMutableArray *modelArr;//全部
@property (nonatomic,strong) NSMutableArray *waitDiagnoseModelArr;//等待就诊
@property (nonatomic,strong) NSMutableArray *waitPayModelArr;//待支付
@property (nonatomic,strong) NSMutableArray *WaitSureModelArr;//待确认
@property (nonatomic,strong) NSMutableArray *waitEvaluateModelArr;//待评价

@property (nonatomic,strong) NSMutableArray *tableViewArr;


@end

@implementation MyOrderInforViewController
- (NSMutableArray *)WaitSureModelArr {
    if (!_WaitSureModelArr) {
        _WaitSureModelArr = [NSMutableArray array];
    }return _WaitSureModelArr;
}
- (NSMutableArray *)waitEvaluateModelArr {
    if (!_waitEvaluateModelArr) {
        _waitEvaluateModelArr = [NSMutableArray array];
    }return _waitEvaluateModelArr;
}
- (NSMutableArray *)waitPayModelArr {
    if (!_waitPayModelArr) {
        _waitPayModelArr = [NSMutableArray array];
    }return _waitPayModelArr;
}

- (NSMutableArray *)waitDiagnoseModelArr {
    if (!_waitDiagnoseModelArr) {
        _waitDiagnoseModelArr = [NSMutableArray array];
    }return _waitDiagnoseModelArr;
}
- (NSMutableArray *)tableViewArr {
    if (!_tableViewArr) {
        _tableViewArr = [NSMutableArray array];
    }return _tableViewArr;
}

- (MyOrderInfoModel *)myOrderModel {
    if (!_myOrderModel) {
        _myOrderModel = [[MyOrderInfoModel alloc]init];
    }return _myOrderModel;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
    }return _tableView;
}
- (NSMutableArray *)modelArr {
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }return _modelArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的订单";
    
    NSArray *titleArray = @[@"全部",@"待就诊",@"待支付",@"待确认",@"待评价"];
    self.titleArray = titleArray;
    self.titleButtonView = [[TitleButtomView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 37)];
    self.titleButtonView.delegate = self;
    [self.titleButtonView createTitleBtnWithBtnArray:titleArray];
    [self.view addSubview:self.titleButtonView];
    
    self.request = [[BaseRequest alloc]init];
    [self requestMyOrderList];
    [self createScrollView];
    [self createTableView];

}

- (void)createScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 101, WIDTH, HEIGHT-101)];
    self.scrollView = scrollView;
    
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = YES;
    scrollView.contentOffset = CGPointMake(0, 0);
    scrollView.contentSize = CGSizeMake(WIDTH*self.titleArray.count, 0);
    
    [self.view addSubview:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x/WIDTH;
    [self.titleButtonView changeButtonState:index];
    
}

- (void)titleButtonClickDelegate:(NSInteger)btnTag {
    
    self.scrollView.contentOffset = CGPointMake(btnTag*WIDTH, 0);
    
}

- (void)createTableView {
    
    for (int i = 0; i<5; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH*i, 0, WIDTH, self.scrollView.bounds.size.height) style:UITableViewStylePlain];
        tableView.tag = 10+i;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.tableViewArr addObject:tableView];
        [self.scrollView addSubview:tableView];
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (tableView.tag) {
        case 10:
        {
            return self.modelArr.count;
 
        }
            break;
        case 11:
        {
            return self.waitDiagnoseModelArr.count;

        }
            break;
        case 12:
        {
            return self.waitPayModelArr.count;

        }
            break;
        case 13:
        {
            return  self.WaitSureModelArr.count;

        }
            break;
        case 14:
        {
            return  self.waitEvaluateModelArr.count;

        }
            break;
            
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    //清空
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    if (tableView.tag == 10) {//全部
        OrderView *orderView = [[OrderView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
        self.orderView = orderView;
        [cell.contentView addSubview:orderView];
        [orderView createViewWithModel:self.modelArr[indexPath.row]];
    }else if (tableView.tag ==11) {//等待就诊
        OrderView *orderView = [[OrderView alloc]initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 100)];
        self.orderView = orderView;
        [cell.contentView addSubview:orderView];
        [orderView createViewWithModel:self.waitDiagnoseModelArr[indexPath.row]];
    }else if (tableView.tag == 12) {//等待支付
        OrderView *orderView = [[OrderView alloc]initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 100)];
        self.orderView = orderView;
        [cell.contentView addSubview:orderView];
        [orderView createViewWithModel:self.waitPayModelArr[indexPath.row]];
    }else if (tableView.tag == 13) {//等待确认
        OrderView *orderView = [[OrderView alloc]initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 100)];
        self.orderView = orderView;
        [cell.contentView addSubview:orderView];
        [orderView createViewWithModel:self.WaitSureModelArr[indexPath.row]];
    }else if (tableView.tag == 14) {//等待评价
        OrderView *orderView = [[OrderView alloc]initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 100)];
        self.orderView = orderView;
        [cell.contentView addSubview:orderView];
        [orderView createViewWithModel:self.waitEvaluateModelArr[indexPath.row]];
    }
    
    self.tableView = tableView;
    
    self.orderView.cancelBtn.tag = indexPath.row;
    self.orderView.sureBtn.tag = indexPath.row+1000;
    
    [self.orderView.cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView.sureBtn addTarget:self action:@selector(makeSureBtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)makeSureBtn:(UIButton *)sender {
    [self getTableWithBtn:sender];
}
- (void)cancelBtn:(UIButton *)sender {
    [self getTableWithBtn:sender];
    
    
}

- (void)getTableWithBtn:(UIButton *)sender {
    for(UIView* next = [sender superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UITableView class]])
        {
            UITableView *tableView = (UITableView* )nextResponder;
            switch (tableView.tag) {
                case 10://全部订单
                {
                    if (sender.tag<1000) {//取消按钮
                        MyOrderInfoModel *model = self.modelArr[sender.tag];
                        NSLog(@"%@",model.dnumber);//订单号
                    }else {//确认按钮
                        MyOrderInfoModel *model = self.modelArr[sender.tag-1000];
                        NSLog(@"%@",model.dnumber);//订单号
                    }
                }
                    break;
                case 11://待就诊
                {
                    if (sender.tag<1000) {//取消按钮
                        MyOrderInfoModel *model = self.waitDiagnoseModelArr[sender.tag];
                        NSLog(@"%@",model.dnumber);//订单号
                    }else {//确认按钮
                        MyOrderInfoModel *model = self.waitDiagnoseModelArr[sender.tag-1000];
                        NSLog(@"%@",model.dnumber);//订单号
                    }
                }
                    break;
                case 12://待支付
                {
                    if (sender.tag<1000) {//取消按钮
                        MyOrderInfoModel *model = self.waitPayModelArr[sender.tag];
                        NSLog(@"%@",model.dnumber);//订单号
                    }else {//确认按钮
                        
                        MyOrderInfoModel *model = self.waitPayModelArr[sender.tag-1000];
                        ChoosePayWayViewController *payWayVC = [[ChoosePayWayViewController alloc]init];
                        //治疗待支付
                        if ([model.prefer isEqual:[NSNull null]]) {// --------需要处理
                            model.prefer = @"0";
                        }
                        payWayVC.infoDic = @{@"dnumber":model.dnumber,@"body":model.ill,@"fee":model.pay_money,@"prefer":@"0",@"step":[NSString stringWithFormat:@"%ld",model.step],@"is_check":@"0",@"type":@"app"};
                        
                        [self.navigationController pushViewController:payWayVC animated:YES];
                        NSLog(@"%@",model.dnumber);//订单号
                    }

                }
                    break;
                case 13://待确认
                {
                    if (sender.tag<1000) {//取消按钮
                        MyOrderInfoModel *model = self.WaitSureModelArr[sender.tag];
                        NSLog(@"%@",model.dnumber);//订单号
                    }else {//确认按钮
                        MyOrderInfoModel *model = self.WaitSureModelArr[sender.tag-1000];
                        NSLog(@"%@",model.dnumber);//订单号
                    }

                }
                    break;
                case 14://待评价
                {
                    if (sender.tag<1000) {//取消按钮
                        MyOrderInfoModel *model = self.waitEvaluateModelArr[sender.tag];
                        NSLog(@"%@",model.dnumber);//订单号
                    }else {//确认按钮
                        MyOrderInfoModel *model = self.waitEvaluateModelArr[sender.tag-1000];
                        NSLog(@"%@",model.dnumber);//订单号
                    }

                }
                    break;
                    
                default:
                    break;
            }
        }
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (tableView.tag) {
        case 10:
        {
            MyOrderInfoModel *model = self.modelArr[indexPath.row];
            self.orderView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, model.baseViewHeight+10);
            return model.baseViewHeight+10;

        }
            break;
        case 11:
        {
            
            MyOrderInfoModel *model = self.waitDiagnoseModelArr[indexPath.row];
            self.orderView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, model.baseViewHeight+10);
            return model.baseViewHeight+10;

        }
            break;
        case 12:
        {
            MyOrderInfoModel *model = self.waitPayModelArr[indexPath.row];
            self.orderView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, model.baseViewHeight+10);
            return model.baseViewHeight+10;

        }
            break;
        case 13:
        {
            MyOrderInfoModel *model = self.WaitSureModelArr[indexPath.row];
            self.orderView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, model.baseViewHeight+10);
            return model.baseViewHeight+10;
        }
            break;
        case 14:
        {
            MyOrderInfoModel *model = self.waitEvaluateModelArr[indexPath.row];
            self.orderView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, model.baseViewHeight+10);
            return model.baseViewHeight+10;
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}

//全部订单
- (void)requestMyOrderList {
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    
    NSLog(@"%@----",name);
    
    NSString *url = @"http://www.enuo120.com/index.php/app/patient/order";
    NSDictionary *dic = @{@"username":name,@"statue":@"0"};
    [self.request POST:url params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (![responseObject[@"data"] isEqual:[NSNull null]]) {
            [self dataOfResponseObject:responseObject];
        }else {
            NSLog(@"没有订单");
        }
        
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)dataOfResponseObject:(id)data {
    NSArray *dataArr = data[@"data"];
    
    for (int i = 0; i<dataArr.count; i++) {
        MyOrderInfoModel *model = [MyOrderInfoModel myOrderModelInitWithDic:dataArr[i]];
        
        [self.modelArr addObject:model];                       //全部
        if (model.type_id == 1 || model.type_id == 1.2) {      //等待就诊
            [self.waitDiagnoseModelArr addObject:model];
        }else if (model.type_id == 3 || model.type_id == 1.1) {//待支付
            [self.waitPayModelArr addObject:model];
        }else if (model.type_id == 4 || model.type_id == 1.3) {//待确认
            [self.WaitSureModelArr addObject:model];
        }else if (model.type_id == 5 || model.type_id == 5.1) {//待评价
            [self.waitEvaluateModelArr addObject:model];
        }
        
        
        for (int i = 0; i<5; i++) {
            UITableView *tableView = self.tableViewArr[i];
            [tableView reloadData];
        }
        
        
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
