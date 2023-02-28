//
//  AdditemVC.m
//  TodoList
//
//  Created by Omar on 17/01/2023.
//

#import "AdditemVC.h"
#import "Todoitem.h"
#import "TodoVC.h"
@interface AdditemVC ()

@end

@implementation AdditemVC
{
    Todoitem *item;
//    NSUserDefaults *def;
}
//static NSMutableArray *todo_items;
+ (void)initialize
{
//    todo_items = [NSMutableArray new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    def = [NSUserDefaults standardUserDefaults];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)addItem:(id)sender {
    //make alert
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@"Add" message:@"do you want add todo item" preferredStyle:UIAlertControllerStyleActionSheet];

    //create Button
    UIAlertAction *yes =
    [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
    printf("Yes\n");

        self->item = [Todoitem new];
        self->item.name = self->_item_name.text;
        self->item.desc = self->_item_desc.text;
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSString *dateString = [dateFormat stringFromDate:today];
        printf("%s",[dateString UTF8String]);
        self->item.date = dateString;
//        self->item.priority = [self->_item_priority titleForSegmentAtIndex:self->_item_priority.selectedSegmentIndex];
//        [self->item.priority_index intValue]= [self->_item_priority selectedSegmentIndex];
        NSNumber *priorty_num =[[NSNumber alloc] initWithInteger:self->_item_priority.selectedSegmentIndex]  ;
        self->item.priortyTask = priorty_num;
        NSNumber *num_state =[[NSNumber alloc] initWithInteger:0]  ;
        self->item.state =num_state;
        [self->_p add:self->item];
//        [todo_items addObject:self->item];
//        NSDate *data = [NSKeyedArchiver archivedDataWithRootObject:todo_items];
//        [self->def setObject:data forKey:@"todos"];
        [self dismissViewControllerAnimated:YES completion:nil];
//        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *cancel =
    [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
     {
        printf("cancel\n");
    }];
    //add Button to alert
    [alert addAction:yes];
    [alert addAction:cancel];
    //show alert
    [self presentViewController:alert animated:YES completion:^{
        printf("alert done\n");
        
    }];
    
}
- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
