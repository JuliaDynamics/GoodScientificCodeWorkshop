# This function generates prime numbers up to a user specified maximum `N`.
# The algorithm used is the Sieve of Eratosthenes.
# It is quite simple. Given an array of integers from 1 to `N`, cross out all multiples
# of 2. Find the next uncrossed integer, and cross out all of its multiples.
# Repeat until you have passed the square root of `N`.
# The uncrossed numbers that remain are all the primes less than `N`.

# quick notice: this is a verbatic port of a Java code to Julia,
# and as such it is unreasonably low level.

function eratosthenis_sieve(N)
    if N >= 2 # the only valid case
        # Declerations:
        f = Bool[]
        i = 0
        # initialize array to true
        for i in 1:N
            push!(f, true)
        end

        # get rid of known non-primes
        f[1] = false

        # sieve
        j = 0
        for i in 2:round(Int, sqrt(N)+1)
            if f[i] # if i is uncrossed, cross its multiples
                for j in 2*i:i:N
                    f[j] = false # multiple is not a prime
                end
            end
        end

        # how many primes are there
        count = 0
        for i in 1:N
            if f[i]
                count += 1
            end
        end

        primes = zeros(Int, count)

        # move the primes into the result
        j = 1
        for i in 1:N
            if f[i] # if prime
                primes[j] = i
                j += 1
            end
        end
        return primes # return the primes
    else # if N < 2
        return Int[] # return null array if bad imput
    end
end

eratosthenis_sieve(10)