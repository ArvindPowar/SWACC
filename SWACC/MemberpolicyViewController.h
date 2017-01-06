//
//  MemberpolicyViewController.h
//  SWACC
//
//  Created by Infinitum on 07/12/16.
//  Copyright © 2016 com.keenan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface MemberpolicyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain)NSMutableArray *menuNameArray,*tempArray;
@property(nonatomic,retain) IBOutlet UITableView *tableViewMain;

@end
