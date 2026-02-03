using Random
using LinearAlgebra

function route_cipher(text, password)
    words = split(text)
    letters = collect(join(words))
    len_password = length(password)
    order = sort(collect(enumerate(collect(password))), by=x -> x[2])
    while length(letters) % len_password != 0
        push!(letters, rand('а':'я'))
    end
    num_rows = length(letters) ÷ len_password
    route_table = reshape(letters, (len_password, num_rows))
    
    ciphered_text = join([join(route_table[ind[1], :]) for ind in order])
    return ciphered_text
end

function vizhener_cipher(text, password)
    russAlphabet = collect("абвгдежзийклмнопрстуфхцчшщьыэюя")
    
    table = Matrix{Char}(undef, length(russAlphabet), length(russAlphabet))
    for i in 1:length(russAlphabet)
        for j in 1:length(russAlphabet)
            idx = (i + j - 2) % length(russAlphabet) + 1
            table[i, j] = russAlphabet[idx]
        end
    end
    
    shift = [findfirst(==(letter), russAlphabet) for letter in collect(password)]
    text = lowercase(filter(c -> isletter(c) && c ∈ 'а':'я', text))
    ciphered_text = Char[]
    count = 1
    
    for letter in text
        ind1 = findfirst(==(letter), russAlphabet)
        ind2 = shift[(count - 1) % length(shift) + 1]
        count += 1
        push!(ciphered_text, table[ind1, ind2])
    end
    
    return join(ciphered_text)
end

function main()
    println("Маршрутное шифрование:")
    text = "нельзя недооценивать противника"
    password = "пароль"
    ciphered_text = route_cipher(text, password)
    println("Исходный текст: ", text)
    println("Зашифрованный текст: ", ciphered_text)
    println()

    println("Vizhener cipher:")
    text = "криптография серьезная наука"
    password = "математика"
    ciphered_text = vizhener_cipher(text, password)
    println("Исходный текст: ", text)
    println("Зашифрованный текст: ", ciphered_text)
end

main()