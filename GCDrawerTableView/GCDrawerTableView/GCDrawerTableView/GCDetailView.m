//
//  GCDetailView.m
//  GCTableViewAnimationOne
//
//  Created by 宫城 on 16/9/6.
//  Copyright © 2016年 宫城. All rights reserved.
//

#import "GCDetailView.h"
#import "Masonry.h"
#import <CoreText/CoreText.h>

@interface GCDetailView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation GCDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.contentLabel = [[UILabel alloc] init];
        
        [self addSubview:self.imageView];
        [self addSubview:self.contentLabel];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(@(20));
            make.top.equalTo(@(20));
            make.trailing.equalTo(@(-20));
            make.height.equalTo(@(200));
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(@(20));
            make.top.equalTo(self.imageView.mas_bottom).offset(20);
            make.trailing.equalTo(@(-20));
            make.height.equalTo(@(40));
        }];
    }
    return self;
}

- (void)configDetailViewWithArticleModel:(GCArticleModel *)articleModel {
    [self.imageView setImage:articleModel.image];
    self.contentLabel.text = articleModel.content;
}

@end
