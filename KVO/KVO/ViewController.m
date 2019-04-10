//
//  ViewController.m
//  KVO
//
//  Created by mac@hwdev on 2019/4/9.
//  Copyright © 2019 wangtao. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+Mykvo.h"
@interface ViewController ()
{
    
    Person *person;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    
     [super viewDidLoad];
    
     person = [[Person alloc]init];
   
    
    //添加观察者
    [person wt_addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew) context:nil];
    
    
    
    UIButton *   button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(touchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

- (void)touchAction
{
    
     static  int a =0;

//    [person willChangeValueForKey:@"woman"];
//    [person didChangeValueForKey:@"woman"];
//
//     person.woman.husband = [NSString stringWithFormat:@"%d",a++];
//    [person.woman.womanArray addObject:@"223"];
    
    person.name = [NSString stringWithFormat:@"%d",a++];
    
   // NSMutableArray *arr = [person.woman mutableArrayValueForKey:@"womanArray"];

   // [arr addObject:@"2"];
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    NSLog(@"%@",change);
    
    
    
    
}


//释放观察者
-(void)dealloc
{
    
    [person removeObserver:self forKeyPath:@"woman"];
    
}



/*
 
 总结
 
 1.观察者观察的属性包含另外一个对象时,要想观察另外一个对象的某一个属性,观察时直接 [person addObserver:self forKeyPath:@"woman.husband" options:(NSKeyValueObservingOptionNew) context:nil];就可以实现了。
 
 如果想观察另一个对象全部属性, 需要进行属性依赖实现+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key 这个方法,将依赖添加至集合中.
 
 2.观察的key包含集合类型时,需要实现    NSMutableArray *arr = [person.woman mutableArrayValueForKey:@"womanArray"];
这个方法，才能监测到容器类的变化。
 
 3.手动触发KVO
 
 实现+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
 这个方法  return NO 关闭自动触发,并在需要触发KVO的时候调用  [person willChangeValueForKey:@"woman"] 和[person didChangeValueForKey:@"woman"] 这两个方法,即使观察的属性值没有改变也可以触发,系统自动触发KVO也是通过这两个方法。
 
 
 
 
 
 */
@end
