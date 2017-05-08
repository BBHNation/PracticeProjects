//
//  Json2Model.h
//  RuntimePlay
//
//  Created by 白彬涵 on 2017/4/25.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

/// 这里是使用Json到Model的转换，使用Runtime来获取属性和设置属性信息
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface Json2Model : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSArray *grade;
@property (nonatomic, strong) NSDictionary *others;


+ (instancetype)initWithDic:(NSDictionary *)dic;
- (void)simpleDescribe;

@end
