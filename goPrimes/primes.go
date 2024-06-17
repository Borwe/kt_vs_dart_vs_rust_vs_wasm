package main

import (
	"C"
	"fmt"
	"log"
	"time"
)

//export getPrimesUntil
func getPrimesUntil(end int64) int64 {
	var primes = []int64{2}
	var factors []int64
	for i := int64(3); i <= end; i += 2 {
		var isPrime = true
		for _, num := range factors {
			if i == num {
				isPrime = false
				break
			}

		}

		if isPrime {
			for j := int64(3); j <= end; j += 2 {
				if j*i > end {
					break
				}
				factors = append(factors, j*i)
			}
			primes = append(primes, i)
		}

	}

	return int64(len(primes))
}

//export getPrimesOverTime
func getPrimesOverTime(end int64) int64 {
	samplePrimes := map[int64]int64{
		100: 25, 1000: 168, 10000: 1229, 100000: 9592,
	}

	var count int64 = 0
	startTime := time.Now().UnixMilli()
	for time.Now().UnixMilli() < startTime+5000 {

		result := getPrimesUntil(end)

		if result == samplePrimes[end] {
			count++
		} else {
			err := fmt.Errorf("Incorrect result for range %v:  expected %v  actual %v", int(end), samplePrimes[end], result)
			log.Panic(err)
		}
	}
	fmt.Println()
	return count

}
