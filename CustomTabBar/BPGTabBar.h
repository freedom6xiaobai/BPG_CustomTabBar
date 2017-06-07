//
//  BPGTabBar.h
//  BPG_New
//
//  Created by bai on 2017/2/23.
//  Copyright © 2017年 bai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPGTabBar : UITabBar

/**
点击plusButton按钮
 */
@property(nonatomic, copy)void(^operationBlock)();
@end
