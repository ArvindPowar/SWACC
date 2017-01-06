//
//  AppDelegate.h
//  SWACC
//
//  Created by Infinitum on 09/11/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageVO.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    NSMutableArray *filteredContentList;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property(nonatomic,readwrite) int index,indexs,msgTotalCount;
@property(nonatomic,retain) NSString *deviceToken,*tabStr,*urlStr;
@property(nonatomic,retain)NSString *StrMain,*chatStrMain;
@property(nonatomic,retain)NSMutableArray *msgListArray,*forwardmsgArray,*topnewsArray;
@property(nonatomic,readwrite) BOOL userlistBool,msgchatBool,getuserList,appBackground;
@property(nonatomic,retain) NSString *pushStr,*documentsendStr;
@property(nonatomic,retain)MessageVO *MSGVO;
@property(nonatomic,retain)NSString *fileByteStr,*fileextentions;

@end

