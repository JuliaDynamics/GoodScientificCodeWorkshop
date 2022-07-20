# For the first iteration, we will simply transform this function from Java to Julia.
# This shows so nicely why using a new language will skyrocket your productivity.

# Differences: arrays can be immediatelly initialized to a value. e.g. a `for`
# loop over this `f` does not exist. We use `f = trues(N)`.
# Variables like i, and j, do not need to be declared. Starting a loop already
# declares them.
# There is no reason to make a `for` loop to count the true elements in an array.
# that's literally what the `count` function does.
function eratosthenis_sieve(N)
    if N >= 2 # the only valid case
        # Declerations:
        f = trues(N)
        # get rid of known non-primes
        f[1] = false

        # sieve
        for i in 2:round(Int, sqrt(N)+1)
            if f[i] # if i is uncrossed, cross its multiples
                for j in 2*i:i:N
                    f[j] = false # multiple is not a prime
                end
            end
        end

        # how many primes are there
        count = Base.count(f)

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