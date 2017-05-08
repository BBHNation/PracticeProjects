//
//  PersonEntity.h
//  TestForDicModel
//
//  Created by 白彬涵 on 2017/4/24.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"
@interface PersonEntity : BaseEntity

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gender;

@end
