//
//  htmlTableViewController.m
//  WebViewCellDemo
//
//  Created by xiayong on 16/8/31.
//  Copyright © 2016年 bianguo. All rights reserved.
//

#import "htmlTableViewController.h"
#import "WebCell.h"

@interface htmlTableViewController (){
    NSString *htmlTxtStr;
    NSString *htmlImgStr;
}
@property(nonatomic,strong)NSMutableDictionary *heightDic;//计算webview的高度


@end

@implementation htmlTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[WebCell class] forCellReuseIdentifier:@"webCell"];

    
    self.heightDic = [[NSMutableDictionary alloc] init];
    // 注册加载完成高度的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti:) name:@"WEBVIEW_HEIGHT" object:nil];
    
    //这里用txt文本来代替数据源。
    htmlTxtStr = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"htmlbiqoqian" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    
    htmlImgStr = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"htmlshuju" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_htmlNum==1) {//这是纯文字的 加载html标签的方法
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
        
        
        //    cell.textLabel.text = hptxtStr;
        cell.textLabel.numberOfLines = 0;
        //    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[htmlTxtStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        cell.textLabel.attributedText = attrStr;
        cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
        return cell;


    }else{//这是图文结合的，加载html标签的方法
        WebCell *cell = [tableView dequeueReusableCellWithIdentifier:@"webCell"];
        cell.tag = indexPath.section;
        
        //               // 赋值 把需要的html放里面就好了，不需要其他操作
        
        NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                           "<head> \n"
                           "<style type=\"text/css\"> \n"
                           "body {font-size:42px;}\n"
                           "</style> \n"
                           "</head> \n"
                           "<body>"
                           "<script type='text/javascript'>"
                           "window.onload = function(){\n"
                           "var $img = document.getElementsByTagName('img');\n"
                           "for(var p in  $img){\n"
                           " $img[p].style.width = '100%%';\n"
                           "$img[p].style.height ='auto'\n"
                           "}\n"
                           "}"
                           "</script>%@"
                           "</body>"
                           "</html>",htmlImgStr];
        cell.contentStr = htmls;
        return cell;
        

        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_htmlNum==1) {
        self.tableView.estimatedRowHeight = 44.0f;
        return UITableViewAutomaticDimension;
        
    }else{
        return [[self.heightDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]] floatValue];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 通知
- (void)noti:(NSNotification *)sender
{
    WebCell *cell = [sender object];
    NSLog(@"%@",@(cell.tag));
    
    if (![self.heightDic objectForKey:[NSString stringWithFormat:@"%ld",cell.tag]]||[[self.heightDic objectForKey:[NSString stringWithFormat:@"%ld",cell.tag]] floatValue] != cell.height)
    {
        [self.heightDic setObject:[NSNumber numberWithFloat:cell.height] forKey:[NSString stringWithFormat:@"%ld",cell.tag]];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:cell.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
}

@end
