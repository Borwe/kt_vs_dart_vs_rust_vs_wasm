use std::{collections::HashMap, time::SystemTime};

#[no_mangle]
pub extern "C" fn get_primes(end: i64) -> i64 {
    let mut primes: Vec<i64> = vec![2];
    let mut factos: Vec<i64> = Vec::new();

    for i in (3..end).step_by(2) {
        let mut is_prime = true;
        for &j in factos.iter() {
            if i == j {
                is_prime = false;
                break;
            }
        }

        if is_prime {
            for j in 3..end {
                if j * i > end {
                    break;
                }
                factos.push(j * i)
            }
            primes.push(i)
        }
    }

    primes.len().try_into().unwrap()
}

#[no_mangle]
pub extern "C" fn get_primes_over_time(end: i64) -> i64 {
    let primes_range: HashMap<i64, i64> =
        HashMap::from([(100, 25), (1000, 168), (10000, 1229), (100000, 9592)]);

    let mut count = 0;
    let start = SystemTime::now();

    while SystemTime::now().duration_since(start).unwrap().as_millis() < 5 * 1000 {
        let v = get_primes(end);
        assert_eq!(&v, primes_range.get(&end).unwrap());
        count += 1;
    }
    count
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::collections::HashMap;

    #[test]
    fn it_works() {
        let primes_range: HashMap<i64, i64> =
            HashMap::from([(100, 25), (1000, 168), (10000, 1229), (100000, 9592)]);
        let val = get_primes(100);
        assert_eq!(&val, primes_range.get(&100).unwrap());
        let val = get_primes(1000);
        assert_eq!(&val, primes_range.get(&1000).unwrap());
        let val = get_primes(10000);
        assert_eq!(&val, primes_range.get(&10000).unwrap());
    }
}
