//
//  DocOrderViewController.h
//  enuoS
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocOrderViewController : UIViewController


@property (nonatomic,copy)NSString *hosId;
@property (nonatomic,copy)NSString *hosName;
@property (nonatomic,copy)NSString *docId;
@property (nonatomic,copy)NSString *docName;

@property (nonatomic,strong)NSArray *weekListArray;
@property (nonatomic,strong)NSArray *dayListArray;

@property (nonatomic,strong)NSArray *markOneArray;
@property (nonatomic,strong)NSArray *markTwoArray;




@end
