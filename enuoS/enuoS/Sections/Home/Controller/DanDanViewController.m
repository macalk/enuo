//
//  DanDanViewController.m
//  enuoS
//
//  Created by apple on 16/8/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DanDanViewController.h"

#import <Masonry.h>
#import <AFNetworking.h>

#import "Macros.h"

#import "DanDanOneController.h"
#import "DanDanTwoController.h"
#import "DanZlIntroViewController.h"
#import "DanZdModel.h"
#import "DanZlModel.h"
#import "DanDanViewCell.h"
@interface DanDanViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UIImageView *imageBg;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UISegmentedControl *segmented;
@property (nonatomic,strong)UICollectionViewFlowLayout *layout;

@property (nonatomic,strong)NSMutableArray *oneDataArray;//诊断数组

@property (nonatomic,strong)NSMutableArray *twoDataArray;//治疗数据组
@end

@implementation DanDanViewController


- (NSMutableArray *)oneDataArray{
    if (!_oneDataArray) {
        self.oneDataArray = [NSMutableArray array];
    }return _oneDataArray;
}

- (NSMutableArray *)twoDataArray{
    if (!_twoDataArray) {
        self.twoDataArray = [NSMutableArray array];
    }return _twoDataArray;
}


- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        self.layout  = [[UICollectionViewFlowLayout alloc]init];
    }return _layout;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        self.navigationItem.leftBarButtonItem = leftItem;

        
        
        
        
    }return self;
}

//- (UICollectionView *)collectionView{
//    if (!_collectionView) {
//        self.collectionView = [[UICollectionView alloc]init];
//    }return _collectionView;
//}


- (UISegmentedControl *)segmented {
    if (!_segmented) {
        self.segmented = [[UISegmentedControl alloc]initWithItems:@[@"诊断发布",@"治疗发布"]];
    }return _segmented;
}



- (UIImageView *)imageBg{
    if (!_imageBg) {
        self.imageBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"图层-4"]];
        self.imageBg.userInteractionEnabled = YES;
    }return _imageBg;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view = self.imageBg;
    self.navigationItem.title = @"丹丹发布";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     
  @{NSFontAttributeName:[UIFont systemFontOfSize:15],
    
    
    NSForegroundColorAttributeName: [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1]}];
    

        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    [self creatDanDanView];
    if (self.segmented.selectedSegmentIndex == 0) {
        [self requestTwoData];
    }else{
        [self requestOneData];
    }

}

- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//丹丹界面布局设置
- (void)creatDanDanView{
    UIImageView *danImage = [[UIImageView alloc]init];
  _layout = [[UICollectionViewFlowLayout alloc]init];
   // self.collectionView.collectionViewLayout = _layout;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:_layout];
   
    //设置item属性
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"DanDanViewCell" bundle:nil ] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.backgroundColor = [UIColor clearColor];

    _layout.itemSize = CGSizeMake((kScreenWidth - 66)/3-10, 35);
    //4.设置最小行间距
    _layout.minimumLineSpacing = 15;
    //5.设置最小item的间距
    _layout.minimumInteritemSpacing = 10;
    //_layout.minimumInteritemSpacing = 10;
   // _layout.sectionInset = UIEdgeInsetsMake(350, 20, 20, 20);
    self.segmented.selectedSegmentIndex = 0;
    self.segmented.tintColor =  [UIColor whiteColor];
    self.segmented.layer.cornerRadius = 15.0;
    self.segmented.layer.borderWidth = 1.0;
    self.segmented.layer.borderColor = [UIColor whiteColor].CGColor;
     [self.segmented addTarget:self action:@selector(handleChangeSegmentWithValue:) forControlEvents:UIControlEventValueChanged];
    self.segmented.layer.masksToBounds = YES;
    [self.imageBg addSubview:danImage];
    [self.imageBg addSubview:self.segmented];
    [self.imageBg addSubview:self.collectionView];
    
   // self.collectionView.collectionViewLayout =
    __weak typeof(self) weakSelf = self;
    
    danImage.image = [UIImage  imageNamed:@"333333"];
    
    [danImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imageBg.mas_top).with.offset(20);
        make.left.equalTo(weakSelf.imageBg.mas_left).with.offset(15);
        make.right.equalTo(weakSelf.imageBg.mas_right).with.offset(-15);
        make.height.mas_equalTo((kScreenWidth-30)/3.5);
        
        
    }];
    
    [weakSelf.segmented mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (danImage.mas_bottom).with.offset(15);
        make.centerX.equalTo(weakSelf.imageBg);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(kScreenWidth - 66);
        
    }];
    [weakSelf.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.segmented.mas_bottom).with.offset(15);
        make.leading.equalTo(weakSelf.segmented);
        make.trailing.equalTo(weakSelf.segmented);
        make.bottom.equalTo(weakSelf.imageBg.mas_bottom);
        
        
        
    }];
    
}




- (void)creatCollectionView{
    
 
    
    
    
    
//5.设置最小item的间距
    
    
//_layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  
}

#pragma mark _数据请求————————————————————————————

//治疗发布数据请求
- (void)requestOneData{
   NSString *url = @"http://www.enuo120.com/index.php/app/publish/zl";
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handelWithZlData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
- (void)handelWithZlData:(NSDictionary *)dic{
    NSArray *arr = dic[@"data"];
    
    for (NSDictionary *temp  in arr) {
        DanZlModel *model = [DanZlModel danZlModel:temp];
        [self.twoDataArray addObject:model];
    }[self.collectionView reloadData];
}



//诊断发布数据请求
- (void)requestTwoData{
    NSString *url = @"http://www.enuo120.com/index.php/app/publish/zd";
    
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    
    [mager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handelWithZdData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}


- (void)handelWithZdData:(NSDictionary *)dic{
    NSArray *arr = dic[@"data"];
    for (NSDictionary *temp in arr) {
        DanZdModel *model = [DanZdModel DanZdModelInitWithData:temp];
        
        [self.oneDataArray addObject:model];
        
    }[self.collectionView reloadData];
}


#pragma mark _集合视图delegate
//
//返回集合视图的分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;//返回20个分区
}
//返回不同分区对应的item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.segmented.selectedSegmentIndex == 0) {
        return self.oneDataArray.count ;
    }else{
        return  self.twoDataArray.count;
    }
   
}

//配置不同分区的item内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (_segmented.selectedSegmentIndex == 0) {
        DanDanViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        DanZdModel *model = self.oneDataArray[indexPath.row];
       cell.contentView.backgroundColor = [UIColor whiteColor];
        
       cell.bgView.backgroundColor = [UIColor clearColor];
        cell.titleLabel.text= model.zz;
        
        cell.contentView.layer.cornerRadius = 16.0;
        cell.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.contentView.layer.borderWidth = 1.0;
        cell.contentView.layer.masksToBounds = YES;
//        
//        cell.bgView.layer.shadowColor = [UIColor  blackColor].CGColor;//shadowColor阴影颜色
//        cell.bgView.layer.shadowOffset = CGSizeMake(1,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//        cell.bgView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
//        cell.bgView.layer.shadowRadius = 2;
      

        
        
        return cell;

    }else{
        DanDanViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        //cell.contentView.backgroundColor = [UIColor whiteColor];
        DanZlModel *model = self.twoDataArray[indexPath.row];
        
        cell.bgView.backgroundColor = [UIColor clearColor];
        cell.titleLabel.text= model.ill;
        cell.contentView.layer.cornerRadius = 15.0;
        cell.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.contentView.layer.borderWidth = 1.0;
        cell.contentView.layer.masksToBounds = YES;
        
//        cell.bgView.layer.shadowColor = [UIColor  blackColor].CGColor;//shadowColor阴影颜色
//        cell.bgView.layer.shadowOffset = CGSizeMake(1,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//       cell.bgView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
//        cell.bgView.layer.shadowRadius = 2;
        return cell;
    }
    
   }
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.segmented.selectedSegmentIndex == 0) {
        DanZdModel *model = self.oneDataArray[indexPath.row];
        DanDanOneController *danVC = [[DanDanOneController alloc]init];
        [self.navigationController pushViewController:danVC animated:YES];
        DanDanViewCell *cell = (DanDanViewCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
 
        
        danVC.receiver = cell.titleLabel.text;
        danVC.cidReceiver = model.cid;
    }else{
//        DanDanTwoController *danVC  = [[DanDanTwoController alloc]init];
//        
//        [self.navigationController pushViewController:danVC animated:YES];
//        DanDanViewCell *cell = (DanDanViewCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
//        
//        
//        danVC.receiver = cell.titleLabel.text;
        DanZlModel *model = self.twoDataArray[indexPath.row];
        DanZlIntroViewController *danVC = [[DanZlIntroViewController alloc]init];
        UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:danVC];
        danVC.receiver = model.ill;
        danVC.cidReceiver = model.cid;
        [self presentViewController:naVC animated:YES completion:^{
            
        }];
    }
}


- (void)handleChangeSegmentWithValue:(UISegmentedControl *)sender{
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            
            _layout.itemSize = CGSizeMake((kScreenWidth - 66)/3-10, 35);
            //4.设置最小行间距
            _layout.minimumLineSpacing = 15;
            //5.设置最小item的间距
            _layout.minimumInteritemSpacing = 10;
          
      self.collectionView.collectionViewLayout = _layout;
            //[self.collectionView reloadData];
            [self.oneDataArray removeAllObjects];
            [self requestTwoData];
        
            break;
        case 1:
            
            
            _layout.itemSize = CGSizeMake((kScreenWidth - 66)/2-10, 35);
            //4.设置最小行间距
            _layout.minimumLineSpacing = 15;
            //5.设置最小item的间距
            _layout.minimumInteritemSpacing = 10;
         
self.collectionView.collectionViewLayout = _layout;
            [self.twoDataArray removeAllObjects];
            [self requestOneData];
           

            break;
        
        default:
            break;
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.segmented.selectedSegmentIndex == 0) {
        return CGSizeMake((kScreenWidth - 66)/3-10, 35);
    }else{
        return CGSizeMake((kScreenWidth - 66)/2-10, 35);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
