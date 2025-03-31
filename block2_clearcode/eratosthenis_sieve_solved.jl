# The second iteration is the "good code version". Differences:
# * better variable names
# * Initial `if` clause is removed in favor of an early return statement
# * the crossing of integers is made its own function
# * the final collection of primes uses an existing function from base Julia
#   that simply finds all true elements. Because in Julia array indexing starts from 1
#   and because our `isprime` also contains an entry for 1, the indices of `isprime`
#   that are true are also the prime numbers themselves.

# God I love 1-based indexing.

"""
    eratosthenis_sieve(N::Int) → primes

Return a vector of all primes that are ≤ `N` using the the "Sieve of Eratosthenis".
"""
function eratosthenis_sieve(N::Int)
    N < 2 && return Int[]
    isprime = trues(N)   # number `n` is prime if `isprime[n] == true`
    isprime[1] = false   # 1 is not a prime number by definition
    cross_prime_multiples!(isprime)
    primes = findall(isprime)
end

"""
    cross_prime_multiples!(isprime::AbstractVector{Bool})

For all primes in `isprime` (elements that are `true`), set all their multiples to `false`.
Assumes `isprime` starts counting from 1.
"""
function cross_prime_multiples!(isprime::AbstractVector{Bool})
    N = length(isprime)
    for i in 2:round(Int, sqrt(N)+1)
        if isprime[i]
            for j in 2i:i:N
                isprime[j] = false
            end
        end
    end
end

eratosthenis_sieve(100)