//
//  NSObject+Mykvo.m
//  KVO
//
//  Created by mac@hwdev on 2019/4/9.
//  Copyright © 2019 wangtao. All rights reserved.
//

#import "NSObject+Mykvo.h"
#import <objc/message.h>
#import <objc/runtime.h>

@implementation NSObject (Mykvo)

- (void)wt_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context
{
    
    
    //1.新建一个子类NSKVONotifying_myKvoName
    NSString *className = [NSString stringWithFormat:@"WTKVONotifying_%@",NSStringFromClass(self.class)];
    
    Class myclass  = objc_allocateClassPair([self class], className.UTF8String, 0);
    
    objc_registerClassPair(myclass);
    
    
    //2,重写setName方法
   // class_addMethod(myclass,@selector(setName:) ,class_getMethodImplementation(self.class, @selector(setName:)), method_getTypeEncoding(class_getInstanceMethod([self class],@selector(setName:))));
    

    class_addMethod(myclass, @selector(setName:), (IMP)setName, method_getTypeEncoding(class_getInstanceMethod([self class],@selector(setName:))));

    
    //3.修改isa指针
    object_setClass(self, myclass);
    
    //4.给self绑定observe(可以为任意名字)属性,这样才能发送消息,实现回调
    
     objc_setAssociatedObject(self , @"observe", observer, OBJC_ASSOCIATION_ASSIGN);
    
    
}

//这里需要注意,当前调用setName的调用者是我们新建的person子类，并不是之前的self
void setName(id self ,SEL _cmd ,NSString *new){

    //5.调用父类的setName方法
    Class  currentClass = [self class];
    
    //6.修改指针指向
    object_setClass(self, class_getSuperclass(currentClass));
   
   //7,给父类发送消息（就是调用父类的setName方法），这里发送消息时,虽然是给self发送的消息，但实际上在y上一步已经把指向self的指针修改成指向父类了,所以此时给self发消息就是给self的父类发送消息.
    objc_msgSend(self,@selector(setName:),new);
    
    
    //8.将指针修改回子类
    
    object_setClass(self, currentClass);
    
    //9.得到父类的绑定属性,用于之后发送观察者的回调消息
    id observer = objc_getAssociatedObject(self, @"observe");
    
    if (observer) {
        
         objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:),@"name",self,@{@"new":@"dddd",@"kind":@"1"},nil);
        
    }
    
    
    NSLog(@"lail");
    
}

//- (void)setName:(NSString *)name{
//
//
//
//    NSLog(@"%@",name);
//
//}

@end
