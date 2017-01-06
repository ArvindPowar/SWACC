//
//  ChatUserListViewController.h
//  SWACC
//
//  Created by Infinitum on 16/11/16.
//  Copyright © 2016 com.keenan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface ChatUserListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UISearchBarDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSURL *rest_url;
    BOOL isSearching;
    NSMutableArray *filteredContentList;
}
@property(nonatomic,retain) NSMutableArray *userListArray,*groupListArray,*msgListArray;
@property(nonatomic,retain) AppDelegate * appDelegate;
@property(nonatomic,retain) UISearchBar *searchBar;
@property(nonatomic,retain)    UIView *navigationView, *lineView;
@property(nonatomic,retain)UIImageView *activityImageView;
@property(nonatomic,retain)NSString *StrMain,*chatStrMain;
@property(nonatomic,retain) IBOutlet UITableView *userlistTableView;
@property(nonatomic,retain) UILabel *msgLbl;

-(void)reloadTableViewData;

@end
