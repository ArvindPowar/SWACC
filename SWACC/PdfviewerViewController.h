//
//  PdfviewerViewController.h
//  SWACC
//
//  Created by Infinitum on 02/01/17.
//  Copyright © 2017 com.keenan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface PdfviewerViewController : UIViewController<UIScrollViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain)NSString *pdfStr;
@property(nonatomic,retain)IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollFront;
@property (nonatomic, retain) IBOutlet UIImageView *BackImgVw1;
@property (nonatomic, retain) UIImage *image;

@end
