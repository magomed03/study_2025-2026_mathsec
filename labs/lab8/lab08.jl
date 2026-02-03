function zero_extend(u::Vector{Int}, b::Int)
    return vcat(zeros(Int, b - length(u)), u)
end

function add(u_in, v_in, n, b)
    u = [parse(Int, string(c)) for c in string(u_in)]
    v = [parse(Int, string(c)) for c in string(v_in)]
    if length(u) < n
        u = zero_extend(u, n)
    end
    if length(v) < n
        v = zero_extend(v, n)
    end

    k = 0
    w = String[]
    for j in n:-1:1
        sum_val = u[j] + v[j] + k
        w = [string(sum_val % b); w]
        k = div(sum_val, b)
        if j == 1 && k != 0
            w = [string(k); w]
        end 
    end
    return parse(Int, join(w))
end

function sub(u_in::Int, v_in::Int, n, b)
    if !(u_in > v_in)
        throw(ArgumentError("Уменьшаемое должно быть больше или равным вычитаемому"))
    end
    u = [parse(Int, string(c)) for c in string(u_in)]
    v = [parse(Int, string(c)) for c in string(v_in)]
    if length(u) < n
        u = zero_extend(u, n)
    end
    if length(v) < n
        v = zero_extend(v, n)
    end
    k = 0
    w = String[]
    for j in n:-1:1
        diff_val = u[j] - v[j] + k
        if diff_val < 0
            digit = diff_val + b
            k = -1
        else
            digit = diff_val
            k = 0
        end
        w = [string(digit); w]
    end
    start_index = 1
    while start_index <= length(w) && w[start_index] == "0"
        start_index += 1
    end
    if start_index > length(w)
        return 0
    else
        return parse(Int, join(w[start_index:end]))
    end
end

function mul(u_in::Int, v_in::Int, b::Int)
    u = [parse(Int, string(c)) for c in string(u_in)]
    v = [parse(Int, string(c)) for c in string(v_in)]
    if length(u) < length(v)
        u, v = v, u
    end

    m = length(v)
    n = length(u)
    w = zeros(Int, m + n)

    for j in m:-1:1
        if v[j] == 0
            continue
        else
            i = n
            k = 0
            while i >= 1
                t = u[i] * v[j] + w[i + j ] + k
                w[i + j] = t % b
                k = div(t, b)
                i -= 1
            end
            w[j] = k
        end
    end
    start_index = 1
    while start_index <= length(w) && w[start_index] == 0
        start_index += 1
    end
    if start_index > length(w)
        return 0 
    else
        return(parse(Int, join(string.(w[start_index:end]))))
    end
end

function mul_fast(u_in::Int, v_in::Int, b::Int)
    u = [parse(Int, string(c)) for c in string(u_in)]
    v = [parse(Int, string(c)) for c in string(v_in)]
    if length(u) < length(v)
        u, v = v, u
    end
    m = length(v)
    n = length(u)
    w = zeros(Int, m + n)
    for s in 0:(m + n - 1)
        t = 0
        for i in max(0, s - m + 1):min(s, n - 1)
            j = s - i
            if j < m
                t += u[n - i] * v[m - j]
            end
        end

        w[m + n - s] += t % b
        if s < m + n - 1
            w[m + n - s - 1] += div(t, b)
        end
    end
    return w
end

function divis(u_in::Int, v_in::Int, b::Int)
    if v_in == 0
        throw(ArgumentError("Деление на ноль"))
    end
    if u_in < v_in
        return 0, u_in
    end
    u = [parse(Int, string(c)) for c in string(u_in)]
    v = [parse(Int, string(c)) for c in string(v_in)]
    n = length(v)
    t = length(u)
    q = zeros(Int, t - n + 1)
    c = 0
    for i in 1:t
        c = c * b + u[i]
        digit = 0
        while c >= v_in
            c -= v_in
            digit += 1
        end
        if i >= n
            q[i - n + 1] = digit
        end
    end
    a = parse(Int, join(string.(q)))
    r = c
    return a, r
end

function main()
    res_1 = add(5, 7, 2, 10)
    println("add result = $res_1")
    res_2 = sub(12, 7, 2, 10)
    println("sub result = $res_2")
    res_3 = mul(5, 7, 10)
    println("multiply result = $res_3")
    res_4 = mul_fast(7, 5, 10)
    println("fast multiply result = $res_4")
    res_5 = divis(10, 2, 10)
    println("division result = $res_5")
end

main()