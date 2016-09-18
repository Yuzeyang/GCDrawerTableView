//
//  GCTableViewCell.h
//  GCTableViewAnimationOne
//
//  Created by 宫城 on 16/9/6.
//  Copyright © 2016年 宫城. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCArticleModel.h"

FOUNDATION_EXPORT NSString *const GCTableViewCellIdentifier;

typedef void(^GCCellSelectBlock)();
typedef void(^GCCellDeselectBlock)();

@interface GCTableViewCell : UITableViewCell

- (void)addSelectBlock:(GCCellSelectBlock)block;
- (void)addDeselectBlock:(GCCellDeselectBlock)block;
- (void)configCellWithArticleModel:(GCArticleModel *)articleModel;
- (void)selectToShowDetailWithContentOffsetY:(CGFloat)contentOffsetY;

@end
