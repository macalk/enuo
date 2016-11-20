//
//  MineTableController.m
//  enuoS
//
//  Created by apple on 16/7/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MineTableController.h"
#import "MineTableViewCell.h"
#import <Masonry.h>
#import "Macros.h"
#import "LogonViewController.h"
#import "MyOderViewController.h"
#import "MyOrderNewController.h"
#import "MyOrderInforViewController.h"
#import "VIpViewController.h"
#import <AFNetworking.h>
#import "PerfectViewController.h"
#import "GuanZhuViewController.h"
#import "MyPJViewController.h"
#import "CheckOrderController.h"
#import "SelfInfoViewController.h"
#import "DSViewController.h"
#import "MoreViewController.h"
#import "OrderStatueController.h"
#import "SettingViewController.h"
#import "MakePayMiMaViewController.h"
@interface MineTableController ()

@property (nonatomic,copy)NSString *lockStr;
@property (nonatomic,assign)NSInteger payLockStr;

@property (nonatomic,assign)NSInteger statueStr;

@end

@implementation MineTableController



//- (instancetype)initWithStyle:(UITableViewStyle)style{
//    self = [super initWithStyle:style];
//    if (self) {
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
//        self.navigationItem.leftBarButtonItem = leftItem;
//        
//   
//    }return self;
//}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.payLockStr = 10;
    self.lockStr = NULL;
    self.navigationController.navigationBar.translucent = NO;
    //    NSUserDefaults *stande = [NSUserDefaults standardUserDefaults];
    //    NSString *name = [stande objectForKey:@"name"];
    //    if (name) {
    //
    //    }else{
    //
    //    }
//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];

         [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [self requeestStatueData];
     self.tabBarController.tabBar.tintColor =  [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
    NSLog(@"页面 出现！！！！！");
    
}



//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [[UIApplication sharedApplication]setStatusBarStyle: UIStatusBarStyleDefault];
//}

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([self.lockStr isEqualToString:@"0"]&&self.payLockStr == 0) {
        return 10;
    }else if ([self.lockStr isEqualToString:@"1"]&&self.payLockStr == 0){
        return 9;
    }else if ([self.lockStr isEqualToString:@"0"]&&self.payLockStr ==1){
        return 9;
    }else if ([self.lockStr isEqualToString:@"1"]&&self.payLockStr == 1){
        return 8;
    }else{
        return 9;
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
   [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    //self.tableView.tableFooterView.backgroundColor = [UIColor grayColor];
    return cell;
}


- (void)requeestStatueData{
    
    NSString *url = @"http://www.enuo120.com/index.php/app/Patient/center";
    
    
    NSUserDefaults *userStand = [NSUserDefaults standardUserDefaults];
    NSString *name = [userStand objectForKey:@"name"];
     AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    if (name) {
            NSDictionary *hearBody = @{@"username":name};
         [mager POST:url parameters:hearBody progress:^(NSProgress * _Nonnull uploadProgress) {
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [self handleWithDataStatue:responseObject];
             NSLog(@"ressponse =%@",responseObject);
             [self creatHeadView];
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
         }];
    }else{
          [self creatHeadView];
    }

   
    
   
    
}

- (void)handleWithDataStatue:(NSDictionary *)dic{
    self.lockStr = dic[@"data"][@"lock"];
    self.payLockStr = [dic[@"data"][@"pay_lock"] integerValue] ;
    
    self.statueStr = [dic[@"data"][@"statue"] integerValue];
    NSLog(@"%@----%ld",self.lockStr,self.payLockStr);
    [self.tableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        return 10;
    }else{
        if ([self.lockStr isEqualToString:@"0"]&&self.payLockStr == 0 &&indexPath.section==8) {
            return 10;
        }else if ([self.lockStr isEqualToString:@"1"]&&self.payLockStr == 0&&indexPath.section==7){
            return 10;
        }else if ([self.lockStr isEqualToString:@"0"]&&self.payLockStr ==1&&indexPath.section==7){
            return 10;
        }else if ([self.lockStr isEqualToString:@"1"]&&self.payLockStr == 1&&indexPath.section==6){
            return 10;
        }else{
            return 2;
        }

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
#pragma mark- cell 将要显示的时候调用这个方法，就在这个方法内进行圆角绘制
/**
 本质：就是修改cell的背景view，这个view的layer层自己分局cell的类型（顶，底和中间）来绘制*/
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([cell respondsToSelector:@selector(tintColor)])
//    {
//        CGFloat cornerRadius = 5.f;//圆角大小
//        cell.backgroundColor = [UIColor clearColor];
//        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
//        CGMutablePathRef pathRef = CGPathCreateMutable();
//        CGRect bounds = CGRectInset(cell.bounds, 10, 0);
//        BOOL addLine = NO;
//        
//        if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1)
//        {
//            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
//            
//        }
//        else if (indexPath.row == 0)
//        {   //最顶端的Cell（两个向下圆弧和一条线）
//            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
//            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
//            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
//            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
//            addLine = YES;
//        }
//        else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1)
//        {   //最底端的Cell（两个向上的圆弧和一条线）
//            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
//            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
//            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
//            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
//        }
//        else
//        {   //中间的Cell
//            CGPathAddRect(pathRef, nil, bounds);
//            addLine = YES;
//        }
//        layer.path = pathRef;
//        CFRelease(pathRef);
//        layer.fillColor = [UIColor whiteColor].CGColor; //cell的填充颜色
//        layer.strokeColor = [UIColor lightGrayColor].CGColor; //cell 的边框颜色
//        
//        if (addLine == YES) {
//            CALayer *lineLayer = [[CALayer alloc] init];
//            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
//            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds), bounds.size.height-lineHeight, bounds.size.width, lineHeight);
//            lineLayer.backgroundColor = [UIColor lightGrayColor].CGColor;        //绘制中间间隔线
//            [layer addSublayer:lineLayer];
//        }
//        
//        UIView *bgView = [[UIView alloc] initWithFrame:bounds];
//        [bgView.layer insertSublayer:layer atIndex:0];
//        bgView.backgroundColor = UIColor.clearColor;
//        cell.backgroundView = bgView;
//    }
//}


- (void)creatHeadView{
    NSUserDefaults *uerStand = [NSUserDefaults standardUserDefaults];
    
    NSString *name = [uerStand objectForKey:@"name"];
    NSLog(@"name = %@",name);
    if (name) {
           self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 173+82*kScreenWidth*2/610-15)];
        UIView *statuView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 82*kScreenWidth*2/610-15)];
        statuView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        UIImageView *statueImage = [[UIImageView alloc]init];
        [statuView addSubview:statueImage];
        if (self.statueStr == 0) {
            statueImage.image = [UIImage imageNamed:@"等待预约确认"];
            
        }else if (self.statueStr == 1){
            statueImage.image = [UIImage imageNamed:@"等待就诊"];
            
        }else if (self.statueStr == 2){
            statueImage.image = [UIImage imageNamed:@"治疗中"];
        }else if (self.statueStr == 3){
            statueImage.image = [UIImage imageNamed:@"治疗完成"];
        }else {
            statueImage.image = [UIImage imageNamed:@"全灰色"];
        }
        
        NSUserDefaults *userStand = [NSUserDefaults standardUserDefaults];
        
        NSString *name = [userStand objectForKey:@"name"];
        
        UIView *bleView = [[UIView alloc]initWithFrame:CGRectMake(0, 82*kScreenWidth*2/610 +8, kScreenWidth, 150)];
        
        UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 90)];
        oneView.backgroundColor= [UIColor whiteColor];
        UIView *twoView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 50)];
        twoView.backgroundColor = [UIColor whiteColor];
        twoView.layer.borderWidth = 0.5;
        twoView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        

        
        UIImageView *oneImage = [[UIImageView alloc]init];
        oneImage.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        UILabel *oneLabel = [[UILabel alloc]init];
        oneLabel.font = [UIFont systemFontOfSize:13];
        oneLabel.textColor = [UIColor lightGrayColor];
        oneImage.image = [UIImage imageNamed:@"eeenuo"];
        if (name&&[self.lockStr isEqualToString:@"1"]) {
              oneLabel.text = name;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapOneGesture:)];
            //设置轻拍次数  单击  双击  三连击。。。。。
            tapGesture.numberOfTapsRequired = 1;//单击
            //设置触摸手指的个数
            tapGesture.numberOfTouchesRequired = 1;//触摸手指的个数
            // 将轻拍手势添加到相应的视图上（也就是说将手势添加到视图上，那么点击该视图，就应该响应轻拍手势响应的事件）
            [oneView addGestureRecognizer:tapGesture];
        }else if(name&&[self.lockStr isEqualToString:@"0"]){
            oneLabel.text = name;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapTWOGesture:)];
            //设置轻拍次数  单击  双击  三连击。。。。。
            tapGesture.numberOfTapsRequired = 1;//单击
            //设置触摸手指的个数
            tapGesture.numberOfTouchesRequired = 1;//触摸手指的个数
            // 将轻拍手势添加到相应的视图上（也就是说将手势添加到视图上，那么点击该视图，就应该响应轻拍手势响应的事件）
            [oneView addGestureRecognizer:tapGesture];
            
        }else {
            oneLabel.text = @"点击登录";
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
            //设置轻拍次数  单击  双击  三连击。。。。。
            tapGesture.numberOfTapsRequired = 1;//单击
            //设置触摸手指的个数
            tapGesture.numberOfTouchesRequired = 1;//触摸手指的个数
            // 将轻拍手势添加到相应的视图上（也就是说将手势添加到视图上，那么点击该视图，就应该响应轻拍手势响应的事件）
            [oneView addGestureRecognizer:tapGesture];
        }
      
        UILabel *twoLabel = [[UILabel alloc]init];
        
        UILabel *threeLabel = [[UILabel alloc]init];
        twoLabel.text = @"我的关注";
        twoLabel.textAlignment =    NSTextAlignmentCenter ;
        twoLabel.font = [UIFont systemFontOfSize:13];
        //twoLabel.textColor = [UIColor redColor];
        
        threeLabel.text = @"我的评论";
        threeLabel.textAlignment = NSTextAlignmentCenter;
        //threeLabel.textColor = [UIColor blueColor];
        threeLabel.font = [UIFont systemFontOfSize:13];
        UIImageView *twoImage = [[UIImageView alloc]init];
        UIImageView *threeImage = [[UIImageView alloc]init];
        
        twoImage.image = [UIImage imageNamed:@"红色关注"];
        threeImage.image = [UIImage imageNamed:@"蓝色评论"];
        
        
        
        UIButton *twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *threeButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        twoButton.layer.borderWidth = 0.5;
        twoButton.layer.borderColor = [UIColor lightGrayColor].CGColor;

        [twoButton addTarget:self action:@selector(handleMineAttention:) forControlEvents:UIControlEventTouchUpInside];
        [threeButton addTarget:self action:@selector(handleMineComment:) forControlEvents:UIControlEventTouchUpInside];
        
        [twoButton addSubview:twoImage];
        [twoButton addSubview:twoLabel];
        
        //twoButton.backgroundColor = [UIColor blueColor];
        //threeButton.backgroundColor = [UIColor redColor];
        
        [threeButton addSubview:threeLabel];
        [threeButton addSubview:threeImage];
        [bleView addSubview:oneView];
        [bleView addSubview:twoView];
        [twoView addSubview:twoButton];
        [twoView addSubview:threeButton];
        [oneView addSubview:oneImage];
        [oneView addSubview:oneLabel];
        [self.tableView.tableHeaderView addSubview:statuView];
        [self.tableView.tableHeaderView addSubview:bleView];
        
        [oneImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(oneView);
            make.width.mas_equalTo(@40);
            make.height.mas_equalTo(@40);
            make.top.equalTo (oneView.mas_top).with.offset(10);
        }];
        [oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(oneView);
            make.top.equalTo (oneImage.mas_bottom).with.offset(10);
            make.height.mas_equalTo(@20);
        }];
        
        
        [statueImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(statuView);
            make.centerY.equalTo (statuView);
            make.left.equalTo(statuView.mas_left).with.offset(10);
            make.top.equalTo (statuView.mas_top).with.offset(10);
        }];
        
        [twoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(twoButton);
            make.top.equalTo(twoButton.mas_top).with.offset(5);
            make.height.mas_equalTo(@20);
            make.width.mas_equalTo(@20);
            
        }];
        [twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(twoButton);
            make.top.equalTo(twoImage.mas_bottom).with.offset(5);
            make.height.mas_equalTo(@15);
            make.width.mas_equalTo(@90);
        }];
        
        
        
        [threeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(threeButton);
            make.top.equalTo(threeButton.mas_top).with.offset(5);
            make.height.mas_equalTo(@20);
            make.width.mas_equalTo(@20);
            
        }];
        [threeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(threeButton);
            make.top.equalTo(threeImage.mas_bottom).with.offset(5);
            make.height.mas_equalTo(@15);
            make.width.mas_equalTo(@90);
        }];
        
        
        [twoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(twoView.mas_top);
            make.left.equalTo(twoView.mas_left);
            make.bottom.equalTo(twoView);
            make.width.mas_equalTo(kScreenWidth/2);
            
        }];
        [threeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(twoView.mas_top);
            make.left.equalTo(twoButton.mas_right);
            make.bottom.equalTo(twoView);
            make.width.mas_equalTo(kScreenWidth/2);
            
        }];
    }else{
          self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 140)];
        UIView *bleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 130)];
        
        UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 70)];
        oneView.backgroundColor= [UIColor whiteColor];
        UIView *twoView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, kScreenWidth, 50)];
        twoView.layer.borderWidth = 0.5;
        twoView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        twoView.backgroundColor = [UIColor whiteColor];
        UIImageView *oneImage = [[UIImageView alloc]initWithFrame:CGRectMake(25, 10, 40, 40)];
        oneImage.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        UILabel *oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 20, 150, 20)];
        oneImage.image = [UIImage imageNamed:@"eeenuo"];
        oneLabel.font = [UIFont systemFontOfSize:13];
        oneLabel.textColor = [UIColor lightGrayColor];
        oneLabel.text = @"点击登录";
        UILabel *twoLabel = [[UILabel alloc]init];
        
        UILabel *threeLabel = [[UILabel alloc]init];
        twoLabel.text = @"我的关注";
        twoLabel.textAlignment =    NSTextAlignmentCenter ;
        twoLabel.font = [UIFont systemFontOfSize:13];
        //twoLabel.textColor = [UIColor redColor];
        
        threeLabel.text = @"我的评论";
        threeLabel.textAlignment = NSTextAlignmentCenter;
        //threeLabel.textColor = [UIColor blueColor];
        threeLabel.font = [UIFont systemFontOfSize:13];
        UIImageView *twoImage = [[UIImageView alloc]init];
        UIImageView *threeImage = [[UIImageView alloc]init];
        
        twoImage.image = [UIImage imageNamed:@"红色关注"];
        threeImage.image = [UIImage imageNamed:@"蓝色评论"];
        
        
        
        UIButton *twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *threeButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        twoButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        twoButton.layer.borderWidth = 0.5;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
        //设置轻拍次数  单击  双击  三连击。。。。。
        tapGesture.numberOfTapsRequired = 1;//单击
        //设置触摸手指的个数
        tapGesture.numberOfTouchesRequired = 1;//触摸手指的个数
        // 将轻拍手势添加到相应的视图上（也就是说将手势添加到视图上，那么点击该视图，就应该响应轻拍手势响应的事件）
        [oneView addGestureRecognizer:tapGesture];
        [twoButton addTarget:self action:@selector(handleMineAttention:) forControlEvents:UIControlEventTouchUpInside];
        [threeButton addTarget:self action:@selector(handleMineComment:) forControlEvents:UIControlEventTouchUpInside];
        
        [twoButton addSubview:twoImage];
        [twoButton addSubview:twoLabel];
        
        //twoButton.backgroundColor = [UIColor blueColor];
        //threeButton.backgroundColor = [UIColor redColor];
        
        [threeButton addSubview:threeLabel];
        [threeButton addSubview:threeImage];
        [bleView addSubview:oneView];
        [bleView addSubview:twoView];
        [twoView addSubview:twoButton];
        [twoView addSubview:threeButton];
        [oneView addSubview:oneImage];
        [oneView addSubview:oneLabel];
        [self.tableView.tableHeaderView addSubview:bleView];
        
    
        [twoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(twoButton);
            make.top.equalTo(twoButton.mas_top).with.offset(5);
            make.height.mas_equalTo(@20);
            make.width.mas_equalTo(@20);
            
        }];
        [twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(twoButton);
            make.top.equalTo(twoImage.mas_bottom).with.offset(5);
            make.height.mas_equalTo(@15);
            make.width.mas_equalTo(@90);
        }];
        
        
        
        [threeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(threeButton);
            make.top.equalTo(threeButton.mas_top).with.offset(5);
            make.height.mas_equalTo(@20);
            make.width.mas_equalTo(@20);
            
        }];
        [threeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(threeButton);
            make.top.equalTo(threeImage.mas_bottom).with.offset(5);
            make.height.mas_equalTo(@15);
            make.width.mas_equalTo(@90);
        }];
        
        
        [twoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(twoView.mas_top);
            make.left.equalTo(twoView.mas_left);
            make.bottom.equalTo(twoView);
            make.width.mas_equalTo(kScreenWidth/2);
            
        }];
        [threeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(twoView.mas_top);
            make.left.equalTo(twoButton.mas_right);
            make.bottom.equalTo(twoView);
            make.width.mas_equalTo(kScreenWidth/2);
            
        }];

    }

    
}

- (void)handleTapTWOGesture:(UITapGestureRecognizer *)sender{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先完善信息" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
    }else{
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先完善信息" preferredStyle:UIAlertControllerStyleAlert];
        [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertView animated:YES completion:^{
            
        }];
    }
    

}

//个人资料

- (void)handleTapOneGesture:(UITapGestureRecognizer *)sender{
    SelfInfoViewController *infeVC = [[SelfInfoViewController alloc]init];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:infeVC];
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
}




//我的关注
- (void)handleMineAttention:(UIButton *)sender{
    
    NSUserDefaults *userStand = [NSUserDefaults standardUserDefaults];
    NSString *name = [userStand objectForKey:@"name"];
    
    if (name) {
        GuanZhuViewController *gunVC =[[GuanZhuViewController alloc]init];
        //[self.navigationController pushViewController:gunVC animated:YES];
        UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:gunVC];
        
        [self presentViewController:naVC animated:YES completion:^{
            
        }];
    }else{
        [self creatAlertShow];

    }

}

- (void)creatAlertShow{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        
    }else{
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登录" preferredStyle:UIAlertControllerStyleAlert];
        [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        
        [self presentViewController:alertView animated:YES completion:^{
            
        }];
    }

}



//我的评论
- (void)handleMineComment:(UIButton *)sender{
    NSUserDefaults *userStand = [NSUserDefaults standardUserDefaults];
    NSString *name = [userStand objectForKey:@"name"];
    
    if (name) {
    MyPJViewController *pjVC = [[MyPJViewController alloc]init];
    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:pjVC];
    [self presentViewController:naVC animated:YES completion:^{
        
    }];
    
    }else{
          [self creatAlertShow];
    }
}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender{
    LogonViewController *loVC = [[LogonViewController alloc]init];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:loVC];
    
    [self presentViewController:naNC animated:YES completion:^{
        
    }];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"五爷万岁");
}


//headerView配置
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray * oneArr = @[@"完善信息",@"设置支付密码",@"我的体检单",@"约诊记录",@"预约记录",@"我的订单",@"Vip充值卡",@"设置",@"更多"];
    NSArray *oneIDarr = @[@201,@202,@203,@204,@205,@206,@207,@208,@209];
    NSArray *imageOne = @[@"完善信息",@"支付密码",@"体检单",@"约诊记录",@"预约记录",@"订单",@"充值",@"设置",@"更多"];
    
    
    
    NSArray *twoArr = @[@"完善信息",@"设置支付密码",@"我的体检单",@"约诊记录",@"预约记录",@"我的订单",@"Vip充值卡",@"设置",@"更多",@"退出登录"];
    NSArray *twoIDarr =@[@201,@202,@203,@204,@205,@206,@207,@208,@209,@210];
    NSArray *imageTwo = @[@"完善信息",@"支付密码",@"体检单",@"约诊记录",@"预约记录",@"订单",@"充值",@"设置",@"更多",@"退出登录"];
    
    
    
    NSArray *threeArr =  @[@"设置支付密码",@"我的体检单",@"约诊记录",@"预约记录",@"我的订单",@"Vip充值卡",@"设置",@"更多",@"退出登录"];
    NSArray *threeIDArr =@[@202,@203,@204,@205,@206,@207,@208,@209,@210];
    NSArray *imageThree = @[@"支付密码",@"体检单",@"约诊记录",@"预约记录",@"订单",@"充值",@"设置",@"更多",@"退出登录"];
    
    
    
    NSArray *fourArr =  @[@"完善信息",@"我的体检单",@"约诊记录",@"预约记录",@"我的订单",@"Vip充值卡",@"设置",@"更多",@"退出登录"];
    NSArray *fourIdArr = @[@201,@203,@204,@205,@206,@207,@208,@209,@210];
    NSArray *imageFour = @[@"完善信息",@"体检单",@"约诊记录",@"预约记录",@"订单",@"充值",@"设置",@"更多",@"退出登录"];
    
    
    
    
    NSArray *fiveArr = @[@"我的体检单",@"约诊记录",@"预约记录",@"我的订单",@"Vip充值卡",@"设置",@"更多",@"退出登录"];
    NSArray *fiveIdArr = @[@203,@204,@205,@206,@207,@208,@209,@210];
    
    NSArray *imageFive = @[@"体检单",@"约诊记录",@"预约记录",@"订单",@"充值",@"设置",@"更多",@"退出登录"];
    if ([self.lockStr isEqualToString:@"0"]&&self.payLockStr == 0) {
        return [self crearOneWIth:imageTwo[section] title:twoArr[section] tag:[twoIDarr[section] integerValue]];
    }else if ([self.lockStr isEqualToString:@"1"]&&self.payLockStr == 0){
          return [self crearOneWIth:imageThree[section] title:threeArr[section] tag:[threeIDArr[section] integerValue]];
    }else if ([self.lockStr isEqualToString:@"0"]&&self.payLockStr ==1){
        return [self crearOneWIth:imageFour[section] title:fourArr[section] tag:[fourIdArr[section] integerValue]];
    }else if ([self.lockStr isEqualToString:@"1"]&&self.payLockStr == 1){
         return [self crearOneWIth:imageFive[section] title:fiveArr[section] tag:[fiveIdArr[section] integerValue]];
    }else{
          return [self crearOneWIth:imageOne[section] title:oneArr[section] tag:[oneIDarr[section] integerValue]];
    }

    
    
}


- (UIView*)crearOneWIth:(NSString *)imgee
                  title:(NSString *)title tag:(NSInteger)tag{
    
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    aView.backgroundColor = [UIColor whiteColor];
    UILabel *leftLabel = [[UILabel alloc]init];
    UIImageView *imageLeft = [[UIImageView alloc]init];
    UIImageView *imageRight = [[UIImageView alloc]init];
    imageRight.image = [UIImage imageNamed:@"下一步"];
    imageLeft.image = [UIImage imageNamed:imgee];
    leftLabel.font = [UIFont systemFontOfSize:14];
    leftLabel.text = title;
    [aView addSubview:leftLabel];
    [aView addSubview:imageLeft];
    [aView addSubview:imageRight];
    
    [imageRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(aView);
        make.right.equalTo(aView).with.offset(-15);
        make.height.mas_equalTo(@15);
        make.width.mas_equalTo(@10);
       // make.trailing.equalTo(aView).with.offset(15);
    }];
    [imageLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(aView);
        make.left.equalTo(aView.mas_left).with.offset(15);
        make.width.mas_equalTo(@15);
        make.height.mas_equalTo(@15);
    }];
    
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(aView);
        make.left.equalTo(imageLeft.mas_right).with.offset(5);
       
        
    }];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleWithTapTag:)];
    aView.tag = tag;
    //设置轻拍次数  单击  双击  三连击。。。。。
    tapGesture.numberOfTapsRequired = 1;//单击
    //设置触摸手指的个数
    tapGesture.numberOfTouchesRequired = 1;//触摸手指的个数
    [aView addGestureRecognizer:tapGesture];
    
    return aView;
    
    
}

//响应事件
- (void)handleWithTapTag:(UITapGestureRecognizer *)sender{

    NSUserDefaults *userStand = [NSUserDefaults standardUserDefaults];
    NSString *name = [userStand objectForKey:@"name"];
    
    if (name) {
        
    
    if (sender.view.tag == 201) {
        NSLog(@"201");
        PerfectViewController *peVC = [[PerfectViewController alloc]init];
        UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:peVC];
        [self presentViewController:naVC animated:YES completion:^{
            
        }];
        
    }else if(sender.view.tag == 202){
        MakePayMiMaViewController *maVC = [[MakePayMiMaViewController alloc]init];
        UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:maVC];
        
        [self presentViewController:naVC animated:YES completion:^{
            
        }];
        NSLog(@"202");
    }else if (sender.view.tag == 203){
         NSLog(@"203");
        CheckOrderController *checkVC = [[CheckOrderController alloc]init];
        UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:checkVC];
        [self presentViewController:naNC animated:YES completion:^{
            
        }];
    }else if (sender.view.tag == 204){
        DSViewController *dsVC = [[DSViewController alloc]init];
        UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:dsVC];
        [self presentViewController:naVC animated:YES completion:^{
            
        }];
         NSLog(@"204");
    }else if (sender.view.tag == 205){
        OrderStatueController *orderVC = [[OrderStatueController alloc]init];
        UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:orderVC];
        [self presentViewController:naVC animated:YES completion:^{
            
        }];
         NSLog(@"205");
    }else if (sender.view.tag == 206){
        MyOrderInforViewController *myVC = [[MyOrderInforViewController alloc]init];
        UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:myVC];
        [self presentViewController:naNC animated:YES completion:^{
            
        }];

    }else if (sender.view.tag == 207){
         NSLog(@"207");
        VIpViewController *vipVC = [[VIpViewController alloc]init];
        UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:vipVC];
        [self presentViewController:naVC animated:YES completion:^{
            
        }];
    }else if (sender.view.tag == 208){
        SettingViewController *settVc = [[SettingViewController alloc]init];
        UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:settVc];
        [self presentViewController:naNC animated:YES completion:^{
            
        }];
        
         NSLog(@"208");
    }else if(sender.view.tag == 209){
         NSLog(@"209");
        MoreViewController *moreVC = [[MoreViewController alloc]init];
        UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:moreVC];
        [self presentViewController:naNC animated:YES completion:^{
            
        }];
    }else if(sender.view.tag == 210){
        
        
         NSLog(@"210");
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        //移除UserDefaults中存储的用户信息
        [userDefaults removeObjectForKey:@"name"];
        [userDefaults removeObjectForKey:@"password"];
        [userDefaults synchronize];
        [self viewWillAppear:YES];
        [self.tableView reloadData];

    }else{
         NSLog(@"211");
    }
    }else{
        LogonViewController *logVC = [[LogonViewController alloc]init];
        UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:logVC];
        [self presentViewController:naVC animated:YES completion:^{
            
        }];
    }
    
}


@end
