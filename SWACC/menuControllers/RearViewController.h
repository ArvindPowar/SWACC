/*

 Copyright (c) 2013 Joan Lluch <joan.lluch@sweetwilliamsl.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished
 to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.

 Original code:
 Copyright (c) 2011, Philip Kluz (Philip.Kluz@zuui.org)
*/

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "HomeViewController.h"
@interface RearViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,retain) AppDelegate *appDelegate;
@property (nonatomic, retain) IBOutlet UITableView *rearTableView;
@property (nonatomic, retain) IBOutlet UILabel *usernameLabel;
@property (nonatomic, retain) HomeViewController *displayUserName;
@property(nonatomic,retain) IBOutlet UIButton *imageBtn,*listofcourseBtn,*subjectbtn,*datelocationBtn;
@property(nonatomic,retain) NSMutableArray *mainmenuArray,*submenuArray;
@property(nonatomic,readwrite)BOOL isvisible,issubjectvis,issubjectexpand;
@property(nonatomic,retain)UIImageView *indexImage,*indeximage1,*indeximage2;

@end
