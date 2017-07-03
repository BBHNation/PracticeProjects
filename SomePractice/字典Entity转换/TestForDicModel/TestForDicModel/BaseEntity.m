//
//  baseEntity.m
//  demo
//
//  Created by zhongbo.chen on 15/8/29.
//  Copyright (c) 2015年 zhongbo. All rights reserved.
//

#import "BaseEntity.h"

@implementation BaseEntity
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        // 存储类属性的名字列表
        NSArray *propertyNames = [self propertyNames];
        // 存储类属性对应的 类
        NSDictionary *propertClassByName = [self propertyClassesByName];
        
        NSObject *i = [self invokeWithMethodName:@"entityClassDictionary" arg1:nil];
        NSDictionary *entityClassDic = nil;
        if (i) {
            entityClassDic = (NSDictionary *)i;
        }
        
        // 遍历类属性名字列表，将属性内容添加进自己类中
        [propertyNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *key = (NSString *)obj;
            Class classType = propertClassByName[key];//获取相应的类
            if (classType == [NSString class]) {
                //如果是NSString类型
                NSString *value = dic[key] ? [NSString stringWithFormat:@"%@", dic[key]] : @"";
                [self setValue:value forKey:key];
            }
            else if (classType == [NSNumber class]) {
                //如果是NSNumber类型
                NSString *value = dic[key] ? [NSString stringWithFormat:@"%@", dic[key]] : @"";
                NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
                NSNumber *numValue = [numberFormatter numberFromString:value]?:@(-1);
                [numberFormatter release];
                [self setValue:numValue forKey:key];
            }
            else if (classType == [NSArray class]){
                //如果是NSArray类型
                NSArray *array = dic[key];
                if (array == nil ||
                    ![array isKindOfClass:[NSArray class]] ||
                    array.count == 0) {
                    return;
                }
                NSInteger count = array.count;
                NSMutableArray *brr = [NSMutableArray array];
                for (int i = 0; i < count; ++i) {
                    if ([array[i] isKindOfClass:[NSArray class]]) {
                        
                    }else if ([array[i] isKindOfClass:[NSDictionary class]]) {
                        if (entityClassDic) {
                            Class cls = entityClassDic[key];
                            id theObject = class_createInstance(cls, sizeof(unsigned));
                            //                    id obj = [theObject init];
                            id obj = [theObject invokeWithMethodName:@"initWithDic:" arg1:array[i]];
                            [brr addObject:obj];
                            [obj release];
                        }
                    }else{/*.. 尚未考虑其他类型*/}
                }
                [self setValue:brr forKey:key];
            }
            else{
                //其他类型
                if ([dic[key] isKindOfClass:[NSDictionary class]]) {
                    //如果是NSDictinoary类型
                    id theObject = class_createInstance(classType, sizeof(unsigned));// 相当于alloc
                    //                    id obj = [theObject init];
                    id obj = [theObject invokeWithMethodName:@"initWithDic:" arg1:dic[key]];
                    if (obj) {
                        [self setValue:obj forKey:key];
                        [obj release];
                    }
                }
            }
        }];
    }
    return self;
}

- (SEL)creatGetterWithPropertyName: (NSString *) propertyName{
    //返回get方法
    return NSSelectorFromString(propertyName);
}

// 这里用着传入model属性名，返回属性值
- (NSObject *)invokeWithMethodName:(NSString *)methodName arg1:(void *)arg1{
    SEL getSel = [self creatGetterWithPropertyName:methodName];
    if ([self respondsToSelector:getSel]) {
         //获得类和方法的签名
         NSMethodSignature *signature = [self methodSignatureForSelector:getSel];

         //从签名获得调用对象
         NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
         //设置target
         [invocation setTarget:self]; // atIndex 0
         //设置selector
         [invocation setSelector:getSel]; // atIndex 1
        if (arg1) {
            [invocation setArgument:&arg1 atIndex:2];
        }
         //接收返回的值
         NSObject *__unsafe_unretained returnValue = nil;
         //调用
         [invocation invoke];
         //接收返回值
         [invocation getReturnValue:&returnValue];
        return returnValue;
     }
    return nil;
}


// ...=================================private

/**
 获取本类的属性名字数组（一直到NSObject层）

 @return 返回包含有 属性名 的数组
 */
- (NSArray *)propertyNames
{
    NSMutableArray *array = [NSMutableArray array];
    Class supClass = [self class];// 获取本类的 类
    // 一层一层的向上循环获取本类的属性列表
    while (supClass != [NSObject class])
    {
        // Get the list of properties
        // 当自己不是NSObject类的时候
        unsigned int propertyCount;
        // 获取注册类的属性列表，第一个参数是类，第二个参数是接收类属性数目的变量
        objc_property_t *properties = class_copyPropertyList([supClass class],
                                                             &propertyCount);
        for (int i = 0; i < propertyCount; i++)
        {
            // Get property name
            objc_property_t property = properties[i];
            const char *propertyName = property_getName(property);
            NSString *key = @(propertyName);

            // Add to array
            if ([key isEqualToString: @"entityClassDictionary"]){
                continue;
            }
            [array addObject:key];
        }
        // Remember to free the list because ARC doesn't do that for us
        free(properties);
        supClass = [supClass superclass];
    }
    
    return array;
}


/**
 保存类属性名字对应的 类，例如 name属性对应类NSString

 @return 返回字典保存例如@{@"name":@"NSString"}
 */
- (NSDictionary *)propertyClassesByName
{
    // Check for a cached value (we use _cmd as the cache key,
    // which represents @selector(propertyNames))
    NSMutableDictionary *dictionary = objc_getAssociatedObject([self class], _cmd);
    if (dictionary)
    {
        return dictionary;
    }

    // Loop through our superclasses until we hit NSObject
    dictionary = [NSMutableDictionary dictionary];
    Class subclass = [self class];
    while (subclass != [NSObject class])
    {
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(subclass,
                                                             &propertyCount);
        for (int i = 0; i < propertyCount; i++)
        {
            // Get property name
            objc_property_t property = properties[i];
            const char *propertyName = property_getName(property);
            NSString *key = @(propertyName);

            // Check if there is a backing ivar
            char *ivar = property_copyAttributeValue(property, "V");
            if (ivar)
            {
                // Check if ivar has KVC-compliant name
                NSString *ivarName = @(ivar);
                if ([ivarName isEqualToString:key] ||
                    [ivarName isEqualToString:[@"_" stringByAppendingString:key]])
                {
                    // Get type
                    Class propertyClass = nil;
                    char *typeEncoding = property_copyAttributeValue(property, "T");// 第二个参数"V"获取变量名,"T"获取类型
                    switch (typeEncoding[0])
                    {
                        case 'c': // Numeric types
                        case 'i':
                        case 's':
                        case 'l':
                        case 'q':
                        case 'C':
                        case 'I':
                        case 'S':
                        case 'L':
                        case 'Q':
                        case 'f':
                        case 'd':
                        case 'B':
                        {
                            propertyClass = [NSNumber class];
                            break;
                        }
                        case '*': // C-String
                        {
                            propertyClass = [NSString class];
                            break;
                        }
                        case '@': // Object
                        {
                            // The objcType for classes will always be at least 3 characters long
                            if (strlen(typeEncoding) >= 3)
                            {
                                // Copy the class name as a C-String
                                char *cName = strndup(typeEncoding + 2, strlen(typeEncoding) - 3);

                                // Convert to an NSString for easier manipulation
                                NSString *name = @(cName);

                                // Strip out and protocols from the end of the class name
                                NSRange range = [name rangeOfString:@"<"];
                                if (range.location != NSNotFound)
                                {
                                    name = [name substringToIndex:range.location];
                                }
                                
                                // Get class from name, or default to NSObject if no name is found
                                propertyClass = NSClassFromString(name) ?: [NSObject class];
                                free(cName);
                            }
                            break;
                        }
                        case '{': // Struct
                        {
                            propertyClass = [NSValue class];
                            break;
                        }
                        case '[': // C-Array
                        case '(': // Enum
                        case '#': // Class
                        case ':': // Selector
                        case '^': // Pointer
                        case 'b': // Bitfield
                        case '?': // Unknown type
                        default:
                        {
                            propertyClass = nil; // Not supported by KVC
                            break;
                        }
                    }
                    free(typeEncoding);
                    
                    // If known type, add to dictionary
                    if (propertyClass) dictionary[@(propertyName)] = propertyClass;
                }
                free(ivar);
            }
        }
        free(properties);
        subclass = [subclass superclass];
    }
    
    // Cache and return dictionary
    objc_setAssociatedObject([self class], _cmd, dictionary, 
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return dictionary;
}


@end
