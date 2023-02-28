//
//  TodoVC.h
//  TodoList
//
//  Created by Omar on 17/01/2023.
//

#import <UIKit/UIKit.h>
#import "Add_protocol.h"
#import "Todoitem.h"
#import "Edit_protocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface TodoVC : UIViewController <Add_protocol,UITableViewDelegate , UITableViewDataSource,Edit_protocol>

@property (weak, nonatomic) IBOutlet UITableView *table_view;

//@property Todoitem* todo_item;

-(void)saveArrayOfObjectToUserDefaults:(NSString*) key :(NSMutableArray*) arr;
-(NSMutableArray*)retrievArrayOfObjFromUserDefaults:(NSString*)key;
-(NSMutableArray*)retrievArrayOfObjFromUserDefaultsForLowPriorityItems:(NSString*)key;
-(NSMutableArray*)retrievArrayOfObjFromUserDefaultsForMidPriorityItems:(NSString*)key;
-(NSMutableArray*)retrievArrayOfObjFromUserDefaultsForHigPriorityItems:(NSString*)key;
-(void)editCell:(Todoitem*)item :(NSInteger)index :(Todoitem*)item1;
-(void)delCell :(Todoitem*)item :(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
