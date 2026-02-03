function caesar_cipher(text::String, k::Int)
    russAlphabet = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя"
    ciphered_text = []
    for symbol in text
        lower_char = lowercase(string(symbol))[1]
        if occursin(string(lower_char), russAlphabet)
            alpha_chars = collect(russAlphabet)
            index = findfirst(isequal(lower_char), alpha_chars)
            new_index = mod(index + k - 1, 33) + 1
            if isuppercase(symbol)
                push!(ciphered_text, uppercase(alpha_chars[new_index]))
            else
                push!(ciphered_text, alpha_chars[new_index])
            end
        else
            push!(ciphered_text, symbol)
        end
    end
    return join(ciphered_text)
end

function atbash_cipher(text::String)
    a = Int('а')
    ya = Int('я')
    ciphered_text = []
    for symbol in text
        asc_symbol = Int(lowercase(symbol)[1])
        if a <= asc_symbol <= ya
            new_char = Char(ya - asc_symbol + a)
            if isuppercase(symbol)
                push!(ciphered_text, uppercase(new_char))
            else
                push!(ciphered_text, new_char)
            end
        else
            push!(ciphered_text, symbol)
        end
    end
    return join(ciphered_text)
end

function main()
    text = "абвгд"
    println(text)
    caesar_cipher_text = caesar_cipher(text, 3)
    println(caesar_cipher_text)
    atbash_cipher_text = atbash_cipher(text)
    println(atbash_cipher_text)
end

main()