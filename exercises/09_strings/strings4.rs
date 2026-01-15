// Calls of this function should be replaced with calls of `string_slice` or `string`.
fn placeholder() {}

fn string_slice(arg: &str) {
    println!("{arg}");
}

fn string(arg: String) {
    println!("{arg}");
}

// TODO: Here are a bunch of values - some are `String`, some are `&str`.
// Your task is to replace `placeholder(…)` with either `string_slice(…)`
// or `string(…)` depending on what you think each value is.
fn main() {
    string_slice("blue"); 

    string("red".to_string());  

    string(String::from("hi"));  

    string("rust is fun!".to_owned());  // Creates String (owned copy)

    string("nice weather".into());  // Creates String (conversion)

    string(format!("Interpolation {}", "Station"));  // Creates String

    string_slice(&String::from("abc")[0..1]);  // Slice of String → &str

    string_slice("  hello there ".trim());  // Returns &str

    string("Happy Monday!".replace("Mon", "Tues"));  // Creates String

    string("mY sHiFt KeY iS sTiCkY".to_lowercase());  // Creates String
}