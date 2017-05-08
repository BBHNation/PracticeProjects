//
//  MethodSwizzling.m
//  RuntimePlay
//
//  Created by 白彬涵 on 2017/4/25.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

#import "MethodSwizzling.h"
#import <objc/runtime.h>
@implementation MethodSwizzling

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[self class] swizzleMethods:[self class] originalSelector:@selector(description) swizzledSelector:@selector(hello)];
    });
}


/**
 交换方法

 @param class 类
 @param origSel 原方法选择器
 @param swizSel 新方法选择器
 */
+ (void)swizzleMethods:(Class )class originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel {
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method swizMethod = class_getInstanceMethod(class, swizSel);
    
    // 先尝试給源方法添加实现，这里是为了避免源方法没有实现的情况
    BOOL didAddMethod = class_addMethod(class, origSel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
    if (didAddMethod) {
         // 添加成功：将源方法的实现替换到交换方法的实现
        class_replaceMethod(class, swizSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
        NSLog(@"添加后，替换");
    }else {
        // 添加失败：说明源方法已经有实现，直接将两个方法的实现交换即可
        method_exchangeImplementations(origMethod, swizMethod);
        NSLog(@"直接交换");
    }
}

- (void)hello {
    NSLog(@"hello");
}

@end
