//
//  NSObject+AssociatedObject.m
//  RuntimePlay
//
//  Created by 白彬涵 on 2017/4/25.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//
/// 这里使用Runtime来关联对象，添加公共属性，私有变量，关联KVO观察者等。
#import "NSObject+AssociatedObject.h"

@interface NSObject ()

//添加私有属性
@property (nonatomic, strong) NSString *content;

@end

@implementation NSObject (AssociatedObject)

- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, @selector(name));
}

- (void)setContent:(NSString *)content {
    objc_setAssociatedObject(self, @selector(content), content, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)content {
    return objc_getAssociatedObject(self, @selector(content));
}

- (instancetype)initWithContent:(NSString *)content {
    self.content = content;
    return self;
}

- (void)describe {
    NSLog(@"name is %@\nconent is %@",self.name,self.content);
}

@end
