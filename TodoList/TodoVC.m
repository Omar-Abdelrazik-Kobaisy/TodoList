//
//  TodoVC.m
//  TodoList
//
//  Created by Omar on 17/01/2023.
//

#import "TodoVC.h"
#import"AdditemVC.h"
#import "ItemdetailsVC.h"
@interface TodoVC ()

@end

@implementation TodoVC
{
    Todoitem *item;
//    NSUserDefaults *def;
}
static NSMutableArray* todo_items;
static NSMutableArray* low_todos;
static NSMutableArray* mid_todos;
static NSMutableArray* hig_todos;
+ (void)initialize{
    
    todo_items = [NSMutableArray new];
    low_todos = [NSMutableArray new];
    mid_todos = [NSMutableArray new];
    hig_todos = [NSMutableArray new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    printf("--------------------Did load--------------\n ");
//    def = [NSUserDefaults standardUserDefaults];
    _table_view.delegate=self;
    _table_view.dataSource=self;
    // Ahmed fekry use save Array to UD <-----
//    [self saveArrayOfObjectToUserDefaults:@"todos" :todo_items];
    todo_items =[self retrievArrayOfObjFromUserDefaults:@"todos"];
    for(int i =0 ; i< [todo_items count] ; i++)
    {
        if([[[todo_items objectAtIndex:i] priortyTask]intValue] == 0)
        {
            [low_todos addObject:[todo_items objectAtIndex:i]];
            [self saveArrayOfObjectToUserDefaults:@"lowtodos" :low_todos];
        }else if ([[[todo_items objectAtIndex:i] priortyTask]intValue] == 1)
        {
            [mid_todos addObject:[todo_items objectAtIndex:i]];
            [self saveArrayOfObjectToUserDefaults:@"midtodos" :mid_todos];
        }else if ([[[todo_items objectAtIndex:i] priortyTask]intValue] == 2)
        {
            [hig_todos addObject:[todo_items objectAtIndex:i]];
            [self saveArrayOfObjectToUserDefaults:@"higtodos" :hig_todos];
        }
    }
    low_todos = [self retrievArrayOfObjFromUserDefaultsForLowPriorityItems:@"lowtodos"];
    mid_todos = [self retrievArrayOfObjFromUserDefaultsForMidPriorityItems:@"midtodos"];
    hig_todos = [self retrievArrayOfObjFromUserDefaultsForHigPriorityItems:@"higtodos"];
    [_table_view reloadData];
    
}

- (void)saveArrayOfObjectToUserDefaults:(NSString *)key :(NSMutableArray *) arr
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr]; //call encoding
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSMutableArray *)retrievArrayOfObjFromUserDefaults:(NSString *)key
{
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    todo_items = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
    return todo_items;
}
- (NSMutableArray *)retrievArrayOfObjFromUserDefaultsForLowPriorityItems:(NSString *)key
{
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    low_todos = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
    return low_todos;
}

- (NSMutableArray *)retrievArrayOfObjFromUserDefaultsForMidPriorityItems:(NSString *)key
{
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    mid_todos = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
    return mid_todos;
}

- (NSMutableArray *)retrievArrayOfObjFromUserDefaultsForHigPriorityItems:(NSString *)key
{
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    hig_todos = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
    return hig_todos;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self saveArrayOfObjectToUserDefaults:@"todos" :todo_items];
    [self saveArrayOfObjectToUserDefaults:@"lowtodos" :low_todos];
    [self saveArrayOfObjectToUserDefaults:@"midtodos" :mid_todos];
    [self saveArrayOfObjectToUserDefaults:@"higtodos" :hig_todos];
    todo_items = [self retrievArrayOfObjFromUserDefaults:@"todos"];
    low_todos = [self retrievArrayOfObjFromUserDefaultsForLowPriorityItems:@"lowtodos"];
    mid_todos = [self retrievArrayOfObjFromUserDefaultsForMidPriorityItems:@"midtodos"];
    hig_todos = [self retrievArrayOfObjFromUserDefaultsForHigPriorityItems:@"higtodos"];
    [_table_view reloadData];
}
- (void)viewDidAppear:(BOOL)animated
{

//    [_table_view reloadData];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)add:(Todoitem *)item
{
    if(item.priortyTask.intValue ==0)
    {
        [low_todos addObject:item];
    }else if (item.priortyTask.intValue ==1)
    {
        [mid_todos addObject:item];
    }else if (item.priortyTask.intValue ==2)
    {
        [hig_todos addObject:item];
    }
//    [todo_items addObject:item];
    [_table_view reloadData];
}
- (void)edit:(Todoitem *)item
{

}
- (void)editCell:(Todoitem *)item :(NSInteger)index :(Todoitem*)item1
{
    if(item.priortyTask.intValue ==0 && item.priortyTask.intValue == item1.priortyTask.intValue)
    {
        [low_todos removeObjectAtIndex:index];
        [low_todos addObject:item];
    }else if (item.priortyTask.intValue ==1 && item.priortyTask.intValue == item1.priortyTask.intValue)
    {
        [mid_todos removeObjectAtIndex:index];
        [mid_todos addObject:item];
    }else if (item.priortyTask.intValue ==2 && item.priortyTask.intValue == item1.priortyTask.intValue)
    {
        [hig_todos removeObjectAtIndex:index];
        [hig_todos addObject:item];
    }else if(item.priortyTask.intValue ==0 )
    {
        
        [low_todos addObject:item];
    }else if (item.priortyTask.intValue ==1 )
    {
        
        [mid_todos addObject:item];
    }else if (item.priortyTask.intValue ==2 )
    {
        [hig_todos addObject:item];
    }
//    [todo_items removeObjectAtIndex:index];
//    [todo_items addObject:item];
    [_table_view reloadData];
}
- (void)delCell:(Todoitem*)item :(NSInteger)index
{
    
    if(item.priortyTask.intValue ==0)
    {
        [low_todos removeObjectAtIndex:index];
    }else if (item.priortyTask.intValue ==1)
    {
        [mid_todos removeObjectAtIndex:index];
    }else if (item.priortyTask.intValue ==2)
    {
        [hig_todos removeObjectAtIndex:index];
    }
//    [todo_items removeObjectAtIndex:index];
    [_table_view reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [todo_items count];
    NSInteger number_of_rows =0 ;
    switch(section)
    {
        case 0:
            number_of_rows = [low_todos count];
            break;
        case 1:
            number_of_rows = [mid_todos count];
            break;
        case 2:
            number_of_rows = [hig_todos count];
            break;
    }
    return number_of_rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
//    item = [todo_items objectAtIndex:indexPath.row];
    
//    cell.textLabel.text = item.name  ;
//    cell.detailTextLabel.text = item.date;
//
//    if([item.priortyTask intValue]== 0)
//    {
//        cell.imageView.image =[UIImage imageNamed:@"L"];
//    }else if ([item.priortyTask intValue]== 1)
////        [item.priority isEqual:@"M"]
//    {
//        cell.imageView.image = [UIImage imageNamed:@"M"];
//    }else if ([item.priortyTask intValue]== 2)
//    {
//        cell.imageView.image = [UIImage imageNamed:@"H"];
//    }
    switch(indexPath.section)
    {
        case 0:
            item = [low_todos objectAtIndex:indexPath.row];
                cell.textLabel.text = item.name  ;
                cell.detailTextLabel.text = item.date;
            cell.imageView.image =[UIImage imageNamed:@"L"];
            break;
        case 1:
            item = [mid_todos objectAtIndex:indexPath.row];
                cell.textLabel.text = item.name  ;
                cell.detailTextLabel.text = item.date;
            cell.imageView.image =[UIImage imageNamed:@"M"];
            break;
        case 2:
            item = [hig_todos objectAtIndex:indexPath.row];
                cell.textLabel.text = item.name  ;
                cell.detailTextLabel.text = item.date;
            cell.imageView.image =[UIImage imageNamed:@"H"];
            break;
    }
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *header;
    switch(section)
    {
        case 0:
            header = @"Low Priority";
            break;
        case 1:
            header = @"Mid Priority";
            break;
        case 2:
            header = @"High Priority";
            break;
    }
    return header;
}
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        //lw mmshtsh mn elarray heb2a fe object fe el memory 3aez et3rd w ana mshat el cell el het3rd 3lha
//        //make alert
//        UIAlertController *alert =
//        [UIAlertController alertControllerWithTitle:@"delete" message:@"do you want delete it" preferredStyle:UIAlertControllerStyleActionSheet];
//
//        //create Button
//        UIAlertAction *yes =
//        [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
//            printf("Yes\n");
//            [todo_items removeObjectAtIndex:indexPath.row];
//        }];
//
//        UIAlertAction *no =
//        [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//            printf("NO\n");
//        }];
//
//        UIAlertAction *cancel =
//        [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
//         {
//            printf("cancel\n");
//        }];
//        //add Button to alert
//        [alert addAction:yes];
//        [alert addAction:no];
//        [alert addAction:cancel];
//        //show alert
//        [self presentViewController:alert animated:YES completion:^{
//            printf("alert done\n");
//        }];
//
//
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
//}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
            //make alert
            UIAlertController *alert =
            [UIAlertController alertControllerWithTitle:@"delete" message:@"do you want delete it" preferredStyle:UIAlertControllerStyleActionSheet];
    
            //create Button
            UIAlertAction *yes =
            [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
                printf("Yes\n");
//                [todo_items removeObjectAtIndex:indexPath.row];
                switch(indexPath.section)
                {
                    case 0:
                        [low_todos removeObjectAtIndex:indexPath.row];
                        break;
                    case 1:
                        [mid_todos removeObjectAtIndex:indexPath.row];
                        break;
                    case 2:
                        [hig_todos removeObjectAtIndex:indexPath.row];
                        break;
                }
                [self->_table_view reloadData];
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
//    item = [todo_items objectAtIndex:indexPath.row];
//    itemdetailvc.todoitem=item;
//    itemdetailvc.index =  indexPath.row;
    switch(indexPath.section)
    {
        case 0:
            item = [low_todos objectAtIndex:indexPath.row];
                itemdetailvc.todoitem=item;
                itemdetailvc.index =  indexPath.row;
            break;
        case 1:
            item = [mid_todos objectAtIndex:indexPath.row];
                itemdetailvc.todoitem=item;
                itemdetailvc.index =  indexPath.row;
            break;
        case 2:
            item = [hig_todos objectAtIndex:indexPath.row];
                itemdetailvc.todoitem=item;
                itemdetailvc.index =  indexPath.row;
            break;
    }

    [self.navigationController pushViewController:itemdetailvc animated:YES];
}

- (IBAction)addBtn:(id)sender {
    AdditemVC *additemvc = [self.storyboard instantiateViewControllerWithIdentifier:@"AdditemVC"];
    
    additemvc.p = self;
    [self presentViewController:additemvc animated:YES completion:nil];
//    [self.navigationController pushViewController:additemvc animated:YES];
}



@end
