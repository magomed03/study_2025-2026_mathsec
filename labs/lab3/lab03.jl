function gamma_cypher(text, gamma, mod)
    russian_alphabet = collect("абвгдежзийклмнопрстуфхцчшщьыъэюя")
    filtered_text = [c for c in lowercase(text) if c in russian_alphabet]
    gamma_nums = [findfirst(==(c), russian_alphabet) for c in gamma]
    repeated_gamma = repeat(gamma_nums, ceil(Int, length(filtered_text) / length(gamma_nums)))
    ciphered_text = ""
    for (a, b) in zip(filtered_text, repeated_gamma)
        char_index = findfirst(==(a), russian_alphabet)
        new_index = (char_index + b) % mod
        if new_index == 0
            new_index = mod
        end
        ciphered_text *= russian_alphabet[new_index]
    end
    return ciphered_text
end


function main()
    text = "приказ"
    gamma = "гамма"
    cyphered_text = gamma_cypher(text, gamma, 33)
    println("Исходный текст: ", text)
    println("Гамма: ", gamma)
    println("Зашифрованный текст: ", cyphered_text)
end

main()