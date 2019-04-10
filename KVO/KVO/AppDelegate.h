//
//  AppDelegate.h
//  KVO
//
//  Created by mac@hwdev on 2019/4/9.
//  Copyright © 2019 wangtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

