//
//  NSObject+Mykvo.h
//  KVO
//
//  Created by mac@hwdev on 2019/4/9.
//  Copyright © 2019 wangtao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Mykvo)

- (void)wt_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;


@end

NS_ASSUME_NONNULL_END
