//
//  DoctorViewController.m
//  enuoS
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DoctorViewController.h"

#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "DocOrderViewController.h"
#import <UIImageView+WebCache.h>
#import "Macros.h"
#import "UIImageView+UIImageView_FaceAwareFill.h"
#import "DocModel.h"
#import <Masonry.h>
#import "HosDocEvaViewController.h"
#import "UIColor+Extend.h"
@interface DoctorViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic,copy)NSString *levePj;
@property (nonatomic,copy)NSString *servierPj;
@property (nonatomic,strong)NSArray *contentarr;
@property (nonatomic,copy)NSString *plNum;
@property (nonatomic,copy)NSString *hosId;
@property (nonatomic,copy)NSString *docId;


@property (nonatomic,strong)UIPageControl *pageControl;

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;


@property (nonatomic,strong)UIView *headerView;
@property (nonatomic,strong)UIImageView *headerImage;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *leveLabel;
@property (nonatomic,strong)UILabel *deskLabel;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UILabel *nuoLabel;
@property (nonatomic,strong)UILabel *commentLable;

@property (nonatomic,strong)NSArray *markArray;
@property (nonatomic,strong)NSMutableArray *markOneArray;
@property (nonatomic,strong)NSMutableArray *markTwoArray;
@property (nonatomic,strong)UILabel *oneLabel;
@property (nonatomic,strong)UILabel *twoLabel;


@property (nonatomic,strong)NSMutableArray *weekListArray;
@property (nonatomic,strong)NSMutableArray *dayListArray;

@property (nonatomic,copy)NSString *oneStr;
@property (nonatomic,copy)NSString *twoStr;
@property (nonatomic,copy)NSString *threeStr;


@property (nonatomic,assign)BOOL oneS;

@property (nonatomic,assign)BOOL twoS;
@property (nonatomic,assign)BOOL threeS;




@end



UIButton *attentionBtn;

@implementation DoctorViewController

- (NSMutableArray *)weekListArray {
    if (!_weekListArray) {
        _weekListArray = [NSMutableArray array];
    }return _weekListArray;
}

- (NSMutableArray *)dayListArray {
    if (!_dayListArray) {
        _dayListArray = [NSMutableArray array];
    }return _dayListArray;
}


- (NSArray *)contentarr{
    if (!_contentarr) {
        _contentarr = [NSArray array];
    }return _contentarr;
}


- (NSMutableArray *)markOneArray{
    if (!_markOneArray) {
        _markOneArray  = [NSMutableArray array];
    }return _markOneArray;
}
- (NSMutableArray *)markTwoArray{
    if (!_markTwoArray) {
        _markTwoArray = [NSMutableArray array];
    }return _markTwoArray;
}
- (UILabel *)oneLabel{
    if (!_oneLabel) {
        _oneLabel = [[UILabel alloc]init];
    }return _oneLabel;
}

- (UILabel *)twoLabel{
    if (!_twoLabel) {
        _twoLabel = [[UILabel alloc]init];
    }return _twoLabel;
}

- (NSArray *)markArray{
    if (!_markArray) {
        _markArray = [NSArray array];
    }return _markArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
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
    
    self.oneS = YES;
    self.twoS = YES;
    self.threeS = YES;
    self.oneStr =@"1";
    self.twoStr = @"1";
    self.threeStr = @"1";
    
    [SVProgressHUD show];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaults objectForKey:@"name"];
    NSLog(@"name = %@",name);
    
//    self.navigationController.navigationBar.translucent = NO;
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLable.text  = @"医生主页";
    [titleLable setTextColor:[UIColor stringTOColor:@"#00b09f"]];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    titleLable.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLable;

    
    self.navigationController.toolbarHidden=NO;
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    [self creatHeadView];
    [self creattableView];
    [self creatToolBar];
    [self requestData];
    
    NSLog(@"self.receiver = %@",self.receiver);
}
- (void)handleWithBack:(UIBarButtonItem *)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)creatWorkHeaderView{
    
    UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
    tableHeaderView.backgroundColor = [UIColor stringTOColor:@"#fff4de"];
    self.tableView.tableHeaderView = tableHeaderView;
    

    //创建pageControl
    self.pageControl = [[UIPageControl alloc]init];
    [tableHeaderView addSubview:self.pageControl];
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tableHeaderView.mas_bottom);
        make.centerX.equalTo(tableHeaderView.mas_centerX);
    }];
    
    
    //创建scrollview
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 151)];
    scrollView.contentSize = CGSizeMake(kScreenWidth*3, 0);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    [tableHeaderView addSubview:scrollView];
    
    
    UILabel *docMarkLabel = [[UILabel alloc]init];
    docMarkLabel.text = @"医生值班作息表";
    docMarkLabel.font = [UIFont systemFontOfSize:13];
    [tableHeaderView addSubview:docMarkLabel];
    [docMarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(tableHeaderView.mas_centerX);
        make.top.equalTo(tableHeaderView.mas_top).with.offset(15);
    }];
    

    //创建3个时间表的bgview
    for (int j = 0; j<3; j++) {
        
        NSArray *weekArray = self.weekListArray[j];
        NSArray *dayArray = self.dayListArray[j];
   
        //时间表所在的View（这名字起的，我服）
        UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(10+kScreenWidth*j,38, kScreenWidth-20, 120)];
        [scrollView addSubview:aView];

    
    for (int i = 0; i<8; i++) {
        UILabel *weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(aView.frame.size.width/8 *i, 0, aView.frame.size.width/8, 40)];
        weekLabel.numberOfLines = 2;
        if (i == 0) {
            weekLabel.text = @"排班";
        }else {
            weekLabel.text = [NSString stringWithFormat:@"%@\n%@",weekArray[i-1],dayArray[i-1]];
        }
        weekLabel.layer.borderColor = [UIColor blackColor].CGColor;
        weekLabel.layer.borderWidth = 1.0;
        weekLabel.font = [UIFont systemFontOfSize:13.0];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        [aView addSubview:weekLabel];
    
    }
    
    UILabel *amLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, aView.frame.size.width/8, 30)];
    amLabel.text = @"上午";
    UILabel *pmLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, aView.frame.size.width/8, 30)];
    pmLabel.text = @"下午";
    amLabel.font = [UIFont systemFontOfSize:13.0];
    amLabel.textAlignment = NSTextAlignmentCenter;
    
    amLabel.layer.borderWidth = 1.0;
    amLabel.layer.borderColor = [[UIColor blackColor]CGColor];
    pmLabel.layer.borderColor = [UIColor blackColor].CGColor;
    pmLabel.layer.borderWidth = 1.0;
    
    pmLabel.font = [UIFont systemFontOfSize:13.0];
    pmLabel.textAlignment = NSTextAlignmentCenter;
    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleWithTapG:)];
//    tapGesture.numberOfTouchesRequired = 1;
//    
//    //  1）设置轻拍次数  单击  双击  三连击。。。。。
//    tapGesture.numberOfTapsRequired = 1;//单击
//    [aView addGestureRecognizer:tapGesture];
    
    [aView addSubview:amLabel];
    [aView addSubview:pmLabel];
    for (int i = 1; i<8; i ++) {
       
        }
        
    for (int i = 0; i<7; i++) {
        
        self.oneLabel = [[UILabel alloc]initWithFrame: CGRectMake(aView.frame.size.width/8 *(i+1), 40, aView.frame.size.width/8, 30)];
        
        self.twoLabel = [[UILabel alloc]initWithFrame: CGRectMake(aView.frame.size.width/8*(i+1), 70, aView.frame.size.width/8, 30)];
        
        self.oneLabel.layer.borderWidth = 1.0;
        self.oneLabel.layer.borderColor = [UIColor blackColor].CGColor;
        
        self.twoLabel.layer.borderColor = [UIColor blackColor].CGColor;
        self.twoLabel.layer.borderWidth = 1.0;
        self.oneLabel.font = [UIFont systemFontOfSize:13.0];
        self.oneLabel.textAlignment = NSTextAlignmentCenter;
        self.twoLabel.font = [UIFont systemFontOfSize:13.0];
        self.twoLabel.textAlignment = NSTextAlignmentCenter;
        
        NSArray *weekAMArray = self.markOneArray[j];
        if ([[weekAMArray[i] objectForKey:@"num"] integerValue]==1) {
//            self.oneLabel.backgroundColor =[UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
            self.oneLabel.textColor = [UIColor blackColor];
            self.oneLabel.text = @"出诊";
            

        }
        NSArray *weekPMArray = self.markTwoArray[j];
        if ([[weekPMArray[i] objectForKey:@"num"] integerValue]==1) {
//            self.twoLabel.backgroundColor =[UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
            self.twoLabel.textColor = [UIColor blackColor];
            self.twoLabel.text = @"出诊";
        }

        [aView addSubview:self.oneLabel];
        [aView addSubview:self.twoLabel];
        
    }}
    

    
}

// scrollview的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x/kScreenWidth;
    
}

//  时间表
- (void)handleWithTapG:(UITapGestureRecognizer *)sender{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    if (name !=nil) {
        DocModel *model = self.dataArray[0];
        
        DocOrderViewController *docVC = [[DocOrderViewController alloc]init];
        
        UINavigationController *naNC  = [[UINavigationController alloc]initWithRootViewController:docVC];
//        docVC.didReceiver = model.cid;
        [self presentViewController:naNC animated:YES completion:^{
            
        }];
    }else{
        
        
//        //[self.dataArray addObject:model];
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录账号" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
//            [alert show];
//        }else{
//            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登录账号" preferredStyle:UIAlertControllerStyleAlert];
//            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                
//            }]];
//            [self presentViewController:alertView animated:YES completion:^{
//                
//            }];
//            
//        }
        NSLog(@"qunimade ");
        
        
    }

}


//头部
- (void)creatHeadView{
    
    UIView *headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 65, kScreenWidth, 73);
    [self.view addSubview:headerView];
    
    self.headerImage = [[UIImageView alloc]init];
    self.nameLabel = [[UILabel alloc]init];
    self.leveLabel = [[UILabel alloc]init];
    self.deskLabel = [[UILabel alloc]init];
    self.nuoLabel = [[UILabel alloc]init];
    self.addressLabel = [[UILabel alloc]init];
    self.commentLable = [[UILabel alloc]init];
    
    UIImageView *nuoImage = [[UIImageView alloc]init];//诺
    UIImageView *commentImage = [[UIImageView alloc]init];//评论
    UIImageView *attentionImage = [[UIImageView alloc]init];//关注
    _headerImage.layer.borderColor = [UIColor grayColor].CGColor;
    headerView.backgroundColor = [UIColor whiteColor];
    _headerImage.layer.borderWidth = 0.5;
    _headerImage.layer.cornerRadius = 26.0;
    
    _headerImage.clipsToBounds = YES;

    [headerView addSubview:nuoImage];
    [headerView addSubview:commentImage];
    [headerView addSubview:attentionImage];
    [headerView addSubview:self.headerImage];//头像
    [headerView addSubview:self.nameLabel];//名字
    [headerView addSubview:self.leveLabel];//主任医师
    [headerView addSubview:self.deskLabel];//科室
    [headerView addSubview:self.nuoLabel];//诺
    [headerView addSubview:self.addressLabel];//地址
    [headerView addSubview:self.commentLable];//评论
    self.nameLabel.font = [UIFont systemFontOfSize:13];
    self.leveLabel.font =[UIFont systemFontOfSize:10];
    self.deskLabel.font = [UIFont systemFontOfSize:10];
    self.nuoLabel.font = [UIFont systemFontOfSize:10];
    self.addressLabel.font = [UIFont systemFontOfSize:10];
    self.commentLable.font = [UIFont systemFontOfSize:9];
    self.leveLabel.textColor = [UIColor stringTOColor:@"#666666"];
    self.deskLabel.textColor = [UIColor stringTOColor:@"#666666"];
    self.addressLabel.textColor = [UIColor stringTOColor:@"#666666"];


    nuoImage.image = [UIImage imageNamed:@"点诺"];
    commentImage.image = [UIImage imageNamed:@"形状-1-拷贝"];
    attentionImage.image = [UIImage imageNamed:@"关注"];

    headerView.layer.borderWidth = 1.0;
    headerView.layer.borderColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0].CGColor;
    __weak typeof(self)  weakSelf = self;
    
    
    [weakSelf.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_top).with.offset(10);
        make.left.equalTo (headerView.mas_left).with.offset(20);
        make.bottom.equalTo(headerView.mas_bottom).with.offset(-10);
        make.width.mas_equalTo(@53);
        
    }];
    
    [weakSelf.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerImage.mas_right).with.offset(10);
        make.top.equalTo(headerView.mas_top).with.offset(20);
        
    }];
    
    [weakSelf.deskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLabel.mas_right).with.offset(10);
        make.bottom.equalTo(weakSelf.nameLabel.mas_bottom).with.offset(0);
        
    }];
    
    
    [weakSelf.leveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerImage.mas_right).with.offset(10);
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).with.offset(14);
        
    }];
    
    [weakSelf.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leveLabel.mas_right).with.offset(10);
        make.bottom.equalTo(weakSelf.leveLabel.mas_bottom);
        
    }];
    
    
    [attentionImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(headerView.mas_top).with.offset(12);
        make.right.equalTo(headerView.mas_right).with.offset(-19);
        make.size.mas_equalTo(CGSizeMake(20, 16));
        
    }];
    
    
    [commentImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(attentionImage.mas_centerY);
        make.right.equalTo(attentionImage.mas_left).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(19, 17));
        
    }];
    
    [_commentLable mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(commentImage.mas_left).with.offset(13);
        make.top.equalTo(commentImage.mas_top).with.offset(-2);
        make.size.mas_equalTo(CGSizeMake(20, 10));
        
    }];
    
    
    
    
    [nuoImage mas_makeConstraints:^(MASConstraintMaker *make) {
    
//        make.left.equalTo(weakSelf.leveLabel.mas_right).with.offset(5);
        make.centerY.equalTo(commentImage.mas_centerY);
        make.right.equalTo(commentImage.mas_left).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(19, 19));
        
        
    }];
    [weakSelf.nuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(nuoImage.mas_right).with.offset(2);
        make.top.equalTo(nuoImage.mas_top);
        make.width.mas_equalTo(@15);
        make.height.mas_equalTo(@15);
        
        
        
    }];
    
}

- (void)creattableView{
    self.tableView.frame = CGRectMake(0, 138, kScreenWidth, kScreenHeigth-44-138);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"self.onestr = %@",self.oneStr);
    if (section == 0){
        //self.oneS = NO;
        if ([self.oneStr isEqualToString:@"1"]) {
            return 1;
        }else{
            return 0;
        }
    }else if (section == 1){
        // self.twoS = NO;
        if ([self.twoStr isEqualToString:@"1"]) {
            return 1;
        }else{
            return 0;
        }
    }else{
         //self.twoS = NO;
        if ([self.threeStr isEqualToString:@"1"]) {
            return 1;
        }else{
            return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor stringTOColor:@"#fff4de"];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    cell.textLabel.numberOfLines = 0;
    
    if (self.dataArray.count != 0) {
        DocModel *model = self.dataArray[0];
        
        
        if (indexPath.section == 0) {
            cell.textLabel.text = model.ill;
        }else if(indexPath.section==1){
            cell.textLabel.text = model.treatment;
        }else{
            cell.textLabel.text = model.introduce;
        }

    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataArray.count !=0) {
        DocModel *model = self.dataArray[0];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        CGRect rectOne = [model.ill boundingRectWithSize:CGSizeMake(kScreenWidth, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        CGRect rectTwo = [model.treatment boundingRectWithSize:CGSizeMake(kScreenWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        CGRect rectThree = [model.introduce boundingRectWithSize:CGSizeMake(kScreenWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        
        
        
        if (indexPath.section == 0) {
            return rectOne.size.height+20;
        }else if (indexPath.section == 1){
            return rectTwo.size.height+20;
            
        }else{
            return rectThree.size.height+20;
        }

    }else{
        return 0;
    }
  }


//   擅长领域/约定病种/医生简介
- (UIView*)creatadeptWith:(NSString *)image
                    title:(NSString *)title{
    
    UIView *aview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    aview.backgroundColor = [UIColor whiteColor];
    UIImageView *amage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 20, 20)];
    amage.image = [UIImage imageNamed:image];
    [aview addSubview:amage];
    
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor stringTOColor:@"#00b09f"];
    label.font = [UIFont systemFontOfSize:15];
    label.text = title;
    [aview addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(amage.mas_centerY);
        make.left.equalTo(amage.mas_right).with.offset(2);
    }];
    
    return aview;
    
}

- (void)handleadeptSecrion:(UIButton *)sender{
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    self.tableView
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:0];
    
    
    if(self.oneS == YES){
        //记得昨晚操作之后，改变按钮的点击状态
        self.oneStr = @"2";
 
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
        //self.registerButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
        //  self.markStr = @"2";
        self.oneS =NO;
    }else{
        self.oneStr = @"1";
         [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
        
        // self.imageAcc.image = [UIImage imageNamed:@"check"];
        //self.markStr = @"1";
        
        self.oneS = YES;
    }

    
    
    
}




- (void)handleSynSecrion:(UIButton *)sender{
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
    
    
    if(self.twoS ==YES){
        //记得昨晚操作之后，改变按钮的点击状态
        self.twoStr = @"2";
        
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
        //self.registerButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
        //  self.markStr = @"2";
        self.twoS = NO;
    }else{
        self.twoStr = @"1";
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
        
        // self.imageAcc.image = [UIImage imageNamed:@"check"];
        //self.markStr = @"1";
        
        self.twoS = YES;
    }

}

- (void)handleillSecrion:(UIButton *)sender{
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:2];
    
    
    if(self.threeS == YES){
        //记得昨晚操作之后，改变按钮的点击状态
        self.threeStr = @"2";
        
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
        //self.registerButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
        //  self.markStr = @"2";
        self.threeS = NO;
    }else{
        self.threeStr = @"1";
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade
         ];
        
        // self.imageAcc.image = [UIImage imageNamed:@"check"];
        //self.markStr = @"1";
        self.threeS = YES;
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
       return  [self creatadeptWith:@"约定病种" title:@"约定病种"];
    }else if(section == 1){
        return [self creatadeptWith:@"擅长领域" title:@"擅长领域"];
    }else {
        return [self creatadeptWith:@"医生简介" title:@"医生简介"];
    }
    
    
}
- (void)requestData{
    NSString *str = @"http://www.enuo120.com/index.php/app/doctor/home";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefault objectForKey:@"name"];
    if (username ==NULL) {
        username = @"";
    }
    NSLog(@"name = %@",username);
      NSDictionary *heardBody = @{@"username":username,@"did":self.receiver,@"ver":@"1.0"};
    
    AFHTTPSessionManager *manegr = [AFHTTPSessionManager manager];
    
    [manegr POST:str parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           NSLog(@"responseObject = %@",responseObject);
        [SVProgressHUD dismiss];
        [self handleWithData:responseObject];
   
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
    
    
    
    
    
    
    
    
}
- (void)handleWithData:(NSDictionary *)dic{
 
    
    
    DocModel *model = [DocModel docModelInitWithData:dic[@"data"]];
    NSString * url = [NSString stringWithFormat:urlPicture,model.photo];
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    [self.headerImage faceAwareFill];
    self.nameLabel.text = model.name;
    self.leveLabel.text = model.professional;//主治医师
    self.deskLabel.text = model.dep_name;//科室
    self.addressLabel.text = model.hos_name;//医院名字
    self.nuoLabel.text =  model.nuo;
    self.hosId = model.hos_id;
    self.docId = model.cid;
    self.commentLable.text = [NSString stringWithFormat:@"%ld",model.comment];
    
    NSDictionary *dataDic = dic[@"data"];
    NSDictionary *listDic = dataDic[@"schedule_list"];
    
    
    NSDictionary *oneWeekListDic = listDic[@"now_list"];
    NSDictionary *twoWeekListDic = listDic[@"one_week_list"];
    NSDictionary *threeWeekListDic = listDic[@"two_week_list"];
    
    
    NSArray *oneAmArray = oneWeekListDic[@"am_list"];
    NSArray *onePmArray = oneWeekListDic[@"pm_list"];
    NSArray *oneWeekListArr  = oneWeekListDic[@"week_list"];
    NSArray *oneDayListArr  = oneWeekListDic[@"day_list"];

    
    NSArray *twoAmArray = twoWeekListDic[@"am_list"];
    NSArray *twoPmArray = twoWeekListDic[@"pm_list"];
    NSArray *twoWeekListArr  = twoWeekListDic[@"week_list"];
    NSArray *twoDayListArr  = twoWeekListDic[@"day_list"];

    NSArray *threeAmArray = threeWeekListDic[@"am_list"];
    NSArray *threePmArray = threeWeekListDic[@"pm_list"];
    NSArray *threeWeekListArr  = threeWeekListDic[@"week_list"];
    NSArray *threeDayListArr  = threeWeekListDic[@"day_list"];
    
    //把三周的坐诊状态和日期放到数组里（上午的放在markOneArray，下午的放在markTwoArray）
    [self.markOneArray addObject:oneAmArray];
    [self.markOneArray addObject:twoAmArray];
    [self.markOneArray addObject:threeAmArray];
    
    [self.markTwoArray addObject:onePmArray];
    [self.markTwoArray addObject:twoPmArray];
    [self.markTwoArray addObject:threePmArray];
    
    //三周的星期数放在数组里
    [self.weekListArray addObject:oneWeekListArr];
    [self.weekListArray addObject:twoWeekListArr];
    [self.weekListArray addObject:threeWeekListArr];
    
    //三周的日期放在数组里
    [self.dayListArray addObject:oneDayListArr];
    [self.dayListArray addObject:twoDayListArr];
    [self.dayListArray addObject:threeDayListArr];
    
    
//    self.markArray = [dic[@"data"] objectForKey:@"schedule_list"];
//    for (int i = 0; i<14; i= i+2) {
//        [self.markOneArray addObject:self.markArray[i]];
//        [self.markTwoArray addObject:self.markArray[i+1]];
//    }
    
    
    if (model.guanzhu == 0) {
        attentionBtn.selected = NO;
        [attentionBtn setImage:[UIImage imageNamed:@"关注-(1)"] forState:UIControlStateNormal];
    }else{
        attentionBtn.selected = YES;
        
        [attentionBtn setImage:[UIImage imageNamed:@"红色关注"] forState:UIControlStateNormal];
    }
    
    
    
    
    [self creatWorkHeaderView];
    [self.dataArray addObject:model];
    
    [self.tableView reloadData];
    
    
    
    
}


- (void)creatToolBar{
    UIView *toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *consultBtn = [UIButton buttonWithType:UIButtonTypeCustom];//咨询
    UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];//预约
   
    consultBtn.backgroundColor = [UIColor colorWithRed:253/255.0 green:171/255.0 blue:0/255.0 alpha:1];
    orderBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:142/255.0 blue:0/255.0 alpha:1];
    commentBtn.frame = CGRectMake(0, 0, kScreenWidth/6, 64);
    attentionBtn.frame = CGRectMake(kScreenWidth/6, 0, kScreenWidth/6, 64);
    consultBtn.frame = CGRectMake(0, 0, kScreenWidth/2, 44);
    orderBtn.frame = CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, 44);
    [self setOneBtn:commentBtn title:@"评论" image:@"评论"];
    [self setOneBtn:attentionBtn title:@"关注" image:@""];
    [self setTwoBtn:consultBtn title:@"咨询" image:@"qq"];
    [self setTwoBtn:orderBtn title:@"预约" image:@"预约"];

    [commentBtn addTarget:self action:@selector(handleWithComment:) forControlEvents:UIControlEventTouchUpInside];
    [attentionBtn addTarget:self action:@selector(handleWithAttention:) forControlEvents:UIControlEventTouchUpInside];
    [consultBtn addTarget:self action:@selector(handleWithConsultBtn:) forControlEvents:UIControlEventTouchUpInside];
    [orderBtn addTarget:self action:@selector(handleWithOrder:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    [toolView addSubview:commentBtn];
//    [toolView addSubview:attentionBtn];
    [toolView addSubview:consultBtn];
    [toolView addSubview:orderBtn];
    
    [self.navigationController.toolbar addSubview:toolView];
    
}

- (void)setOneBtn:(UIButton *)sender title:(NSString *)title image:(NSString *)image{
    [sender setTitle:title forState:UIControlStateNormal];
    [sender setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
     sender.imageEdgeInsets = UIEdgeInsetsMake(5,20,40,0);//上  左 下 右
      sender.titleEdgeInsets = UIEdgeInsetsMake(-20, -10, -20, 0);
    sender.titleLabel.font = [UIFont systemFontOfSize:13];
    [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

- (void)setTwoBtn:(UIButton *)sender title:(NSString *)title image:(NSString *)image{
    [sender setTitle:title forState:UIControlStateNormal];
    [sender setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    sender.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);//上  左 下 右
      sender.titleLabel.font = [UIFont systemFontOfSize:15];
}

//评论按钮
- (void)handleWithComment:(UIButton*)sender{
    HosDocEvaViewController *hosVC = [[HosDocEvaViewController alloc]init];
    UINavigationController *NaVC = [[UINavigationController alloc]initWithRootViewController:hosVC];
    hosVC.markStr = @"2";
    hosVC.pjArr = [NSArray array];
    hosVC.pjArr = self.contentarr;
    hosVC.leve = self.levePj;
    hosVC.service = self.servierPj;
    [self presentViewController:NaVC animated:YES completion:^{
        
    }];
}

//关注按钮
- (void)handleWithAttention:(UIButton *)sender{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    if (name != nil) {
        
        if(sender.isSelected == NO){
            //记得昨晚操作之后，改变按钮的点击状态
            [self requestDataGz];
        }else{
            
     
            // self.imageAcc.image = [UIImage imageNamed:@"check"];
            //self.markStr = @"1";
            
            [self requestDataGz];
        }
        
        
    }else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录账号" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登录账号" preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
            
        }

    }
}


- (void)requestDataGz{
    NSString *url = @"http://www.enuo120.com/index.php/app/patient/guanzhu";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
   
    AFHTTPSessionManager *mager  = [AFHTTPSessionManager manager];
    NSString *a = [[NSString alloc]init];
    if (attentionBtn.selected ==NO) {
        a = @"1";
    }else{
        a = @"0";
    }
    NSDictionary *heardBody = @{@"username":name,@"did":self.receiver,@"type":a};

[mager POST:url parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
    
} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    [self handelWithGuanZhuData:responseObject];
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
}];
    
}

- (void)handelWithGuanZhuData:(NSDictionary *)dic{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:dic[@"data"][@"message"] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
    }else{
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"data"][@"message"] preferredStyle:UIAlertControllerStyleAlert];
        [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertView animated:YES completion:^{
            
        }];
        
    }
    
    if ([dic[@"data"][@"message"] isEqualToString:@"医生关注成功"]) {
        [attentionBtn setImage:[UIImage imageNamed:@"红色关注"] forState:UIControlStateNormal];
        attentionBtn.selected =YES;
    }else if([dic[@"data"][@"message"] isEqualToString:@"医生取消关注成功"]){
        [attentionBtn setImage:[UIImage imageNamed:@"关注-(1)"] forState:UIControlStateNormal];
        attentionBtn.selected = NO;
    }else{
        NSLog(@"lalalallalallallalal");
    }
    
}




//咨询按钮
- (void)handleWithConsultBtn:(UIButton *)sender{
    
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSString *name = [userDefault objectForKey:@"name"];
//    if (name !=nil) {
//        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
//        NSURL *url = [NSURL URLWithString:@"mqq://im/chat?chat_type=wpa&uin=2086217461&version=1&src_type=web"];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        webView.delegate = self;
//        [webView loadRequest:request];
//        [self.view addSubview:webView];
//        
//    }else{
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录账号" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
//            [alert show];
//        }else{
//            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登录账号" preferredStyle:UIAlertControllerStyleAlert];
//            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                
//            }]];
//            [self presentViewController:alertView animated:YES completion:^{
//                
//            }];
//            
//        }
//        
//    }

}
//预约按钮
- (void)handleWithOrder:(UIButton *)sender{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    if (name !=nil) {
//        DocModel *model = self.dataArray[0];
        
        NSLog(@"hos_id == %@",self.hosId);
        
        DocOrderViewController *docVC = [[DocOrderViewController alloc]init];
        docVC.hosId = self.hosId;
        docVC.hosName = self.addressLabel.text;
        docVC.docId = self.docId;
        docVC.docName = self.nameLabel.text;
        docVC.weekListArray = self.weekListArray;
        docVC.dayListArray = self.dayListArray;
        docVC.markOneArray = self.markOneArray;
        docVC.markTwoArray = self.markTwoArray;
        docVC.view.backgroundColor = [UIColor whiteColor];
        UINavigationController *naNC  = [[UINavigationController alloc]initWithRootViewController:docVC];
//        docVC.didReceiver = model.cid;
        [self presentViewController:naNC animated:YES completion:^{
            
        }];
    }else{

        
         //[self.dataArray addObject:model];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录账号" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登录账号" preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
            
        }
        
        
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
