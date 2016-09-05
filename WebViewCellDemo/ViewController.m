//
//  ViewController.m
//  WebViewCellDemo
//
//  Created by xiayong on 16/8/30.
//  Copyright © 2016年 bianguo. All rights reserved.
//

#import "ViewController.h"
#import "htmlTableViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{

}
@property (nonatomic,strong) IBOutlet UITableView * myTableView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.myTableView.delegate= self;
    self.myTableView.dataSource = self;

   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * array = @[@"这是加载HTML标签",@"这是加载HTML数据，图文结合的"];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = array[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//设置cell的箭头
    return cell;
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
   }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.myTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    htmlTableViewController *  vc = [[htmlTableViewController alloc] init];
    if (indexPath.row==0) {
        vc.htmlNum=1;
    }else{
        vc.htmlNum=2;
    }
    [self.navigationController pushViewController:vc animated:YES];
}


@end
