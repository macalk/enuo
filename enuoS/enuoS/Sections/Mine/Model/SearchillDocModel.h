//
//  SearchillDocModel.h
//  enuoS
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchillDocModel : NSObject
@property (nonatomic,copy)NSString *ill;
@property (nonatomic,copy)NSString *photo;
@property (nonatomic,strong)NSDictionary *hos;
@property (nonatomic,strong)NSArray *doc;


- (id)initWithDic:(NSDictionary *)dic;
+ (id)searchIllDocModelInithWithDic:(NSDictionary *)dic;
@end
