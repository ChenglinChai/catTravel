//
//  FirstViewController.m
//  catTravel
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FirstViewController.h"
#import "PlaceModel.h"
#import "CellDetailViewController.h"
@interface FirstViewController (){
    
    
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetParame];
    
}

-(void)resetParame{
    
    self.startNumber=0;
}

-(void)getNetData{
    [super getNetData];
   
    NSString *url=[NSString stringWithFormat:placeAllURL,self.type,self.idNumber,@"all"];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self.startNumber],@"start", nil] success:^(AFHTTPRequestOperation * operation , id respondObject) {
        
        if (self.startNumber==0) {
           
             _dataArry=[[NSMutableArray alloc]init];
            [self modelFactory:respondObject];
           
     }else{
            
            [self modelFactory:respondObject];
        
        }
    
        [self refreshTableView];
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        [self refreshTableView];
    }];
    
}
-(void)modelFactory:(id)respondObject{
    NSDictionary *diction=[NSJSONSerialization JSONObjectWithData:respondObject options:NSJSONReadingMutableContainers error:nil];
   
    NSArray *arry=[diction objectForKey:@"items"];
    for (NSDictionary *dic in arry) {
        PlaceModel *model=[[PlaceModel alloc]init];
     
        [self createWithMode:model dic:dic];
        
        [_dataArry addObject:model];
        
    }
    
}

-(void)viewWillShow{
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
