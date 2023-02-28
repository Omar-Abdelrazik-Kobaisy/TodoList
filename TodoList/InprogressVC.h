//
//  InprogressVC.h
//  TodoList
//
//  Created by Omar on 17/01/2023.
//

#import <UIKit/UIKit.h>
#import "Todoitem.h"
NS_ASSUME_NONNULL_BEGIN

@interface InprogressVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *inprogress_TV;
@property (weak, nonatomic) IBOutlet UISegmentedControl *inprogress_filter;



-(void)delCell :(Todoitem*)item :(NSInteger)index;
-(void)saveArrayOfObjectToUserDefaults:(NSString*) key :(NSMutableArray*) arr;
-(NSMutableArray*)retrievArrayOfObjFromUserDefaults:(NSString*)key;

@end

NS_ASSUME_NONNULL_END
