//
//  DocumentViewController.h
//  SWACC
//
//  Created by Infinitum on 02/01/17.
//  Copyright © 2017 com.keenan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface DocumentViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain)NSMutableArray *documentArray;
@property(nonatomic,retain) IBOutlet UITableView *tableViewMain;
@property(nonatomic,retain) UILabel *msgLbl;

@end
