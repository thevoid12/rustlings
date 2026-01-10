fn main() {
    // TODO: Create an array called `a` with at least 100 elements in it.
    let a:[i32;101]=[100;101];
    // let mut a:[i32;101]=[100;101];
    // for i in (0..101){
    //     a[i]=100
    // }

    if a.len() >= 100 {
        println!("Wow, that's a big array!");
    } else {
        println!("Meh, I eat arrays like that for breakfast.");
        panic!("Array not big enough, more elements needed");
    }
}
