//
//  SearchillDocModel.m
//  enuoS
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchillDocModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation SearchillDocModel


- (id)initWithDic:(NSDictionary *)dic{
    self =[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];
        
    }return self;
}

+ (id)searchIllDocModelInithWithDic:(NSDictionary *)dic{
    return [[SearchillDocModel alloc]initWithDic:dic];
}


@end
