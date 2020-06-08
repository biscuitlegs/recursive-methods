require 'prime'

#Codequizzes

def factorial(n)
    return n if n <= 2
    n * factorial(n - 1)
end

def palindrome?(string)
    return true if string.length <= 1
    if string[0] != string[-1]
        return false
    else
        return palindrome?(string[1..-2])
    end
end

def bottles_on_the_wall(n)
    if n == 0
        puts "No more bottles of beer on the wall..."
    else
        puts "#{n} bottles of beer on the wall..."
        bottles_on_the_wall(n - 1)
    end
end

def fib(n)
    return n if n <= 1
    fib(n - 1) + fib(n - 2)
end

def flatten(array)
    if array.none? { |e| e.is_a? Array }
        return array
    else
        combined_arrays = []
        array.each do |e|
            if e.is_a? Array
                combined_arrays += e
            else
                combined_arrays += [e]
            end
        end
        return flatten(combined_arrays)
    end
end


roman_mapping = {
    1000 => "M",
    900 => "CM",
    500 => "D",
    400 => "CD",
    100 => "C",
    90 => "XC",
    50 => "L",
    40 => "XL",
    10 => "X",
    9 => "IX",
    5 => "V",
    4 => "IV",
    1 => "I"
}

def integer_to_roman(n, map, array=[])
    return array.join("") if n == 0

    map.keys.each do |k|
        if (n - k) >= 0
            n -= k
            array << map[k]
            break
        end
    end

    integer_to_roman(n, map, array)
end

def roman_to_integer(string, map, sum=0)
    return sum if string.empty?

    map.each do |k, v|
        if string[0..1] == v
            sum += k
            string.slice!(0..1)
        elsif string[0] == v
            sum += k
            string.slice!(0)
        end
    end
    
    roman_to_integer(string, map, sum)
end


#Project Euler

def sum_of_multiples_of_three_and_five(n, sum=0)
    return n if n == 3
    sum += n if n % 3 == 0 || n % 5 == 0
    sum + sum_of_multiples_of_three_and_five(n - 1)
end

def largest_prime_factor(n, factors=[])
    return n if n.prime?

    Prime.first(n).each do |div|
        if n % div == 0
            factors << div
            break
        end
    end

    largest_prime_factor(n / factors.last)
end

def largest_palindrome_product(n)
    def palindrome?(string)
        string.chars.each_with_index do |char, i|
            if string[i] != string[-(i+1)]
                return false
            end
        end
    
        true
    end

    n.downto(1).each do |m|
        product = (n * m).to_s
        return product.to_i if palindrome?(product)
    end

    largest_palindrome_product(n-1)
end

def even_fib(n, sum=0)
    def fib(n)
        return n if n <= 1
        fib(n - 1) + fib(n - 2)
    end

    return 0 if n < 2
    sum += fib(n) if fib(n).even?


    sum + even_fib(n - 1)
end

# #smallest_multiple exceeded stack limit using recursion, solved a different way.

def smallest_multiple(n)
    def get_prime_factors(n, factors=[])
        return n if n.prime?
    
        Prime.first(n).each do |prime|
            if n % prime == 0
                factors << prime
                n /= prime
                break
            end
        end
        
    
        factors + [get_prime_factors(n)].flatten
    end
    
    def get_highest_exponents(n, factors=[])
        (2..n).each do |m|
            if get_prime_factors(m).is_a? Array
                factors << get_prime_factors(m)
            else
                factors << [m]
            end
        end
    
        highest = []
        Prime.first(n).select { |p| p < n  }.each do |factor|
            highest << factors.sort_by { |f| f.count(factor) }[-1].select { |num| num == factor }
        end
    
    
        highest.flatten
    end


    get_highest_exponents(n).reduce(:*)
end