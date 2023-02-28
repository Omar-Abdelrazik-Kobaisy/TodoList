//
//  ItemdetailsVC.m
//  TodoList
//
//  Created by Omar on 17/01/2023.
//

#import "ItemdetailsVC.h"
#import "Todoitem.h"
#import "TodoVC.h"
#import "InprogressVC.h"
#import "DoneVC.h"
@interface ItemdetailsVC ()

@end

@implementation ItemdetailsVC
{
//    NSUserDefaults *def;
    Todoitem* item;
}
static NSMutableArray *low_priorty_items;
static NSMutableArray *mid_priorty_items;
static NSMutableArray *hig_priorty_items;
static NSMutableArray *inprogress_items;
static NSMutableArray *done_items;

+ (void)initialize
{
    low_priorty_items = [NSMutableArray new];
    mid_priorty_items = [NSMutableArray new];
    hig_priorty_items = [NSMutableArray new];
    inprogress_items = [NSMutableArray new];
    done_items = [NSMutableArray new];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _name_textf.text = _todoitem.name;
    _desc_textf.text = _todoitem.desc;
    [_priority_textf setSelectedSegmentIndex: [_todoitem.priortyTask integerValue] ];
    [_state setSelectedSegmentIndex:[_todoitem.state integerValue]];
//    def = [NSUserDefaults standardUserDefaults];
    low_priorty_items = [self retrievArrayOfObjFromUserDefaultsForLowPriortyArray:@"lowtodos"];
    mid_priorty_items = [self retrievArrayOfObjFromUserDefaultsForLowPriortyArray:@"midtodos"];
    hig_priorty_items = [self retrievArrayOfObjFromUserDefaultsForLowPriortyArray:@"higtodos"];
}
- (void)saveArrayOfObjectToUserDefaults:(NSString *)key :(NSMutableArray *)arr
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr]; //call encoding
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSMutableArray *)retrievArrayOfObjFromUserDefaultsForLowPriortyArray:(NSString *)key
{
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    low_priorty_items = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
    return low_priorty_items;
}

- (NSMutableArray *)retrievArrayOfObjFromUserDefaultsForMidPriortyArray:(NSString *)key
{
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    mid_priorty_items = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
    return mid_priorty_items;
}

- (NSMutableArray *)retrievArrayOfObjFromUserDefaultsForHigPriortyArray:(NSString *)key
{
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    hig_priorty_items = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
    return hig_priorty_items;
}
- (NSMutableArray *)retrievArrayOfObjFromUserDefaultsForInprogressArray:(NSString *)key
{
    NSDate *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    inprogress_items = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
    return inprogress_items;
}

- (NSMutableArray *)retrievArrayOfObjFromUserDefaultsForDoneArray:(NSString *)key
{
    NSDate *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    done_items = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
    return done_items;
}
- (IBAction)editBtn:(id)sender {
    item = [Todoitem new];
    item.name = _name_textf.text;
    item.desc = _desc_textf.text;
    item.date = _todoitem.date;
    NSNumber *num =[[NSNumber alloc] initWithInteger:_priority_textf.selectedSegmentIndex]  ;
    item.priortyTask = num;
    NSNumber *num_state =[[NSNumber alloc] initWithInteger:[_state selectedSegmentIndex]]  ;
    item.state = num_state;
    TodoVC *todovc = [self.storyboard instantiateViewControllerWithIdentifier:@"TodoVC"];
    InprogressVC *inprogress = [self.storyboard instantiateViewControllerWithIdentifier:@"InprogressVC"];
    DoneVC *done = [self.storyboard instantiateViewControllerWithIdentifier:@"DoneVC"];
    if([_state selectedSegmentIndex] == 0)
    {
        printf("todo\n");
        //------> use call back delege to add data in table view then save and retriev<-----
        [todovc editCell:item :_index :_todoitem];
//        [todo_items removeObjectAtIndex:_index];
//        [todo_items addObject:item];
        if(item.priortyTask.intValue == 0)
        {
            [self saveArrayOfObjectToUserDefaults:@"lowtodos" :low_priorty_items];
        }else if (item.priortyTask.intValue ==1)
        {
            [self saveArrayOfObjectToUserDefaults:@"midtodos" :mid_priorty_items];
        }else if (item.priortyTask.intValue ==2)
        {
            [self saveArrayOfObjectToUserDefaults:@"higtods" :hig_priorty_items];
        }
//        [self saveArrayOfObjectToUserDefaults:@"todos" :todo_items];
//        [todovc.table_view reloadData];
        
    }else if ([_state selectedSegmentIndex] == 1)
    {
        printf("inprogress\n");
        printf("%d",item.state.intValue);
        //[todo_items removeObjectAtIndex:_index];
        
        if(_todoitem.state.intValue == 0)
        {
            [todovc delCell:_todoitem :_index];
        }
        else if (_todoitem.state.intValue ==1)
        {
            [inprogress delCell:_todoitem :_index];
        }
        inprogress_items = [self retrievArrayOfObjFromUserDefaultsForInprogressArray:@"inprogress"];
        [inprogress_items addObject:item];
        [self saveArrayOfObjectToUserDefaults:@"inprogress" :inprogress_items];
//        [inprogress.inprogress_TV reloadData];
    }else if ([_state selectedSegmentIndex] == 2)
    {
        printf("done\n");
        //[todo_items removeObjectAtIndex:_index];
        
        if(_todoitem.state.intValue == 0)
        {
            [todovc delCell:_todoitem :_index];
        }else if (_todoitem.state.intValue ==1)
        {
            [inprogress delCell:_todoitem :_index];
        }else if (_todoitem.state.intValue ==2)
        {
            [done delCell:_todoitem :_index];
        }
//        [todovc delCell:item :_index];
        done_items = [self retrievArrayOfObjFromUserDefaultsForDoneArray:@"done"];
        [done_items addObject:item];
        [self saveArrayOfObjectToUserDefaults:@"done" :done_items];
//        [todovc.table_view reloadData];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
