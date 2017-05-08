//
//  Model2Encode.m
//  RuntimePlay
//
//  Created by 白彬涵 on 2017/4/25.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//
/// 这里使用了Runtime来获取类成员变量
#import "Model2Encode.h"

@implementation Model2Encode{
    NSString *_hello;
}

/**
 这里是访问内部变量，设置内容

 @param content 需要设置的内容
 */
- (void)setHelloString:(NSString *)content {
    _hello = content;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int outCount;
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        for (int i=0; i<outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
            
            //从aDecoder解码信息再将信息添加到类对象中
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    for (int i=0; i<outCount; i++) {
        Ivar ivar = ivars[i];
        NSString *key = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
}

@end
