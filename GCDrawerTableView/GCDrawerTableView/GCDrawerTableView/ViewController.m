//
//  ViewController.m
//  GCTableViewAnimationOne
//
//  Created by 宫城 on 16/9/6.
//  Copyright © 2016年 宫城. All rights reserved.
//

#import "ViewController.h"
#import "GCArticleModel.h"
#import "GCTableViewCell.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[GCTableViewCell class] forCellReuseIdentifier:GCTableViewCellIdentifier];
    
    // mock data
    self.dataSource = [NSMutableArray  array];
    for (NSInteger i = 0; i < 10; i++) {
        GCArticleModel *model = [[GCArticleModel alloc] init];
        model.title = [NSString stringWithFormat:@"This is title %ld",i];
        model.updateTime = [NSString stringWithFormat:@"update %ld hour ago",i];
        model.author = @"GongCheng";
        model.createTime = [NSString stringWithFormat:@"update %ld hour ago",i];
        model.commentsCount = i;
        model.image = [UIImage imageNamed:@"Image"];
        model.content = [NSString stringWithFormat:@"Talk is cheap, show me the code. %ld",i];
        [self.dataSource addObject:model];
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GCTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:GCTableViewCellIdentifier];
    [cell configCellWithArticleModel:self.dataSource[indexPath.row]];
    [cell addDeselectBlock:^() {
        for (UIView *subcell in tableView.visibleCells) {
            if (subcell != cell) {
                subcell.alpha = 1;
            }
        }
        tableView.allowsSelection = YES;
        tableView.scrollEnabled = YES;
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GCTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.tableView bringSubviewToFront:cell];
    for (UIView *subcell in tableView.visibleCells) {
        if (subcell != cell) {
            subcell.alpha = 0;
        }
    }
    
    tableView.allowsSelection = NO;
    tableView.scrollEnabled = NO;
    [cell selectToShowDetailWithContentOffsetY:tableView.contentOffset.y];
}

@end
