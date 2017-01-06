//
//  MenuViewController.h
//  SWACC
//
//  Created by Infinitum on 10/11/16.
//  Copyright © 2016 com.keenan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain) IBOutlet UITableView *tableViewMain;
@property(nonatomic,readwrite)int index;
@property(nonatomic,retain)NSMutableArray *testArray;
@end
