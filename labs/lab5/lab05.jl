import Random

function test_ferma(n)
    if n < 5
        throw(ArgumentError("Число n должно быть больше или равно 5"))
    end
    a = rand(2:(n-2))
    r = powermod(a, n-1,n)
    if r == 1
        println("Чсло $n, вероятно, простое")
        return
    else
        println("Число $n составное")
        return
    end
end

function symbol_jacobi(n, a)
    if n < 3
        throw(ArgumentError("Число n должно быть больше или равно 3"))
    end
    if !(a >= 0 && a < n)
        throw(ArgumentError("Число a должно быть в промежутке от 0 до n"))
    end
    
    g = 1
    a_current = a
    n_current = n
    
    while true
        if a_current == 0
            return 0
        end
        if a_current == 1
            return g
        end
        
        k = 0
        a1 = a_current
        s = 1
        
        while a1 % 2 == 0
            a1 ÷= 2
            k += 1
        end

        if k % 2 == 0
            s = 1
        else
            if abs(n_current) % 8 == 1
                s = 1
            elseif abs(n_current) % 8 == 3
                s = -1
            end
        end
        
        if a1 == 1
            return g * s
        end
        
        if n_current % 4 == 3 && a1 % 4 == 3
            s = -s
        end
        
        a_current = n_current % a1
        n_current = a1
        g = g * s
    end
end

function solovei_shtrassen(n)
    if n < 5
        throw(ArgumentError("Число n должно быть больше или равно 5"))
    end
    
    a = rand(2:(n-2))
    jacobi = symbol_jacobi(n, a)
    
    if jacobi == 0
        println("Число $n, вероятно, простое")
        return
    end
    
    exp = (n - 1) ÷ 2
    r = powermod(a, exp, n)
    
    if r == (jacobi % n)
        println("Число $n, вероятно, простое")
        return
    end
    
    println("Число $n составное")
end

function miller_rabin(n)
    if n < 5
        throw(ArgumentError("Число n должно быть больше или равно 5"))
    end
    
    r = n - 1
    s = 0
    while r % 2 == 0
        r ÷= 2
        s += 1
    end

    a = rand(2:(n-2))
    y = powermod(a, r, n)
    
    if y != 1 && y != n-1
        j = 1
        while j < s && y != n-1
            y = powermod(y, 2, n)
            if y == 1
                println("Число $n составное")
                return
            end
            j += 1
        end
        
        if y != n-1
            println("Число $n составное")
            return
        end
    end
    
    println("Число $n, вероятно, простое")
end


function main()
    println("Тест Ферма")
    test_ferma(11)
    test_ferma(15)
    println("Тест Соловэя-Штрассена")
    solovei_shtrassen(11)
    solovei_shtrassen(15)
    println("Миллера-Рабина")
    miller_rabin(11)
    miller_rabin(15)
end

main()