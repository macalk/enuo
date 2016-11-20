//
//  ServeViewController.m
//  enuo4
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ServeViewController.h"

@interface ServeViewController ()
@property (nonatomic,strong)UIWebView *webView;
@end

@implementation ServeViewController
- (UIWebView *)webView{
    if (!_webView) {
        self.webView = [[UIWebView alloc]init];
      
    }return _webView;
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
    self.hidesBottomBarWhenPushed = true;
    self.webView.frame = self.view.bounds;
    _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    
    
    [self loadString];
    [self.view addSubview:_webView];
}
- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

// 让浏览器加载指定的字符串,使用m.baidu.com进行搜索
- (void)loadString
{
    // 1. URL 定位资源,需要资源的地址
    NSString *urlStr = @"http://www.enuo120.com/index.php/public/term_service";
    //NSString *urlStr = @"http://www.enuo120.com/index.php/wechat/nurse_vote";
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
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
