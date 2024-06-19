package main

import "testing"

var samplePrimes = map[int64]int64{
	100: 25, 1000: 168, 10000: 1229, 100000: 9592,
}

func TestGetPrimesUntil(t *testing.T) {
	for end, expected := range samplePrimes {
		actual := getPrimesUntil(end)
		if actual != expected {
			t.Errorf("getPrimesUntil(%d) = %d, expected %d", end, actual, expected)
		}
	}

}
