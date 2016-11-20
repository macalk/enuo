//
//  DocOrderViewController.m
//  enuoS
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DocOrderViewController.h"
#import "Macros.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "illListModel.h"
#import "DocOrderModel.h"
#import "IllListDetailModel.h"
#import "LrdAlertTabeleView.h"
#import "UIColor+Extend.h"

#import "BaseRequest.h"

#import <Masonry.h>

//使用第三方点击lable展开列表
#import "MLMOptionSelectView.h"
#import "UIView+Category.h"
#import "CustomCell.h"

typedef NS_ENUM(NSUInteger, TTGState) {
    TTGStateOK = 0,
    TTGStateError = 1,
    TTGStateUnknow = 2,
};

@interface DocOrderViewController ()<UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource,LrdAlertTableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic,strong)BaseRequest *request;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *illDataArray;
@property (nonatomic,strong)NSMutableArray *illDetailArray;
@property (nonatomic,strong)NSMutableArray *categoryArray;

@property (nonatomic,strong)NSMutableArray *deskDataArray;
@property (nonatomic,strong)NSMutableArray *depIdDataArray;
@property (nonatomic,strong)NSMutableArray *sunDeskDataArray;
@property (nonatomic,strong)NSMutableArray *sunDeskIdArray;
@property (nonatomic,strong)NSMutableArray *treatArray;



@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,assign)NSInteger *rrr;

@property (nonatomic,strong)UILabel *hosTextlabel;
@property (nonatomic,strong)UILabel *nameTextlabel;
@property (nonatomic,strong)UILabel *deskTextLabel;
@property (nonatomic,strong)UILabel *deskSunTextLabel;
@property (nonatomic,strong)UILabel *illTextLabel;
@property (nonatomic,strong)UILabel *typeTextLabel;
@property (nonatomic,strong)UILabel *styleTextLabel;

@property (nonatomic,strong)UIButton *illBtn;
@property (nonatomic,strong)UILabel *priceTextLabel;
@property (nonatomic,strong)UILabel *cycleTextLabel;

@property (nonatomic,strong)UILabel *effectTextLabel;

@property (nonatomic,strong)NSDictionary *nsDic;

@property (nonatomic,assign)NSInteger sss;//判断哪周
@property (nonatomic,strong)UILabel *docMarkLabel;
@property (nonatomic,strong)UIView *bView;


@property (nonatomic,copy)NSString *timeStr;
@property (nonatomic,copy)NSString *currentDepId;
@property (nonatomic,copy)NSString *currentSelectDate;


@property (nonatomic,assign)NSInteger headerHeight;

@property (nonatomic,strong)UIButton *oneBtn;
@property (nonatomic,strong)UIButton *twoBtn;
@property (nonatomic,strong)UIButton *selectBtn;

@property (nonatomic,strong)UIPageControl *pageControl;

@property (nonatomic,strong)NSMutableArray *oneWeekSelectArr;
@property (nonatomic,strong)NSMutableArray *twoWeekSelectArr;
@property (nonatomic,strong)NSMutableArray *threeWeekSelectArr;

//使用第三方点击lable展开列表
@property (nonatomic, strong) MLMOptionSelectView *cellView;


@end

@implementation DocOrderViewController

//- (UIButton *)oneLabel{
//    
//    if (!_oneBtn) {
//        self.oneBtn = [[UIButton alloc]init];
//    }return _oneBtn;
//}
//
//- (UIButton *)twoLabel{
//    if (!_twoBtn) {
//        self.twoBtn = [[UIButton alloc]init];
//    }return _twoBtn;
//}
//

- (NSMutableArray *)treatArray {
    if (!_treatArray) {
        _treatArray = [NSMutableArray array];
    }return _treatArray;
}

- (NSMutableArray *)categoryArray {
    if (!_categoryArray) {
        _categoryArray = [NSMutableArray array];
    }return _categoryArray;
}

- (NSMutableArray *)oneWeekSelectArr {
    if (!_oneWeekSelectArr) {
        _oneWeekSelectArr = [[NSMutableArray alloc]init];
    }return _oneWeekSelectArr;
}

- (NSMutableArray *)twoWeekSelectArr {
    if (!_twoWeekSelectArr) {
        _twoWeekSelectArr = [[NSMutableArray alloc]init];
    }return _twoWeekSelectArr;
}

- (NSMutableArray *)threeWeekSelectArr {
    if (!_threeWeekSelectArr) {
        _threeWeekSelectArr = [[NSMutableArray alloc]init];
    }return _threeWeekSelectArr;
}


- (NSMutableArray *)deskDataArray {
    if (!_deskDataArray) {
        _deskDataArray = [NSMutableArray array];
    }return _deskDataArray;
}

- (NSMutableArray *)depIdDataArray {
    if (!_depIdDataArray) {
        _depIdDataArray = [NSMutableArray array];
    }return _depIdDataArray;
}

- (NSMutableArray *)sunDeskDataArray {
    if (!_sunDeskDataArray) {
        _sunDeskDataArray = [NSMutableArray array];
    }return _sunDeskDataArray;
}

- (NSMutableArray *)sunDeskIdArray {
    if (!_sunDeskIdArray) {
        _sunDeskIdArray = [NSMutableArray array];
    }return _sunDeskIdArray;
}

- (NSDictionary *)nsDic{
    if (!_nsDic) {
        self.nsDic = [NSDictionary dictionary];
    }return _nsDic;
}


- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]init];
    }return _tableView;
}


- (UIView *)bView{
    if (!_bView) {
        self.bView = [[UIView alloc]init];
        
    }return _bView;
}


- (UILabel *)hosTextlabel{
    if (!_hosTextlabel) {
        self.hosTextlabel = [[UILabel alloc]init];
        
    }return _hosTextlabel;
}

- (UILabel *)nameTextlabel{
    if (!_nameTextlabel) {
        self.nameTextlabel = [[UILabel alloc]init];
        
    }return _nameTextlabel;
}

- (UILabel *)deskTextLabel {
    if (!_deskTextLabel) {
        _deskTextLabel = [[UILabel alloc]init];
    }return _deskTextLabel;
}

- (UILabel *)deskSunTextLabel {
    if (!_deskSunTextLabel) {
        _deskSunTextLabel = [[UILabel alloc]init];
    }return _deskSunTextLabel;
}

- (UILabel *)illTextLabel {
    if (!_illTextLabel) {
        _illTextLabel = [[UILabel alloc]init];
    }return _illTextLabel;
}

- (UILabel *)typeTextLabel {
    if (!_typeTextLabel) {
        _typeTextLabel = [[UILabel alloc]init];
    }return _typeTextLabel;
}

- (UILabel *)styleTextLabel {
    if (!_styleTextLabel) {
        _styleTextLabel = [[UILabel alloc]init];
    }return _styleTextLabel;
}

- (UILabel *)priceTextLabel{
    if (!_priceTextLabel) {
        self.priceTextLabel = [[UILabel alloc]init];
    }return _priceTextLabel;
}


- (UILabel *)cycleTextLabel{
    if (!_cycleTextLabel) {
        self.cycleTextLabel = [[UILabel alloc]init];
    }return _cycleTextLabel;
}

- (UILabel *)effectTextLabel{
    if (!_effectTextLabel) {
        self.effectTextLabel = [[UILabel alloc]init];
    }return _effectTextLabel;
}

- (UIButton *)illBtn{
    if (!_illBtn) {
        self.illBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }return _illBtn;
}
- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }return _selectBtn;
}
- (NSMutableArray *)illDetailArray{
    if (!_illDetailArray) {
        self.illDetailArray = [NSMutableArray array];
    }return _illDetailArray;
}






- (NSMutableArray *)illDataArray{
    if (!_illDataArray) {
        self.illDataArray = [NSMutableArray array];
    }return _illDataArray;
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
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLable.text  = @"预约";
    [titleLable setTextColor:[UIColor stringTOColor:@"#00b09f"]];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    titleLable.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLable;
    
    for (int i = 0; i<14; i++) {
        [self.oneWeekSelectArr addObject:@"NO"];
        [self.twoWeekSelectArr addObject:@"NO"];
        [self.threeWeekSelectArr addObject:@"NO"];
    }
    
    self.request = [[BaseRequest alloc]init];
    [self requestDeskData];
    
    [self creatTopView];
    [self createBottomView];
    
    _cellView = [[MLMOptionSelectView alloc] initOptionView];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
//    self.navigationController.navigationBar.translucent = NO;
//    [self requestOrderData];
//   [self creatTabLeView];
    
//    [self creatbleView];
}

- (void)handleWithBack:(UIBarButtonItem *)dic{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//- (void)creatbleView{
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = NO;
//    self.tableView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.tableView];
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.centerY.equalTo(self.view.mas_centerY);
//        make.width.mas_offset(kScreenWidth/3*2);
//        make.height.mas_offset(kScreenHeigth/2);
//    }];
//    
//    
//    
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 10;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    return 60;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
//    headerLabel.text = @"请选择";
//    headerLabel.textAlignment = NSTextAlignmentCenter;
//    headerLabel.font = [UIFont systemFontOfSize:15];
//    
//    return headerLabel;
//    

//    if (section == 0) {
//         return nil;
//    }else if(section ==1){
//        return [self creatTimeView];
//    }else{
//        UIView *avIEW= [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
//        UIButton *Abutton =  [UIButton buttonWithType:UIButtonTypeCustom];
//        Abutton.titleLabel.font = [UIFont systemFontOfSize:16];
//        [Abutton setTitle:@"确认约定" forState:UIControlStateNormal];
//        Abutton.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
//        
//      [Abutton addTarget:self action:@selector(handleMakeSureWithBtn:) forControlEvents:UIControlEventTouchUpInside];
//        Abutton.layer.masksToBounds = YES;
//        Abutton.layer.cornerRadius = 6.0;
//        Abutton.frame = CGRectMake(kScreenWidth/3, 0, kScreenWidth/3, 30);
//        [avIEW addSubview:Abutton];
//        return avIEW;
//    }
   
//}


//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    switch (buttonIndex) {
//        case 0:
//            [self dismissViewControllerAnimated:YES completion:^{
//                
//            }];
//            break;
//            
//        default:
//            break;
//    }
//}
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//       [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
//
//    return cell;
//}


//第一个区头
- (void)creatTopView{
 
    UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 200)];
    [self.view addSubview:oneView];
    oneView.backgroundColor = [UIColor whiteColor];
    UILabel *hosLabel = [[UILabel alloc]init];//医院
    UILabel *docLabel = [[UILabel alloc]init];//医生
    UILabel *deskLabel = [[UILabel alloc]init];//科室
    UILabel *illLabel = [[UILabel alloc]init];//疾病
    UILabel *typeLabel = [[UILabel alloc]init];//种类
    UILabel *styleLabel = [[UILabel alloc]init];//方式
    
//    UILabel *priceLabel = [[UILabel alloc]init];//价格
//    UILabel *cycleLabel = [[UILabel alloc]init];//周期
//    UILabel *effectLabel = [[UILabel alloc]init];//效果
   
//    UIImageView *lowimage = [[UIImageView alloc]init];
//    lowimage.image =[UIImage imageNamed:@"下拉"];
    
    
    hosLabel.font = [UIFont systemFontOfSize:14];
    hosLabel.text = @"预约医院:";
    docLabel.font = [UIFont systemFontOfSize:14];
    docLabel.text = @"预约医生:";
    deskLabel.font = [UIFont systemFontOfSize:14];
    deskLabel.text = @"预约科室:";
    illLabel.font = [UIFont systemFontOfSize:14];
    illLabel.text = @"疾病:";
    typeLabel.font = [UIFont systemFontOfSize:14];
    typeLabel.text = @"种类:";
    styleLabel.font = [UIFont systemFontOfSize:14];
    styleLabel.text = @"方式:";
    
    
//    priceLabel.font = [UIFont systemFontOfSize:14];
//    priceLabel.text = @"约定价格:";
//    cycleLabel.text = @"约定周期:";
//    cycleLabel.font = [UIFont systemFontOfSize:14];
//    effectLabel.font = [UIFont systemFontOfSize:14];
//    effectLabel.text = @"约定疗效:";
    
    self.hosTextlabel.font = [UIFont systemFontOfSize:14];
    self.hosTextlabel.text = self.hosName;
    self.nameTextlabel.font = [UIFont systemFontOfSize:14];
    self.nameTextlabel.text = self.docName;

    self.deskTextLabel.font = [UIFont systemFontOfSize:14];
//    [self setLableBtn:self.deskTextLabel withDataArray:self.deskDataArray];
    self.deskTextLabel.text = @"选择科室";

    self.deskSunTextLabel.font = [UIFont systemFontOfSize:14];
//    [self setLableBtn:self.deskSunTextLabel withDataArray:self.sunDeskDataArray];
    self.deskSunTextLabel.text = @"选择子科室";

    self.illTextLabel.font = [UIFont systemFontOfSize:14];
//    [self setLableBtn:self.illTextLabel withDataArray:self.illDataArray];
    self.illTextLabel.text = @"选择疾病";

    self.typeTextLabel.font = [UIFont systemFontOfSize:14];
//    [self setLableBtn:self.typeTextLabel withDataArray:self.categoryArray];
    self.typeTextLabel.text = @"选择种类";

    self.styleTextLabel.font = [UIFont systemFontOfSize:14];
//    [self setLableBtn:self.styleTextLabel withDataArray:self.treatArray];
    self.styleTextLabel.text = @"选择方式";
    
    
    
    NSArray *array = @[self.deskTextLabel,self.deskSunTextLabel,self.illTextLabel,self.typeTextLabel,self.styleTextLabel];
    for (int i = 0 ; i<5; i++) {
//        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"下拉"]];
        UILabel *label = array[i];
        label.layer.borderWidth = 1;
        label.layer.borderColor = [[UIColor blackColor]CGColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor stringTOColor:@"#fff4de"];
        label.userInteractionEnabled = YES;
//        [label addSubview:imageView];
        
        
//        UIButton *button = [[UIButton alloc]init];
//        button.frame = CGRectMake(0, 0, 100, 15);
//        button.backgroundColor = [UIColor yellowColor];
//        button.tag = 100+i;
//        [button addTarget:self action:@selector(labelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [label addSubview:button];
        
//        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(label);
//            make.right.equalTo(label);
//            make.bottom.equalTo(label);
//            make.width.mas_equalTo(imageView.mas_height).multipliedBy(1);
//        }];
    }

    
    
    
    self.illBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _illBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.illBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.illBtn addTarget:self action:@selector(handleWithillButton:) forControlEvents:UIControlEventTouchUpInside];
    self.priceTextLabel.font = [UIFont systemFontOfSize:14];
    self.cycleTextLabel.font = [UIFont systemFontOfSize:14];
    self.effectTextLabel.font = [UIFont systemFontOfSize:14];
    self.effectTextLabel.numberOfLines = 0;
   // [self.view addSubview:oneView];
    
    
//    [oneView addSubview:lowimage];
    [oneView addSubview:hosLabel];
    [oneView addSubview:docLabel];
    [oneView addSubview:deskLabel];
    [oneView addSubview:illLabel];
    [oneView addSubview:typeLabel];
    [oneView addSubview:styleLabel];

    
//    [oneView addSubview:priceLabel];
//    [oneView addSubview:cycleLabel];
//    [oneView addSubview:effectLabel];
    
    [oneView addSubview:self.hosTextlabel];
    [oneView addSubview:self.nameTextlabel];
    [oneView addSubview:self.deskTextLabel];
    [oneView addSubview:self.deskSunTextLabel];
    [oneView addSubview:self.illTextLabel];
    [oneView addSubview:self.typeTextLabel];
    [oneView addSubview:self.styleTextLabel];
    
//    [oneView addSubview:self.illBtn];
//    [oneView addSubview:self.priceTextLabel];
//    [oneView addSubview:self.cycleTextLabel];
//    [oneView addSubview:self.effectTextLabel];
    
    __weak typeof(self) weakSelf = self;
    
    [hosLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneView.mas_left).with.offset(10);
        make.top.equalTo (oneView.mas_top).with.offset(10);
//        make.width.mas_equalTo(@65);
     }];
    [weakSelf.hosTextlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(hosLabel);
        make.left.equalTo(hosLabel.mas_right).with.offset(10);
//        make.right.equalTo(oneView.mas_right);
        
    }];

    
    
    [docLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneView.mas_left).with.offset(10);
        make.top.equalTo (hosLabel.mas_bottom).with.offset(10);
//        make.width.mas_equalTo(@65);
    }];
    [weakSelf.nameTextlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(docLabel);
        make.left.equalTo(docLabel.mas_right).with.offset(10);
//        make.right.equalTo(oneView.mas_right);
    }];
    
    
    [deskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneView.mas_left).with.offset(10);
        make.top.equalTo(docLabel.mas_bottom).with.offset(10);
    }];
    [self.deskTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(deskLabel.mas_centerY);
        make.left.equalTo(deskLabel.mas_right).with.offset(10);
        make.width.equalTo(@100);
    }];
    [self.deskSunTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(deskLabel.mas_centerY);
        make.left.equalTo(self.deskTextLabel.mas_right).with.offset(10);
        make.width.equalTo(@100);

    }];
    
    
    
    [illLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(deskLabel.mas_right);
        make.top.equalTo (deskLabel.mas_bottom).with.offset(10);
//        make.width.mas_equalTo(@65);
    }];
    [self.illTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(illLabel.mas_centerY);
        make.left.equalTo(self.deskTextLabel.mas_left);
        make.width.equalTo(@100);

    }];
    
    
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(illLabel.mas_right);
        make.top.equalTo(illLabel.mas_bottom).with.offset(10);
    }];
    [self.typeTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(typeLabel.mas_centerY);
        make.left.equalTo(self.illTextLabel.mas_left);
        make.width.equalTo(@100);

    }];
    
    
    [styleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(typeLabel.mas_right);
        make.top.equalTo(typeLabel.mas_bottom).with.offset(10);
    }];
    [self.styleTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(styleLabel.mas_centerY);
        make.left.equalTo(self.typeTextLabel.mas_left);
        make.width.equalTo(@100);

    }];
    
    UIButton *button = [[UIButton alloc]init];
    button.frame = self.deskTextLabel.frame;
    button.backgroundColor = [UIColor yellowColor];
    [oneView addSubview:button];
    
    
    
//    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(oneView.mas_left).with.offset(5);
//        make.top.equalTo (illLabel.mas_bottom).with.offset(5);
//        make.width.mas_equalTo(@65);
//    }];
//    
//    [cycleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(oneView.mas_left).with.offset(5);
//        make.top.equalTo (priceLabel.mas_bottom).with.offset(5);
//        make.width.mas_equalTo(@65);
//    }];
//    
//    [effectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(oneView.mas_left).with.offset(5);
//        make.top.equalTo (cycleLabel.mas_bottom).with.offset(5);
//        make.width.mas_equalTo(@65);
//    }];
    
    
    
    
//    [weakSelf.illBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(illLabel);
//        make.left.equalTo(illLabel.mas_right).with.offset(10);
//        make.right.equalTo(lowimage.mas_left);
//    }];
//    
//    [lowimage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(illLabel);
//        make.right.equalTo(oneView.mas_right).with.offset(-5);
//        
//        make.width.mas_equalTo(@15);
//        make.height.mas_equalTo(@10);
//        
//    }];
//    [weakSelf.priceTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(priceLabel);
//        make.left.equalTo(priceLabel.mas_right).with.offset(10);
//        make.right.equalTo(oneView.mas_right);
//    }];
//    [weakSelf.cycleTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(cycleLabel);
//        make.left.equalTo(cycleLabel.mas_right).with.offset(10);
//        make.right.equalTo(oneView.mas_right);
//    }];
//    [weakSelf.effectTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(effectLabel);
//        make.left.equalTo(effectLabel.mas_right).with.offset(10);
//        make.right.equalTo(oneView.mas_right);
//    }];
    
}

- (void)setLableBtn:(UILabel *)label withDataArray:(NSArray *)dataArray {
    WEAK(weakTopB, label);
    WEAK(weaklistArray, dataArray);
    [label tapHandle:^{
        CGRect label3Rect = [MLMOptionSelectView targetView:label];
        NSLog(@"~~~~%ld",dataArray.count);
        [self defaultCellWithDataArray:dataArray];
        _cellView.arrow_offset = .5;
        _cellView.vhShow = YES;
        _cellView.optionType = MLMOptionSelectViewTypeCustom;
        _cellView.selectedOption = ^(NSIndexPath *indexPath) {//cell 的点击方法
            weakTopB.text = weaklistArray[indexPath.row];
            
            if (label == self.deskTextLabel) {
                [self requestDeskSunDataWithId:self.depIdDataArray[indexPath.row]];
                self.currentDepId = self.depIdDataArray[indexPath.row];

            }else if (label == self.deskSunTextLabel) {
                [self requestIllDataWithDipId:self.depIdDataArray[indexPath.row] withSdepId:self.sunDeskIdArray[indexPath.row]];

            }else if (label == self.illTextLabel) {
                [self requestTypeDataWithHid:self.hosId andIll:self.illDataArray[indexPath.row]];
            }
            else if (label == self.typeTextLabel && self.categoryArray.count != 0) {
                NSLog(@"~~~%@",self.categoryArray);
                [self requestStyleDataWithIll:self.illDataArray[indexPath.row] andCategory:self.categoryArray[indexPath.row]];
            }
            
        };
        
        [_cellView showViewFromPoint:CGPointMake(label3Rect.origin.x, label3Rect.origin.y+label3Rect.size.height) viewWidth:label.bounds.size.width targetView:label direction:MLMOptionSelectViewBottom];
    }];

}
#pragma mark - 设置——cell
- (void)defaultCellWithDataArray:(NSArray *)dataArray {
    WEAK(weaklistArray, dataArray);
    WEAK(weakSelf, self);
    _cellView.canEdit = NO;
    [_cellView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DefaultCell"];
    _cellView.cell = ^(NSIndexPath *indexPath){
        UITableViewCell *cell = [weakSelf.cellView dequeueReusableCellWithIdentifier:@"DefaultCell"];
        
        if (![weaklistArray[indexPath.row] isEqual:[NSNull null]]) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@",weaklistArray[indexPath.row]];
        }
        
        return cell;
    };
    _cellView.optionCellHeight = ^{
        return 40.f;
    };
    _cellView.rowNumber = ^(){
        NSLog(@"行数：%ld",weaklistArray.count);
        return (NSInteger)weaklistArray.count;
    };
    
}

- (void)createBottomView {
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 264, kScreenWidth, 200)];
    bottomView.userInteractionEnabled = YES;
    bottomView.backgroundColor = [UIColor stringTOColor:@"#fff4de"];
    [self.view addSubview:bottomView];
    
    
    
    //创建scrollview
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 151)];
    scrollView.contentSize = CGSizeMake(kScreenWidth*3, 0);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    [bottomView addSubview:scrollView];
    
    //创建pageControl
    self.pageControl = [[UIPageControl alloc]init];
    [bottomView addSubview:self.pageControl];
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView.mas_bottom);
        make.centerX.equalTo(bottomView.mas_centerX);
    }];
    
    
    //确认提交按钮
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sureBtn.backgroundColor = [UIColor greenColor];
    [sureBtn setTitle:@"确认提交" forState:normal];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_bottom).with.offset(10);
        make.centerX.equalTo(bottomView.mas_centerX);
        make.width.mas_offset(@200);
    }];
    

    
    
    self.docMarkLabel = [[UILabel alloc]init];
    self.docMarkLabel.text = @"本周";
    self.docMarkLabel.font = [UIFont systemFontOfSize:13];
    [bottomView addSubview:self.docMarkLabel];
    [self.docMarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView.mas_centerX);
        make.top.equalTo(bottomView.mas_top).with.offset(15);
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
        
        
        //出诊btn
        for (int i = 0; i<14; i++) {
            
            self.oneBtn = [[UIButton alloc]initWithFrame: CGRectMake(aView.frame.size.width/8 *(i%7+1), 40+30*(i/7), aView.frame.size.width/8, 30)];
            self.oneBtn.tag = i+j*100;
            
            [self.oneBtn addTarget:self action:@selector(chuzhenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            self.oneBtn.layer.borderWidth = 1.0;
            self.oneBtn.layer.borderColor = [UIColor blackColor].CGColor;
            
            
            self.oneBtn.titleLabel.font = [UIFont systemFontOfSize:13];

            NSArray *weekAMArray = self.markOneArray[j];
            if (i<7 && [[weekAMArray[i] objectForKey:@"num"] integerValue]==1) {
                [self.oneBtn setTitle:@"出诊" forState:normal];
                [self.oneBtn setTitleColor:[UIColor blackColor] forState:normal];
                
                
            }
            NSArray *weekPMArray = self.markTwoArray[j];
            if (i>=7 && [[weekPMArray[i-7] objectForKey:@"num"] integerValue]==1) {
                [self.oneBtn setTitle:@"出诊" forState:normal];
                [self.oneBtn setTitleColor:[UIColor blackColor] forState:normal];

            }
            
            [aView addSubview:self.oneBtn];
            
        }}

    
    
}

//确认提交
- (void)sureBtnClick:(UIButton *)sender {
    [self submitData];
}

- (void)chuzhenBtnClick:(UIButton *)sender {
    
    //0:本周  1：下周  2：下下周
    NSInteger weekNum = sender.tag/100;
    
    
    //单选
    if ([sender.currentTitle isEqualToString:@"出诊"]) {
        self.selectBtn.backgroundColor = [UIColor clearColor];
        sender.backgroundColor = [UIColor greenColor];
        self.selectBtn = sender;
        
        NSArray *weekAMArray = self.markOneArray[weekNum];//获取周
        if ((sender.tag - 100*weekNum)<7) {//上午
            self.currentSelectDate = [weekAMArray[sender.tag - 100*weekNum] objectForKey:@"date"];
        }else {//下午
            NSArray *weekPMArray = self.markTwoArray[weekNum];
            self.currentSelectDate = [weekPMArray[sender.tag - 100*weekNum-7] objectForKey:@"date"];
        }
    }
    
//    (多选)
//    if ([sender.currentTitle isEqualToString:@"出诊"]) {
//    
//    switch (weekNum) {
//        case 0:
//        {
//            if ([self.oneWeekSelectArr[sender.tag] isEqualToString:@"NO"]) {
//                sender.backgroundColor = [UIColor greenColor];
//                self.oneWeekSelectArr[sender.tag] = @"YES";
//            }else {
//                sender.backgroundColor = [UIColor clearColor];
//                self.oneWeekSelectArr[sender.tag] = @"NO";
//            }
//        }
//            break;
//        case 1:
//        {
//            if ([self.twoWeekSelectArr[sender.tag-100] isEqualToString:@"NO"]) {
//                sender.backgroundColor = [UIColor greenColor];
//                self.twoWeekSelectArr[sender.tag-100] = @"YES";
//            }else {
//                sender.backgroundColor = [UIColor clearColor];
//                self.twoWeekSelectArr[sender.tag-100] = @"NO";
//            }
//        }
//            break;
//        case 2:
//        {
//            if ([self.threeWeekSelectArr[sender.tag-200] isEqualToString:@"NO"]) {
//                sender.backgroundColor = [UIColor greenColor];
//                self.threeWeekSelectArr[sender.tag-200] = @"YES";
//            }else {
//                sender.backgroundColor = [UIColor clearColor];
//                self.threeWeekSelectArr[sender.tag-200] = @"NO";
//            }
//        }
//            break;
//            
//        default:
//            break;
//    }
//}
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x/kScreenWidth;
    switch (self.pageControl.currentPage) {
        case 0:
            self.docMarkLabel.text = @"本周";
            break;
        case 1:
            self.docMarkLabel.text = @"下周";
            break;
        case 2:
            self.docMarkLabel.text = @"下下周";
            break;
            
        default:
            break;
    }
    
}

- (void)handleWithillButton:(UIButton *)sender{
    if (self.dataArray.count == 1) {
        DocOrderModel *model = self.dataArray[0];
       // NSString *str = model.disease;
       // NSLog(@"str = %@",str);
//        self.dataTwoArr = [NSArray array];
//        self.dataTwoArr = [str componentsSeparatedByString:@","];
//        self.dataThreeArr = [model.ill componentsSeparatedByString:@","];
        
        LrdAlertTableView *view = [[LrdAlertTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
        //传入数据
        //NSString *ill = @"%@";
        // LrdDateModel *model = [[LrdDateModel alloc]initWithIll:ill];
        view.dataArray = model.ill_list;
        view.mydelegate = self;
        [view pop];
    }
}


//- (void)labelBtnClick:(UIButton *)sender {
//    
//    switch (sender.tag) {
//        case 100:
//        {
////            [self requestDeskData];
//        }
//            break;
//        case 101:
//        {
//            
//        }
//            break;
//        case 102:
//        {
//            
//        }
//            break;
//        case 103:
//        {
//            
//        }
//            break;
//        case 104:
//        {
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
//}

//代理返回值

- (void)sendeId:(NSInteger)row{
    //[self reloadCell:2 section:0];
    if (self.dataArray.count != 0) {
       DocOrderModel *model = self.dataArray[0];
//        NSString *str = model.disease;
//        NSLog(@"str = %@",str);
//        self.dataTwoArr = [NSArray array];
//        self.dataTwoArr = [str componentsSeparatedByString:@","];
        
//self.rrr   = row;
        NSLog(@"self.rrr = %ld",row);
        
        // self.threeTextLabel.titleLabel.text = self.dataTwoArr[_rrr];
        [self.illBtn setTitle:model.ill_list[row][@"ill"] forState:UIControlStateNormal];

        [self.illDetailArray removeAllObjects];
        [self requestIllListView:model.ill_list[row][@"cid"]];
        [self.tableView reloadData];

    }
}

//科室
- (void)requestDeskData {
    NSLog(@"hid == %@",self.hosId);
    NSDictionary *dic = @{@"hid":self.hosId};
    [self.request POST:@"http://www.enuo120.com/index.php/app/hospital/home_keshi" params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *dataArr = responseObject[@"data"];
        
        if (!(dataArr.count == 0)) {
            for (NSDictionary *dic in dataArr) {
                NSString *deskName = dic[@"department"];//科室名字
                NSString *depId = dic[@"id"];//depId
                [self.deskDataArray addObject:deskName];
                [self.depIdDataArray addObject:depId];
                
                [self setLableBtn:self.deskTextLabel withDataArray:self.deskDataArray];

            }
        }else {
            NSLog(@"数组为空，没有科室");
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

//子科室
- (void)requestDeskSunDataWithId:(NSString *)depId {
    NSLog(@"hosid == %@~~depid == %@",self.hosId,depId);
            NSDictionary *dic = @{@"hid":self.hosId,@"dep_id":depId};
            [self.request POST:@"http://www.enuo120.com/index.php/app/index/get_yue_sdep_list" params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                
                if (![responseObject[@"data"] isEqual:[NSNull null]]) {
                    
                    NSArray *dataArr = responseObject[@"data"];
                    
                    if (!(dataArr.count == 0)) {
                        for (NSDictionary *dic in dataArr) {
                            NSString *deskName = dic[@"name"];//科室名字
                            NSString *sdepId = dic[@"sdep_id"];//depId
                            [self.sunDeskDataArray removeAllObjects];
                            [self.sunDeskIdArray removeAllObjects];
                            [self.sunDeskDataArray addObject:deskName];
                            [self.sunDeskIdArray addObject:sdepId];
                            
                            [self setLableBtn:self.deskSunTextLabel withDataArray:self.sunDeskDataArray];
                            
                        }
                    }else {
                        NSLog(@"数组为空，没有科室");
                    }
                }
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
        }

//疾病
- (void)requestIllDataWithDipId:(NSString *)depId withSdepId:(NSString *)sdepId {
    
            NSLog(@"depid =  %@,sdepId = %@",depId,sdepId);
            NSDictionary *dic = @{@"dep_id":depId,@"sdep_id":sdepId};
            [self.request POST:@"http://www.enuo120.com/index.php/App/index/get_dep_mb_list" params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                
                if (![responseObject[@"data"] isEqual:[NSNull null]]) {

                NSArray *dataArr = responseObject[@"data"];
                
                if (!(dataArr.count == 0)) {
                    for (NSDictionary *dic in dataArr) {
                        NSString *ill = dic[@"ill"];//疾病名字
                        [self.illDataArray removeAllObjects];
                        [self.illDataArray addObject:ill];
                        
                        [self setLableBtn:self.illTextLabel withDataArray:self.illDataArray];

                    }
                }}else {
                    NSLog(@"为空");
                }
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
}

//种类
- (void)requestTypeDataWithHid:(NSString *)hId andIll:(NSString *)illStr {
    NSLog(@"%@~~%@",hId,illStr);
    NSDictionary *dic = @{@"hid":hId,@"ill":illStr};
    [self.request POST:@"http://www.enuo120.com/index.php/App/index/get_dep_category_list" params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if (![responseObject[@"data"] isEqual:[NSNull null]]) {
            NSArray *dataArr = responseObject[@"data"];
            if (!(dataArr.count == 0)) {
                for (NSDictionary *dic in dataArr) {
                    NSString *category = dic[@"category"];//种类
                    [self.categoryArray removeAllObjects];
                    NSLog(@"category===%@",category);
                    if (![category isEqual:[NSNull null]]) {
                        [self.categoryArray addObject:category];
                        
                        [self setLableBtn:self.typeTextLabel withDataArray:self.categoryArray];


                    }
                }
            }
        }else {
            NSLog(@"种类为空");
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

//方式
- (void)requestStyleDataWithIll:(NSString *)illStr andCategory:(NSString *)category {
    NSDictionary *dic = @{@"ill":illStr,@"category":category};
    [self.request POST:@"http://www.enuo120.com/index.php/App/index/get_dep_treat_list" params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
    
        if (![responseObject[@"data"] isEqual:[NSNull null]]) {
            
            
            NSArray *dataArr = responseObject[@"data"];
            if (!(dataArr.count == 0)) {
                for (NSDictionary *dic in dataArr) {
                    NSString *treat = dic[@"treat"];//方式
                    [self.treatArray removeAllObjects];
                    
                    if (![category isEqual:[NSNull null]]) {
                        
                        [self.treatArray addObject:treat];
                        
                        [self setLableBtn:self.styleTextLabel withDataArray:self.treatArray];
                    }
                }
            }
        }

        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

//提交
- (void)submitData {
    NSString *userName = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    
    
    NSString *illStr = [self.illTextLabel.text isEqualToString:@"请选择疾病"]?@"":self.illTextLabel.text;
    
    
    
    if (userName != nil && self.currentDepId != nil && self.currentSelectDate != nil) {
    
    NSDictionary *dic = @{@"username":userName,@"hos_id":self.hosId,@"dep_id":self.currentDepId,@"doc_id":self.docId,@"date":self.currentSelectDate,@"ill":illStr,@"ver":@"1.0"};
    [self.request POST:@"http://www.enuo120.com/index.php/app/doctor/confirm_yue" params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self handelWithSureData:responseObject];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    }else {
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请补全信息" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请补全信息"preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }
        
    }
    
}

- (void)handelWithSureData:(NSDictionary *)dic{
    
    NSLog(@"$$$$$$$");
    
    if ([dic[@"data"][@"message"]isEqualToString:@"预约成功"]) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:dic[@"data"][@"message"] delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"data"][@"message"]preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }]];
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }
        
    }else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:dic[@"data"][@"message"] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"data"][@"message"]preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];

            }]];
            
            [self presentViewController:alertView animated:YES completion:^{

            }];
        }
    }
    
    
}


//- (void)requestOrderData{
//
//    NSString *url = @"http://www.enuo120.com/index.php/app/doctor/guahao";
//    
//    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
//    NSDictionary *heardBody = @{@"did":self.hosId};
//    
//    [manger POST:url parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [self handleWithOrderData:responseObject];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
//    
//    
//}

//- (void)handleWithOrderData:(NSDictionary *)dic{
//    DocOrderModel *model =[DocOrderModel docOrderModelInitWithDic:dic[@"data"]];
//    self.hosTextlabel.text = model.hos_name;
//    self.nameTextlabel.text = model.doc_name;
//    
//    [self.dataArray addObject:model];
//    
//    for (NSDictionary *temp in dic[@"data"][@"ill_list"]) {
//        illListModel *model = [illListModel illListModelWithDic:temp];
//        [self.illDataArray addObject:model];
//        
//    }
//    if (self.illDataArray.count != 0) {
//        illListModel *model  = self.illDataArray[0];
//
//        [self.illBtn setTitle:model.ill forState:UIControlStateNormal];
//        
//        [self requestIllListView:model.cid];
//    }
//    
//    [self.tableView reloadData];
//}



- (void)requestIllListView:(NSString *)cid{
    NSString *url = @"http://www.enuo120.com/index.php/app/doctor/get_ill_info";
    
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
     NSDictionary *heardBody = @{@"cid":cid};
    
    
    [mager POST:url parameters:heardBody  progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"ressss = %@",responseObject);
        [self handleWithillData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
    
}

- (void)handleWithillData:(NSDictionary *)dic{
    IllListDetailModel *model = [IllListDetailModel IllListDocModelWith:dic[@"data"]];
    self.priceTextLabel.text =[NSString stringWithFormat:@"不高于%@元",model.heightprice] ;
    self.cycleTextLabel.text = model.cycle;
     NSString *str =  [model.effect stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
    self.effectTextLabel.text = [str stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    
    [self.illDetailArray addObject:model];
    
    [self.tableView reloadData];
}


#pragma mark---------------------------------时间--------------------------------------------------------
- (UIView*)creatTimeView{
    // NSLog(@"model.scher = %@",model.schedule);
    if (self.dataArray.count !=0) {
         DocOrderModel  *model = self.dataArray[0];
        UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
        NSMutableArray *arrMut = [NSMutableArray array];
        UIView *aller = [[UIView alloc]initWithFrame:CGRectMake(0,  40, kScreenWidth,42)];
        for (int i = 0; i<7; i ++) {
            
            NSTimeInterval secondsPerDay =  (i+_sss) * 24*60*60;
            NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM.dd"];
            NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
            NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
            [weekFormatter setDateFormat:@"EEEE"];//星期几 @"HH:mm 'on' EEEE MMMM d"];
            NSString *weekStr = [weekFormatter stringFromDate:curDate];
            
            
            UILabel *alabel = [[UILabel alloc]initWithFrame:CGRectMake(25+(kScreenWidth - 25)/7 *i,0, (kScreenWidth - 20)/7, 20)];
            UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(25+(kScreenWidth - 25)/7 *i,20, (kScreenWidth - 20)/7, 20)];
            alabel.text = dateStr;
            tlabel.text = weekStr;
            NSString *chinaStr = [self cTransformFromE:weekStr];
            [arrMut addObject:chinaStr];
            alabel.adjustsFontSizeToFitWidth = YES;
            tlabel.adjustsFontSizeToFitWidth = YES;
            alabel.font = [UIFont systemFontOfSize:13];
            tlabel.font = [UIFont systemFontOfSize:13];
            [aller addSubview:alabel];
            [aller addSubview:tlabel];
        }
        aller.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
        //[self.view addSubview:aller];
        //NSLog( @"Model.scj.count =%d",model.schedule_list.count);
        //NSLog(@"model.schedule[1] = %@",model.schedule[1]);
        self.bView = [[UIView alloc]initWithFrame:CGRectMake(0, 90, kScreenWidth, (kScreenWidth - 25)/7/0.9+4)];
        //_bView.backgroundColor = [UIColor blueColor];
        NSArray *arr = model.schedule_list;
        NSMutableArray *oneArr = [NSMutableArray array];//上午
        NSMutableArray *twoArr = [NSMutableArray array];//下午
        for (int i = 0; i<14; i ++) {
            
            if (i<7) {
                [oneArr addObject:arr[i]];
            }else{
                [twoArr addObject:arr[i]];
            }
        }
        
        for (int i = 0; i<7; i++) {
            if ([oneArr[i] integerValue] == 1) {
                for (int j = 0; j<7; j++) {
                    if (i == [arrMut[j] integerValue]) {
                        UIButton *abutton = [UIButton buttonWithType:UIButtonTypeCustom];
                        abutton.frame = CGRectMake(25+(kScreenWidth - 25)/7 *j,2, (kScreenWidth - 25)/7, (kScreenWidth - 25)/7/1.8);
                        [abutton addTarget:self action:@selector(handleAbutton:) forControlEvents:UIControlEventTouchUpInside];
                        abutton.tag = j+130;
                        //abutton.backgroundColor = [UIColor yellowColor];
                        //                        [abutton setTitle:@"预约" forState:UIControlStateNormal];
                        //                           abutton.titleLabel.font = [UIFont systemFontOfSize:14];
                        //                               [abutton setTitleColor: [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1]forState:UIControlStateNormal];
                        //                        abutton.titleLabel.adjustsFontSizeToFitWidth = YES;
                        // abutton.imageView.image = [UIImage imageNamed:@"g_uncheck"];
                        
                        abutton.userInteractionEnabled = YES;
                        
                        [abutton setBackgroundImage:[UIImage imageNamed:@"g_uncheck"] forState:UIControlStateNormal];
                        [_bView addSubview:abutton];
                    }
                }
            }
        }
        
        
        for (int i = 0; i<7; i++) {
            if ([twoArr[i] integerValue] == 1) {
                for (int j = 0; j<7; j++) {
                    if (i == [arrMut[j] integerValue]) {
                        UIButton *abutton = [UIButton buttonWithType:UIButtonTypeCustom];
                        [abutton addTarget:self action:@selector(handleBbutton:) forControlEvents:UIControlEventTouchUpInside];
                        abutton.tag = j+100;
                        // abutton.backgroundColor = [UIColor yellowColor];
                        abutton.frame = CGRectMake(25+(kScreenWidth - 25)/7 *j,32, (kScreenWidth - 25)/7, (kScreenWidth - 25)/7/1.8);
                        abutton.userInteractionEnabled = YES;
                        
                        [abutton setBackgroundImage:[UIImage imageNamed:@"g_uncheck"] forState:UIControlStateNormal];
                        [_bView addSubview:abutton];
                    }
                }
            }
        }
        
        
        // [self.view addSubview:_bView];
        UILabel *shangLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, 15, 30)];
        shangLabel.numberOfLines = 0;
        shangLabel.text = @"上午";
        shangLabel.font = [UIFont systemFontOfSize:11];
        
        UILabel *xiaLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 32, 15, 30)];
        xiaLabel.numberOfLines = 0;
        xiaLabel.text = @"下午";
        xiaLabel.font = [UIFont systemFontOfSize:11];
        [_bView addSubview:shangLabel];
        [_bView addSubview:xiaLabel];
        
        //   NSLog(@"arr.count = %ld",arr.count);
        
        //    for (int i=0; i<7; i ++) {
        //        if (i<7  &&  [arr [[arrMut[i] integerValue]]isEqualToString:@"1"]) {
        //            UIButton *abutton = [UIButton buttonWithType:UIButtonTypeCustom];
        //            abutton.frame = CGRectMake(10+(kScreenWidth - 20)/7 *i,0, (kScreenWidth - 20)/7, 20);
        //            [abutton setTitle:@"1" forState:UIControlStateNormal];
        //            [bView addSubview:abutton];
        //        }else if (i>6 && [arr[[arrMut[i] integerValue]+6]isEqualToString:@"1"]){
        //            UIButton *bbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        //            bbutton.frame = CGRectMake(10+(kScreenWidth - 20)/7 *(i- 7),20, (kScreenWidth - 20)/7, 20);
        //
        //            [bbutton setTitle:@"2" forState:UIControlStateNormal];
        //
        //            [bView addSubview:bbutton];
        //        }else{
        //            NSLog(@"adasdasd");
        //        }
        //    }
        //
        UIButton *abutton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *bbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        abutton.frame = CGRectMake(40, 160, 80, 20);
        bbutton.frame = CGRectMake(kScreenWidth - 140, 160, 80, 20);
        abutton.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
        bbutton.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
        [abutton setTitle:@"返回上周" forState:UIControlStateNormal];
        [bbutton setTitle:@"预约下周" forState:UIControlStateNormal];
        [abutton addTarget:self action:@selector(addtabebutton:) forControlEvents:UIControlEventTouchUpInside];
        [bbutton addTarget:self action:@selector(nexttabebutton:) forControlEvents:UIControlEventTouchUpInside];
        //[self.view addSubview:abutton];
        //[self.view addSubview:bbutton];
        
        [aView addSubview:aller];
        [aView addSubview:_bView];
        [aView addSubview:abutton];
        [aView addSubview:bbutton];
        
        
        
        
        
        
        
        
        
        
        
        return aView;
        
    }else{
        return nil;
    }
}


- (NSString *)cTransformFromE:(NSString *)theWeek{
    NSString *chinaStr;
    if(theWeek){
        if([theWeek isEqualToString:@"星期一"]){
            chinaStr = @"0";
        }else if([theWeek isEqualToString:@"星期二"]){
            chinaStr = @"1";
        }else if([theWeek isEqualToString:@"星期三"]){
            chinaStr = @"2";
        }else if([theWeek isEqualToString:@"星期四"]){
            chinaStr = @"3";
        }else if([theWeek isEqualToString:@"星期五"]){
            chinaStr = @"4";
        }else if([theWeek isEqualToString:@"星期六"]){
            chinaStr = @"5";
        }else if([theWeek isEqualToString:@"星期日"]){
            chinaStr = @"6";
        }
    }
    return chinaStr;
}



- (void)addtabebutton:(UIButton *)sender{
    //self.sss = 0;
    if (self.sss >0) {
        self.sss = self.sss -7;
    }
    
    [self reloadSection:1];
    
}

- (void)nexttabebutton:(UIButton *)sender{
    if (self.sss <14) {
        self.sss = _sss+7;
    } [self reloadSection:1];
    
    // [self creatTableView];
}

- (void)handleAbutton:(UIButton *)sender{
    //
    //    if (sender.selected == YES) {
    //          [sender setBackgroundImage:[UIImage imageNamed:@"g_uncheck"] forState:UIControlStateNormal];
    //    }else{
    //        [sender setBackgroundImage:[UIImage imageNamed:@"g_check"] forState:UIControlStateNormal];
    //    }
    
    
    
    if (self.sss == 0) {
        
        
        
        
        
        float a = (sender.frame.origin.x-10)/((kScreenWidth - 20)/7);
        
        
        
        
        NSTimeInterval secondsPerDay =  a * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        NSString *str1 = @"am";
        self.timeStr = [NSString stringWithFormat:@"%@ %@",dateStr,str1];
        NSLog(@"dateStrAAAAAA = %@",dateStr);
        
        
        UIButton *button = (UIButton *)[self.view viewWithTag:[sender tag]];
        
        for (int i = 100; i<150; i++) {
            UIButton *abutton = (UIButton *)[self.view viewWithTag:i];
            if (abutton.tag == button.tag) {
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_check"] forState:UIControlStateNormal];
            }else{
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_uncheck"] forState:UIControlStateNormal];
            }
            
            
        }
        
        
        
        
        
    }else if (self.sss == 7){
        float a = (sender.frame.origin.x-10)/((kScreenWidth - 20)/7) + 7;
        NSTimeInterval secondsPerDay =  a * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        NSLog(@"dateStrAAAAAA = %@",dateStr);
        NSString *str1 = @"am";
          self.timeStr = [NSString stringWithFormat:@"%@ %@",dateStr,str1];
        UIButton *button = (UIButton *)[self.view viewWithTag:[sender tag]];
        
        for (int i = 100; i<150; i++) {
            UIButton *abutton = (UIButton *)[self.view viewWithTag:i];
            if (abutton.tag == button.tag) {
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_check"] forState:UIControlStateNormal];
            }else{
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_uncheck"] forState:UIControlStateNormal];
            }
        }
        
    }else{
        float a = (sender.frame.origin.x-10)/((kScreenWidth - 20)/7) + 14;
        NSTimeInterval secondsPerDay =  a * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        NSLog(@"dateStrAAAAAA = %@",dateStr);
        NSString *str1 = @"am";
         self.timeStr = [NSString stringWithFormat:@"%@ %@",dateStr,str1];
        UIButton *button = (UIButton *)[self.view viewWithTag:[sender tag]];
        
        for (int i = 100; i<150; i++) {
            UIButton *abutton = (UIButton *)[self.view viewWithTag:i];
            if (abutton.tag == button.tag) {
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_check"] forState:UIControlStateNormal];
            }else{
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_uncheck"] forState:UIControlStateNormal];
            }
        }
    }
    
}


- (void)handleBbutton:(UIButton *)sender{
    if (self.sss == 0) {
        float a = (sender.frame.origin.x-10)/((kScreenWidth - 20)/7);
        
        NSTimeInterval secondsPerDay =  a * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        NSLog(@"dateStrBBBBB = %@",dateStr);
        NSString *str1 = @"pm";
        self.timeStr = [NSString stringWithFormat:@"%@ %@",dateStr,str1];
        UIButton *button = (UIButton *)[self.view viewWithTag:[sender tag]];
        
        for (int i = 100; i<150; i++) {
            UIButton *abutton = (UIButton *)[self.view viewWithTag:i];
            if (abutton.tag == button.tag) {
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_check"] forState:UIControlStateNormal];
            }else{
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_uncheck"] forState:UIControlStateNormal];
            }
        }
        
        
        
    }else if (self.sss == 7){
        float a = (sender.frame.origin.x-10)/((kScreenWidth - 20)/7) + 7;
        NSTimeInterval secondsPerDay =  a * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        NSLog(@"dateStrBBBBB = %@",dateStr);
        NSString *str1 = @"pm";
        self.timeStr = [NSString stringWithFormat:@"%@ %@",dateStr,str1];
        UIButton *button = (UIButton *)[self.view viewWithTag:[sender tag]];
        
        for (int i = 100; i<150; i++) {
            UIButton *abutton = (UIButton *)[self.view viewWithTag:i];
            if (abutton.tag == button.tag) {
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_check"] forState:UIControlStateNormal];
            }else{
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_uncheck"] forState:UIControlStateNormal];
            }
        }
        
    }else{
        float a = (sender.frame.origin.x-10)/((kScreenWidth - 20)/7) + 14;
        NSTimeInterval secondsPerDay =  a * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        NSLog(@"dateStrBBBBB = %@",dateStr);
        NSString *str1 = @"pm";
        self.timeStr = [NSString stringWithFormat:@"%@ %@",dateStr,str1];
        UIButton *button = (UIButton *)[self.view viewWithTag:[sender tag]];
        
        for (int i = 100; i<150; i++) {
            UIButton *abutton = (UIButton *)[self.view viewWithTag:i];
            if (abutton.tag == button.tag) {
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_check"] forState:UIControlStateNormal];
            }else{
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_uncheck"] forState:UIControlStateNormal];
            }
        }
    }
}








//刷新cell
- (void)reloadCell:(NSInteger)row section:(NSInteger)section{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}

//刷新分区
- (void)reloadSection:(NSInteger)section{
    NSIndexSet *indexSets = [[NSIndexSet alloc]initWithIndex:section];
    [self.tableView reloadSections:indexSets withRowAnimation:UITableViewRowAnimationAutomatic];
    
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
