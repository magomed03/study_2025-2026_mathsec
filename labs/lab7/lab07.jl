function evklid(a, b)
    if b == 0
        return a, 1, 0
    else
        d, xx, yy = evklid(b, a % b)
        x = yy
        y = xx - div(a, b) * yy
        return d, x, y
    end
end

function inverse(a::Int, n::Int)
    d, x, y = evklid(a, n)
    if d != 1
        error("Обратного элемента не существует")
    end
    return mod(x, n)
end

function xab(x, a, b, xxx::Tuple)
    (G, H, P, Q) = xxx
    sub = x % 3
    
    if sub == 0
        x = mod(x * G, P)
        a = mod(a + 1, Q)
    elseif sub == 1
        x = mod(x * H, P)
        b = mod(b + 1, Q)
    elseif sub == 2
        x = mod(x * x, P)
        a = mod(a * 2, Q)
        b = mod(b * 2, Q)
    end
    
    return x, a, b
end

function verify(g, h, p, x)
    return mod(g^x, p) == h
end

function pollard(G, H, P)
    Q = div(P - 1, 2)
    
    x = mod(G * H, P)
    a = 1
    b = 1
    
    X = x
    A = a
    B = b
    for i in 1:P
        x, a, b = xab(x, a, b, (G, H, P, Q))
        X, A, B = xab(X, A, B, (G, H, P, Q))
        X, A, B = xab(X, A, B, (G, H, P, Q))

        if x == X
            break
        end
    end

    nom = mod(A - a, Q)
    denom = mod(b - B, Q)
    if denom == 0
        error("Деление на 0")
    end
    res = mod(inverse(denom, Q) * nom, Q)
    if verify(G, H, P, res)
        return res
    else
        return mod(res + Q, 53)
    end
end

function main()
    res = pollard(10, 64, 107)
    println(res)
end

main()