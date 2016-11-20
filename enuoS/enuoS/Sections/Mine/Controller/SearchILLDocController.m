//
//  SearchILLDocController.m
//  enuoS
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchILLDocController.h"
#import <AFNetworking.h>
#import <Masonry.h>
#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>
#import "Macros.h"
#import "SearchillDocModel.h"
#import "UIImageView+UIImageView_FaceAwareFill.h"
#import "PromiseDocViewCell.h"
#import "DoctorViewController.h"
@interface SearchILLDocController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSDictionary *hosDic;
@property (nonatomic,strong)NSArray *docArr;

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation SearchILLDocController

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
- (NSArray *)docArr{
    if (!_docArr) {
        self.docArr= [NSArray array];
    }return _docArr;
}

- (NSDictionary *)hosDic{
    if (!_hosDic) {
        self.hosDic = [NSDictionary dictionary];
    }return _hosDic;
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
    [self requestData];
    [self creatTableView];
   
}
- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)creatTableView{
    self.tableView.dataSource = self;
    self.tableView.delegate =self;
    self.view  = self.tableView;
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView .backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}


- (void)requestData{
    NSString *url = @"http://www.enuo120.com/index.php/app/search/many_doctor";
    NSDictionary *headBody =@{@"ill":self.illReceiver,@"hid":self.hid};
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    [mager POST:url parameters:headBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"RESSS = %@",responseObject);
        [self handleWithData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)handleWithData:(NSDictionary *)dic{
    if ([dic[@"data"]isKindOfClass:[NSNull class]]) {
        NSLog(@"无数据");
    }else{
    
    NSDictionary *data = dic[@"data"];
    SearchillDocModel *model  = [SearchillDocModel searchIllDocModelInithWithDic:data];
    [self.dataArray addObject:model];
        self.docArr = dic[@"data"][@"doc"];
        NSLog(@"self.docArr = %@",self.docArr);
       // NSLog(@"self.doc.count = %ld",self.docArr.count);
        self.hosDic = model.hos;
    [self.tableView reloadData];
}
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
   
       if ([self.docArr isEqual:[NSNull null]]){
            return 0;
        }else{
            return self.docArr.count;
        }
 
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 75;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.dataArray.count != 0) {
       SearchillDocModel *model = self.dataArray[0];
        UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
        aView.backgroundColor= [UIColor whiteColor];
        UIImageView *imager= [[UIImageView alloc]init];
        UILabel *label = [[UILabel alloc]init];
        [aView addSubview:imager];
        [aView addSubview:label];
        NSString *str = [NSString stringWithFormat:urlPicture,model.photo];
        [imager sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
        
        imager.layer.borderColor = [UIColor grayColor].CGColor;
        imager.backgroundColor = [UIColor whiteColor];
        imager.layer.borderWidth = 0.5;
        imager.layer.cornerRadius = 30.0;
        
        imager.clipsToBounds = YES;
        
        label.textColor =  [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:14];
        label.text = self.hosDic[@"hos_name"];
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
        
        
        return aView;
        
    }else{
        return nil;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //SearchillDocModel *model = self.dataArray[0];
    cell.contentView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:247/255.0 alpha:1];
    
    
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
     UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(8, 8, kScreenWidth-16, 200)];
    // [cell.contentView addSubview:imageD9];
aView.layer.cornerRadius = 4.0;
aView.layer.borderColor = [UIColor whiteColor].CGColor;
aView.layer.borderWidth = 1.0;
//    
//    
  aView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
  aView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    aView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    aView.layer.shadowRadius = 4;
    UILabel *nameLabel = [[UILabel alloc]init];
    UILabel *nuoLabel = [[UILabel alloc]init];
    UIImageView *nuoImage = [[UIImageView alloc]init];
    UILabel *treatLabel = [[UILabel alloc]init];
    UIImageView *photoImage = [[UIImageView alloc]init];
    UILabel *proLabel = [[UILabel alloc]init];
    
    proLabel.font = [UIFont systemFontOfSize:13.0f];
    proLabel.textColor = [UIColor lightGrayColor];
    proLabel.text = self.docArr[indexPath.row][@"professional"];
    NSString *str = [NSString stringWithFormat:urlPicture,self.docArr[indexPath.row][@"doctor_photo"]];
    
    [photoImage sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
    
    nameLabel.textColor =  [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.text =self.docArr[indexPath.row][@"name"];
    nuoImage.image=[UIImage imageNamed:@"点诺"];
    nuoLabel.font = [UIFont systemFontOfSize:12];
    nuoLabel.textColor = [UIColor lightGrayColor];
    nuoLabel.text = self.docArr[indexPath.row][@"nuo"];
    
    treatLabel.font = [UIFont systemFontOfSize:13];
    treatLabel.textColor = [UIColor lightGrayColor];
    treatLabel.numberOfLines = 3;
    treatLabel.text = self.docArr[indexPath.row][@"treatment"];
    [cell.contentView addSubview:aView];
    [aView addSubview:proLabel];
    [aView addSubview:nameLabel];
    [aView addSubview:nuoImage];
    [aView addSubview:treatLabel];
    [aView addSubview:nuoLabel];
    [aView addSubview:photoImage];
    aView.backgroundColor = [UIColor whiteColor];
    photoImage.layer.borderColor = [UIColor grayColor].CGColor;
    photoImage.backgroundColor = [UIColor whiteColor];
    photoImage.layer.borderWidth = 0.5;
    photoImage.layer.cornerRadius = 30.0;
    
    photoImage.clipsToBounds = YES;
    [photoImage faceAwareFill];
    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo (aView.mas_left).with.offset(5);
        make.top.equalTo(aView.mas_top).with.offset(5);
        make.width.mas_equalTo (@60);
        make.height.mas_equalTo(@60);
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(photoImage.mas_right).with.offset(10);
        make.centerY.equalTo(photoImage);
        //make.width.mas_equalTo(@);
        
    }];
    [proLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).with.offset(5);
        make.centerY.equalTo(nameLabel);
        make.width.mas_equalTo(65);
    }];
[nuoImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo (proLabel.mas_right).with.offset(5);
    make.centerY.equalTo(proLabel);
    make.width.mas_equalTo(@15);
    make.height.mas_equalTo(@15);
}];
    [nuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nuoImage.mas_right).with.offset(5);
        make.centerY.equalTo(nuoImage);
        make.width.mas_equalTo(@75);
    }];
    [treatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(photoImage.mas_bottom).with.offset(10);
        make.width.mas_equalTo(kScreenWidth- 50);
        make.left.equalTo (aView.mas_left).with.offset(25);
    }];
    
    
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

    
    
  
    
   
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DoctorViewController *doVC = [[DoctorViewController alloc]init];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:doVC];
    doVC.receiver =self.docArr[indexPath.row][@"id"];
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
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
