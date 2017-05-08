//
//  ViewController.m
//  TestForDicModel
//
//  Created by 白彬涵 on 2017/4/24.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

#import "ViewController.h"
#import "BaseEntity.h"
#import "PersonEntity.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dic = @{@"name":@"BBH",@"gender":@"man"};
    PersonEntity *entity = [[PersonEntity alloc] initWithDic:dic];
    NSLog(@"entity is %@",entity);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
