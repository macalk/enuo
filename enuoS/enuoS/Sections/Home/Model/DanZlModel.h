//
//  DanZlModel.h
//  enuoS
//
//  Created by apple on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DanZlModel : NSObject

@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *ill;
@property (nonatomic,copy)NSString *zl_method;
@property (nonatomic,copy)NSString *inspect;
@property (nonatomic,copy)NSString *zl_time;

@property (nonatomic,copy)NSString *drug_choice;

@property (nonatomic,copy)NSString *statue;
@property (nonatomic,copy)NSString *pub_time;
@property (nonatomic,copy)NSString *sub_time;
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,copy)NSString *sort_order;


- (id)initWithDic:(NSDictionary *)dic;

+ (id)danZlModel:(NSDictionary *)dic;




@end
