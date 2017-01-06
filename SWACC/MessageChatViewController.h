//
//  MessageChatViewController.h
//  SWACC
//
//  Created by Infinitum on 16/11/16.
//  Copyright © 2016 com.keenan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MessageVO.h"
@interface MessageChatViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>
{
    NSURL *rest_url;
    NSMutableArray *filteredContentList;
}
@property(nonatomic,retain) AppDelegate * appDelegate;
@property(nonatomic,retain) IBOutlet UITableView *chatTableView;
@property(nonatomic,retain) NSMutableArray *msgListArray,*selectMsgArray;
@property(nonatomic,retain) IBOutlet UITextField *msgText;
@property(nonatomic,retain) IBOutlet UIButton *sendBtn,*attachmentBtn;
@property(nonatomic,retain)UILongPressGestureRecognizer *lpgr;
@property(nonatomic,retain)UIImageView *activityImageView;
@property(nonatomic,retain)MessageVO *MsgVO;
@property(nonatomic,retain)NSString *StrMain,*commonURL,*forwardmsgStr;
@property(nonatomic,retain)UIView *navigationView;
@property(nonatomic,retain)UILabel *titleLbl;
@property(nonatomic,readwrite)BOOL resentMsg;
@property(nonatomic,readwrite) BOOL isMenuVisible;
@property(nonatomic,retain) UIButton *menuNameButton;
@property(nonatomic,retain) UIView *clearView;
@property(nonatomic,readwrite)int selectIndex;
@property(nonatomic,retain)UITapGestureRecognizer *tap;
@end
