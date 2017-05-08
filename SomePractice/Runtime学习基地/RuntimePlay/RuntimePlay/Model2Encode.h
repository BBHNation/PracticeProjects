//
//  Model2Encode.h
//  RuntimePlay
//
//  Created by 白彬涵 on 2017/4/25.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//
/// 这里是使用Runtime来遍历实例变量来归档,还可以访问内部实例变量

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface Model2Encode : NSObject<NSCoding>

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *mother;
@property (nonatomic, strong) NSString *father;
@property (nonatomic, strong) NSString *wife;
@property (nonatomic, strong) NSString *girlFriend;
@property (nonatomic, strong) NSString *boyFriend;
- (void)setHelloString:(NSString *)content;

/// 解码
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

/// 编码
- (void)encodeWithCoder:(NSCoder *)aCoder;

@end
