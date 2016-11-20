//
//  FindHosModel.h
//  enuoS
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindHosModel : NSObject
@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *photo;
@property (nonatomic,copy)NSString *hos_name;
@property (nonatomic,copy)NSString *rank;
@property (nonatomic,copy)NSString *yb;
@property (nonatomic,copy)NSString *zhen;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *ill;


- (id)initWithDic:(NSDictionary *)dic;

+ (id)findHosModelInithWithDic:(NSDictionary *)dic;
@end
