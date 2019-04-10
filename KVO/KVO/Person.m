//
//  Person.m
//  KVO
//
//  Created by mac@hwdev on 2019/4/9.
//  Copyright © 2019 wangtao. All rights reserved.
//

#import "Person.h"
@implementation Person


//添加被观察者的属性依赖
+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
    
    //获取到方法返回的集合
     NSSet *set = [super keyPathsForValuesAffectingValueForKey:key];
    
    if ([key isEqualToString:@"woman"]) {
        
        //添加属性依赖
        NSSet *affectingKeys = [NSSet setWithObjects:@"_woman.husband",@"_woman.womanArray",nil];
        set = [set setByAddingObjectsFromSet:affectingKeys];
        
        return set;
        
    }
    
    return set;
    
}

//是否需要自动触发
//+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
//{
//
//    return YES;
//}

- (void)setName:(NSString *)name
{
    
    NSLog(@"我是person类的set方法,我被调用了");
}

@end
