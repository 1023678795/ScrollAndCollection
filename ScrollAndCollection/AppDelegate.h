//
//  AppDelegate.h
//  ScrollAndCollection
//
//  Created by aa on 2018/3/23.
//  Copyright © 2018年 金刚葫芦娃. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

