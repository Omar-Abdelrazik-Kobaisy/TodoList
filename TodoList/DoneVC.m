//
//  DoneVC.m
//  TodoList
//
//  Created by Omar on 17/01/2023.
//

#import "DoneVC.h"
#import "Todoitem.h"
#import "ItemdetailsVC.h"
@interface DoneVC ()

@end

@implementation DoneVC
{
    Todoitem *item;
}
static NSMutableArray *done_items;
static NSMutableArray *done_items_filter;

+ (void)initialize
{
    done_items = [NSMutableArray new];
//    done_items_filter = [NSMutableArray new];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _done_TV.delegate=self;
    _done_TV.dataSource=self;
    
    done_items = [self retrievArrayOfObjFromUserDefaults:@"done"];
    done_items_filter = [done_items mutableCopy];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    done_items = [self retrievArrayOfObjFromUserDefaults:@"done"];
    done_items_filter = [done_items mutableCopy];
    [self saveArrayOfObjectToUserDefaults:@"done" :done_items];
    [_done_TV reloadData];
}
- (IBAction)segAction:(id)sender
{
    NSPredicate *low = [NSPredicate predicateWithFormat:@"priortyTask == 0"];
    NSPredicate *mid = [NSPredicate predicateWithFormat:@"priortyTask == 1"];
    NSPredicate *hig = [NSPredicate predicateWithFormat:@"priortyTask == 2"];
    switch(_done_filter.selectedSegmentIndex){
        case 0:
            
            done_items_filter =[[done_items filteredArrayUsingPredicate:low] mutableCopy];
            break;
        case 1:
            done_items_filter =[[done_items filteredArrayUsingPredicate:mid] mutableCopy];
            break;
        case 2:
            done_items_filter =[[done_items filteredArrayUsingPredicate:hig] mutableCopy];
            break;
    }
    [_done_TV reloadData];
}



- (void)viewDidAppear:(BOOL)animated
{
    [self saveArrayOfObjectToUserDefaults:@"done" :done_items];
}
- (void)saveArrayOfObjectToUserDefaults:(NSString *)key :(NSMutableArray *)arr
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr]; //call encoding
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSMutableArray *)retrievArrayOfObjFromUserDefaults:(NSString *)key
{
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    done_items = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
    return done_items;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [done_items_filter count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    item = [done_items_filter objectAtIndex:indexPath.row];
    
    
    if([item.priortyTask intValue]== 0)
    {
        cell.imageView.image =[UIImage imageNamed:@"L"];
    }else if ([item.priortyTask intValue]== 1)
//        [item.priority isEqual:@"M"]
    {
        cell.imageView.image = [UIImage imageNamed:@"M"];
    }else if ([item.priortyTask intValue]== 2)
    {
        cell.imageView.image = [UIImage imageNamed:@"H"];
    }
    
    cell.textLabel.text = item.name;
    return  cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //make alert
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@"delete" message:@"do you want delete it" preferredStyle:UIAlertControllerStyleActionSheet];

    //create Button
    UIAlertAction *yes =
    [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        printf("Yes\n");
        [done_items_filter removeObjectAtIndex:indexPath.row];
        [done_items removeObjectAtIndex:indexPath.row];
        [self saveArrayOfObjectToUserDefaults:@"done" :done_items];
        [self->_done_TV reloadData];
        
    }];

    UIAlertAction *no =
    [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        printf("NO\n");
    }];

    UIAlertAction *cancel =
    [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
     {
        printf("cancel\n");
    }];
    //add Button to alert
    [alert addAction:yes];
    [alert addAction:no];
    [alert addAction:cancel];
    //show alert
    [self presentViewController:alert animated:YES completion:^{
        printf("alert done\n");
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemdetailsVC *itemdetailvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemdetailsVC"];
    item = [done_items_filter objectAtIndex:indexPath.row];
    itemdetailvc.todoitem=item;
    itemdetailvc.index =  indexPath.row;
    [self.navigationController pushViewController:itemdetailvc animated:YES];
}
- (void)delCell:(id)item :(NSInteger)index
{
    [done_items_filter removeObjectAtIndex:index];
    [done_items removeObjectAtIndex:index];
    [self saveArrayOfObjectToUserDefaults:@"done" :done_items_filter];
    [_done_TV reloadData];
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
