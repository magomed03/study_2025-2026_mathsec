function nod(a::Int, b::Int)
    if b < a
        a, b = b, a
    end
    r0 = a
    r1 = b
    
    if a == 0
        return 1
    end
    
    while true
        rem = r0 % r1
        if rem == 0
            return r1
        end
        r0 = r1
        r1 = rem
    end
end

function pollard(n::Int, c::Int, func::String)
    func = Meta.parse("@eval f(x) = $func") |> eval
    a = c
    b = c
    while true
        a = Base.invokelatest(func, a) % n
        b = Base.invokelatest(func, Base.invokelatest(func, b) % n) % n
        d = nod(abs(a - b), n)
        if d > 1 && d < n
            p = d
            return p
        end
        
        if d == n
            println("Делитель не найден")
            return nothing
        end
    end
end

function main()
    func = "x^2 + 5"
    res = pollard(1359331, 1, func)
    if res !== nothing
        println("Делитель равен $res")
    end
end

main()