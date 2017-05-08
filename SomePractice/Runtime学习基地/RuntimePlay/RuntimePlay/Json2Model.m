//
//  Json2Model.m
//  RuntimePlay
//
//  Created by 白彬涵 on 2017/4/25.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

#import "Json2Model.h"


@implementation Json2Model

+ (instancetype)initWithDic:(NSDictionary *)dic {
    Json2Model *selfInstance = [Json2Model new];
    
    // 将类信息保存下来
    NSMutableArray *keys = [NSMutableArray array];//本类的属性名字
    NSMutableArray *attributes = [NSMutableArray array];//属性对应的类型
    
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([selfInstance class], &outCount);
    for (int i=0; i<outCount; i++) {
        objc_property_t property = properties[i];
        
        //通过property_getName函数获得属性名字
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];//添加属性名字
        
        //通过property_getAttribute函数可以获得属性的名字和@encode编码
        NSString *propertyAttribute = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        [attributes addObject:propertyAttribute];//添加属性名字和@encode编码
    }
    //手动释放properties，因为Runtime不是用ARC来管理内存
    free(properties);
    
    // 将Dic中的信息添加进入类对象中
    for (NSString *key in keys) {
        if ([dic valueForKey:key]==nil) continue;
        [selfInstance setValue:[dic valueForKey:key] forKey:key];
    }
    
    return selfInstance;
}

- (void)simpleDescribe {
    NSLog(@"\nmy name is %@, gender is %@\n",_name,_gender);
    NSLog(@"grade is: ");
    for (int i=0; i<_grade.count; i++) {
        NSLog(@"%@ ",_grade[i]);
    }
    NSLog(@"\n");
    
    NSLog(@"others is: ");
    for (NSString *key in _others.allKeys) {
        NSLog(@"%@:%@ ",key,[_others valueForKey:key]);
    }
}


@end
