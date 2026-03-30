func NLP(phrase: String) -> Int {
    let separated = separate(phrase: phrase)
    print(separated)
    let cleaned = deleteArticles(phrase: separated)
    print(cleaned)
    let counted = cleaned.count
    return counted
}

func separate(phrase: String) -> [String] {
    return phrase.split(separator: " ").map { String($0) }
}

func deleteArticles(phrase: [String]) -> [String] {
    let ARTICLES: [String] = ["es","en","un","el","la","a"]
    var returnArray: [String] = []
    
    for word in phrase {
        if !ARTICLES.contains(word.lowercased()) {
            returnArray.append(word)
        }
    }
    
    return returnArray
}

let FIRST_EXAMPLE: String = "Bienvenidos a Tecsup, hoy es un gran dia"
let NLP_FE = NLP(phrase: FIRST_EXAMPLE)
print("\(FIRST_EXAMPLE): \(NLP_FE)")

let SECOND_EXAMPLE: String = "Hoy es lunes santos"
let NLP_SE = NLP(phrase: SECOND_EXAMPLE)
print("\(SECOND_EXAMPLE): \(NLP_SE)")

let THIRD_EXAMPLE: String = "En Tecsup aprendemos a ser buenos profesionales"
let NLP_TE = NLP (phrase: THIRD_EXAMPLE)
print("\(THIRD_EXAMPLE): \(NLP_TE)")
