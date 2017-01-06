//
//  MenuViewController.m
//  SWACC
//
//  Created by Infinitum on 10/11/16.
//  Copyright © 2016 com.keenan. All rights reserved.
//

#import "MenuViewController.h"
#import "UIColor+Expanded.h"
@interface MenuViewController (){
    
}


@property NSMutableArray *objects;
@end
NSString *const keyIndent = @"indent";
NSString *const keyTitle = @"title";
NSString *const keyChildren = @"children";

@implementation MenuViewController
@synthesize tableViewMain,index;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    index=2;

    NSArray * dataArray = @[
                            @{
                                keyIndent:@0,
                                keyTitle:@"title 0",
                                },
                            @{
                                keyIndent:@0,
                                keyTitle:@"title 1",
                                },
                            @{
                                keyIndent:@0,
                                keyTitle:@"title 2",
                                keyChildren:@[
                                        @{
                                            keyIndent:@1,
                                            keyTitle:@"title 21",
                                            keyChildren:@[
                                                    @{
                                                        keyIndent:@2,
                                                        keyTitle:@"title 211",
                                                        keyChildren:@[
                                                                @{
                                                                    keyIndent:@3,
                                                                    keyTitle:@"title 2111",
                                                                    keyChildren:@[
                                                                            @{
                                                                                keyIndent:@4,
                                                                                keyTitle:@"title 21111",
                                                                                keyChildren:@[]
                                                                                },
                                                                            @{
                                                                                keyIndent:@4,
                                                                                keyTitle:@"title 21112",
                                                                                keyChildren:@[]
                                                                                },
                                                                            ]                                                          },
                                                                @{
                                                                    keyIndent:@3,
                                                                    keyTitle:@"title 2112",
                                                                    keyChildren:@[]
                                                                    },
                                                                ]
                                                        },
                                                    @{
                                                        keyIndent:@2,
                                                        keyTitle:@"title 212",
                                                        keyChildren:@[]
                                                        },
                                                    ]
                                            },
                                        @{
                                            keyIndent:@1,
                                            keyTitle:@"title 22",
                                            keyChildren:@[
                                                    @{
                                                        keyIndent:@2,
                                                        keyTitle:@"title 221",
                                                        keyChildren:@[]
                                                        },
                                                    @{
                                                        keyIndent:@2,
                                                        keyTitle:@"title 222",
                                                        keyChildren:@[]
                                                        },
                                                    ]
                                            },
                                        @{
                                            keyIndent:@1,
                                            keyTitle:@"title 23",
                                            keyChildren:@[
                                                    @{
                                                        keyIndent:@2,
                                                        keyTitle:@"title 231",
                                                        keyChildren:@[]
                                                        },
                                                    @{
                                                        keyIndent:@2,
                                                        keyTitle:@"title 232",
                                                        keyChildren:@[]
                                                        },
                                                    ]
                                            },
                                        @{
                                            keyIndent:@1,
                                            keyTitle:@"title 24",
                                            keyChildren:@[
                                                    @{
                                                        keyIndent:@2,
                                                        keyTitle:@"title 241",
                                                        keyChildren:@[]
                                                        },
                                                    @{
                                                        keyIndent:@2,
                                                        keyTitle:@"title 242",
                                                        keyChildren:@[]
                                                        },
                                                    ]
                                            },
                                        ]
                                },
                            @{
                                keyIndent:@0,
                                keyTitle:@"title 3",
                                },
                            ];
    
    _objects = dataArray.mutableCopy;
    self.view.backgroundColor=[UIColor colorWithHexString:@"851c2b"];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    tableViewMain=[[UITableView alloc]init];
    tableViewMain.frame=CGRectMake(0,screenRect.size.height*.18,screenRect.size.width,screenRect.size.height*.82);
    tableViewMain.dataSource = self;
    tableViewMain.delegate = self;
    [tableViewMain setBackgroundColor:[UIColor clearColor]];
    self.tableViewMain.separatorColor = [UIColor clearColor];
    tableViewMain.separatorInset = UIEdgeInsetsZero;
    tableViewMain.layoutMargins = UIEdgeInsetsZero;
    self.tableViewMain.backgroundColor=[UIColor colorWithHexString:@"851c2b"];
    [self.view addSubview:tableViewMain];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//#pragma mark - Segues

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = self.objects[indexPath.row];
//        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
//        [controller setDetailItem:object];
//        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
//        controller.navigationItem.leftItemsSupplementBackButton = YES;
//    }
//}

#pragma mark - Table View DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    UIView *backgr=[[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
    [backgr setBackgroundColor:[UIColor colorWithHexString:@"851c2b"]];
    [cell.contentView addSubview:backgr];

    cell.textLabel.text = _objects[indexPath.row][keyTitle];
    
    cell.indentationWidth = 20;
    cell.indentationLevel = [_objects[indexPath.row][keyIndent] integerValue];
    
    
    cell.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:(CGFloat)(cell.indentationLevel)/50.0];
    
    
    //[cell setBackgroundColor:[UIColor colorWithHexString:@"851c2b"]];

    return cell;
}
#pragma mark - Table View Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UIView *button = (UIView *)indexPath.row;
//    [button setBackgroundColor:[UIColor colorWithHexString:@"D9D9D9"]];

    NSDictionary *dic = _objects[indexPath.row];
    NSInteger indentLevel = [_objects[indexPath.row][keyIndent] integerValue]; //indentLevel of the selected cell
    NSArray *indentArray = [_objects valueForKey:keyIndent]; //array of indents which are currently show on table
    
    BOOL indentChek = [indentArray containsObject:[NSNumber numberWithInteger:indentLevel]]; // check if  selected
    BOOL isChildrenAlreadyInserted = [_objects containsObject:dic[keyChildren]]; //checking contains children
    
    
    for(NSDictionary *dicChildren in dic[keyChildren]){
        
        NSInteger index=[_objects indexOfObjectIdenticalTo:dicChildren];
        
        isChildrenAlreadyInserted=(index>0 && index!=NSIntegerMax); //checking contains children
        
        if(isChildrenAlreadyInserted) break;
        
    }
    if ( indentChek &&  isChildrenAlreadyInserted) {
        
        //all children from this category will be deleted
        [self miniMizeThisRows:_objects[indexPath.row][keyChildren] forTable:tableView withIndexpath:indexPath];
        
    }
    else if ([dic[keyChildren] count]) { //insert the children if contains
        [tableView reloadData];
        NSMutableArray *ipsArray = [NSMutableArray new];
        NSArray *childArray = dic[keyChildren];
        
        NSInteger count = indexPath.row + 1;
        
        for (int i = 0; i < [dic[keyChildren] count]; i++,count++) {
            
            NSIndexPath *ip = [NSIndexPath indexPathForRow:count inSection:indexPath.section];
            [ipsArray addObject:ip];
            [_objects insertObject:childArray[i] atIndex:count];
        }
        [self.tableViewMain beginUpdates];
        [self.tableViewMain insertRowsAtIndexPaths:ipsArray withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableViewMain endUpdates];
//        if (index !=indexPath.row) {
//            [self miniMizeThisRows:_objects[index][keyChildren] forTable:tableView withIndexpath:indexPath];
//            index=indexPath.row;
//        }
        }
    else
    { //the junior most children will navigate
        //[self performSegueWithIdentifier:@"showDetail" sender:indexPath];
        NSLog(@"indexpath cell %ld",(long)indexPath.row);
    }
}

/*this method will check the category with its children, sub children and so on till the last indent occurs*/
//method to minimize all the child rows of that particular category
-(void)miniMizeThisRows:(NSArray*)ar forTable:(UITableView *)tableView withIndexpath:(NSIndexPath *)indexPath{
    
    for(NSDictionary *dicChildren in ar ) {
        NSUInteger indexToRemove=[_objects indexOfObjectIdenticalTo:dicChildren];
        NSArray *arrayChildren=[dicChildren valueForKey:keyChildren];
        
        if(arrayChildren && [arrayChildren count]>0){
            [self miniMizeThisRows:arrayChildren forTable:tableView withIndexpath:indexPath];//calling self method to remove  the childrens
        }
        
        if([_objects indexOfObjectIdenticalTo:dicChildren]!=NSNotFound) {
            //updating array
            [_objects removeObjectIdenticalTo:dicChildren];
            //deleting the row
            [tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexToRemove inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationRight];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
