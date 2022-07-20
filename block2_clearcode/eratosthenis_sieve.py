# This function generates prime numbers up to a user specified maximum `N`.
# The algorithm used is the Sieve of Eratosthenes.
# It is quite simple. Given an array of integers from 1 to `N`, cross out all multiples
# of 2. Find the next uncrossed integer, and cross out all of its multiples.
# Repeat until you have passed the square root of `N`.
# The uncrossed numbers that remain are all the primes less than `N`.

# quick notice: this is a verbatic port of a Java code to Python,
# and as such it is unreasonably low level.
import numpy as np


def eratosthenis_sieve(N):
    if N >= 2:  # the only valid case
        # Declerations:
        # initialize array to true
        f = np.ones(N, dtype=bool)

        # get rid of known non-primes
        f[:2] = False

        # sieve
        for i in range(int(np.round(np.sqrt(N) + 1))):
            if f[i]:  # if i is uncrossed, cross its multiples
                for j in range(i**2, N, i):
                    f[j] = False  # multiple is not a prime

        # how many primes are there
        count = 0
        for i in range(N):
            if f[i]:
                count += 1

        primes = np.zeros(count)

        # move the primes into the result
        j = 0
        for i in range(N):
            if f[i]:  # if prime
                primes[j] = i
                j += 1
        return primes  # return the primes
    else:  # if N < 2
        return np.empty(0)  # return null array if bad imput


def test_primes():
    assert 0 not in eratosthenis_sieve(10), "0 is not a prime."
    assert 1 not in eratosthenis_sieve(10), "1 is not a prime."
    assert len(eratosthenis_sieve(10)) == 4, "There are four primes until 10."
    assert len(eratosthenis_sieve(100)) == 25, "There are 25 primes until 100."


if __name__ == "__main__":
    print(eratosthenis_sieve(10))
