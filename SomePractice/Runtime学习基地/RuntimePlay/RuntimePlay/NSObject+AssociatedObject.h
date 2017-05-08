//
//  NSObject+AssociatedObject.h
//  RuntimePlay
//
//  Created by 白彬涵 on 2017/4/25.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface NSObject (AssociatedObject)

@property (nonatomic, strong) NSString *name;

- (instancetype)initWithContent:(NSString *)content;
- (void)describe;

@end
