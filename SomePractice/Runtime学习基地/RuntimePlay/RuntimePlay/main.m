//
//  main.m
//  RuntimePlay
//
//  Created by 白彬涵 on 2017/4/25.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Json2Model.h"
#import "Model2Encode.h"
#import "MethodSwizzling.h"
#import "NSObject+AssociatedObject.h"

/**
 使用Json2Model
 */
void useJson2Model() {
    NSDictionary *dic = @{@"name":@"BBH",
                          @"gender":@"man",
                          @"grade":@[@1,@2,@4,@{@"dic":@"haha"}],
                          @"others":@{@"girlFriend":@"RQQ",@"mother":@"WYB"}};
    Json2Model *me = [Json2Model initWithDic:dic];
    [me simpleDescribe];
}

/**
 使用Model归档编码
 */
void useMode2Encode() {
    Model2Encode *mo = [Model2Encode new];
    mo.firstName = @"B";
    mo.lastName = @"BH";
    mo.age = @"22";
    mo.mother = @"WYB";
    mo.father = @"BYG";
    mo.wife = @"RQQ";
    mo.girlFriend = @"RQQ";
    mo.boyFriend = @"NO";
    mo.gender = @"man";
    [mo setHelloString:@"hello"];
    
    // 这里使用runtime来获取成员变量
    Ivar ivar = class_getInstanceVariable([Model2Encode class], "_hello");
    NSString *helloContent = object_getIvar(mo, ivar);
    NSLog(@"内部变量 hello的内容是%@",helloContent);
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    BOOL success = [NSKeyedArchiver archiveRootObject:mo toFile:[path stringByAppendingString:@"/Hello"]];
    NSLog(@"success is %hhd",success);
    
    Model2Encode *newMo = [NSKeyedUnarchiver unarchiveObjectWithFile:[path stringByAppendingString:@"/Hello"]];
    NSLog(@"name %@",newMo.firstName);
    
    Ivar newIvar = class_getInstanceVariable([Model2Encode class], "_hello");
    NSString *newHelloContent = object_getIvar(newMo, newIvar);
    NSLog(@"内部变量 new hello的内容是%@",newHelloContent);
}

/**
 使用方法交换
 */
void useMethodSwizzling() {
    MethodSwizzling *me = [MethodSwizzling new];
    [me description];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSObject *ob = [[NSObject alloc] initWithContent:@"world"];
        ob.name = @"hello";
        [ob describe];
    }
    return 0;
}



