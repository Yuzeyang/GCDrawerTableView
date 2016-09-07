//
//  GCArticleModel.h
//  GCTableViewAnimationOne
//
//  Created by 宫城 on 16/9/6.
//  Copyright © 2016年 宫城. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GCArticleModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, assign) NSUInteger commentsCount;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *content;

@end
