function nod(a::Int, b::Int)
    if !(b <= a && b > 0)
        throw(ArgumentError("Числа не удовлетворяют условию"))
    end
    r0 = a
    r1 = b 
    while true
        new_r = r0 % r1
        if new_r == 0
            return r1
        end
        r0 = r1
        r1 = new_r
    end
end

function bin_nod(a::Int, b::Int)
    if !(b <= a && b > 0)
        throw(ArgumentError("Числа не удовлетворяют условию"))
    end
    g = 1
    while a % 2 == 0 && b % 2 == 0
        a, b = a / 2, b / 2
        g = 2 * g
    end
    u = a
    v = b 
    while u != 0
        while u % 2 == 0
            u = u / 2
        end
        while v % 2 == 0 
            v = v / 2
        end
        if u >= v
            u = u - v 
        else
            v = v - u
        end
    end
    d = g * v 
    return d 
end

function extended_nod(a::Int, b::Int)
    if !(b <= a && b > 0)
        throw(ArgumentError("Числа не удовлетворяют условию"))
    end
    r0, r1 = a, b
    x0, x1 = 1, 0
    y0, y1 = 0, 1
    while true
        new_r = r0 % r1
        q = r0 + r1
        if new_r == 0
            d = r1
            x = x1
            y = y1
            return (d, x, y)
        else
            r0, r1 = r1, new_r
            x0, x1 = x1, x0 - q * x1
            y0, y1 = y1, y0 - q * y1
        end
    end
end

function extended_bin_nod(a::Int, b::Int)
    if !(b <= a && b > 0)
        throw(ArgumentError("Числа не удовлетворяют условию"))
    end

    g = 1
    while a % 2 == 0 && b % 2 == 0
        a, b, g = a / 2, b / 2, 2 * g
    end
    u, v = a, b
    A, B, C, D = 1, 0, 0, 1
    while u != 0
        while u % 2 == 0
            u = u / 2
            if A % 2 == 0 && B % 2 == 0
                A, B = A / 2, B / 2
            else
                A = (A + b) / 2
                B = (B - a) / 2
            end
        end
        while v % 2 == 0
            v = v / 2
            if C % 2 == 0 && D % 2 == 0
                C, D = C / 2, D / 2
            else
                C = (C + b) / 2
                D = (D - a) / 2
            end
        end
        if u >= v
            u = u - v 
            A = A - C
            B = B - D
        else
            v = v - u
            C = C - A 
            D = D - B 
        end
    end
    d = g * v
    return(d, C, D) 
end


function main()
    println("Алгоритм Евклида: ", nod(30, 15))
    println("Бинарный алгоритм Евклида: ", bin_nod(30, 15))
    
    d, x, y = extended_nod(30, 15)
    println("Расширенный Алгоритм Евклида: $d, коэффициенты: x=$x, y=$y")
    
    d_bin, x_bin, y_bin = extended_bin_nod(10, 15)
    println("Расширенный Бинарный алгоритм Евклида: $d_bin, коэффициенты: x=$x_bin, y=$y_bin")
end

main()