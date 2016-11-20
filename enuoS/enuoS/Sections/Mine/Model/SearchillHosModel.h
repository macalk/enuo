//
//  SearchillHosModel.h
//  enuoS
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchillHosModel : NSObject
@property (nonatomic,copy)NSString *ill;
@property (nonatomic,copy)NSString *photo;
@property (nonatomic,copy)NSString *dep_id;
@property (nonatomic,copy)NSString *PID;
@property (nonatomic,copy)NSString *dep_name;
@property (nonatomic,copy)NSString *lowprice;
@property (nonatomic,copy)NSString *heightprice;
@property (nonatomic,copy)NSString *cycle;
@property (nonatomic,strong)NSArray *hos;



- (id)initWithDic:(NSDictionary *)dic;

+ (id)searchillHosModelInitWithDic:(NSDictionary *)dic;




@end
