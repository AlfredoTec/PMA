func functionTecsupMIT(buscar: String, nroLlamadasMax: Int) -> Bool{
    
    let nombreInstituto = buscar.split(separator: " ").last
    
    if (nombreInstituto == "Tecsup" || nombreInstituto == "MIT") {
        return true
    }
    
    if(nroLlamadasMax > 0){
        if (functionUNI(buscar: buscar)){
            return true
        } else if (nroLlamadasMax > 1 && functionUNALM(buscar: buscar)) {
            return true
        } else if (nroLlamadasMax > 2 && functionUPM(buscar: buscar)){
            return true
        }
    }
    
    return false
}

func functionUNI(buscar: String) -> Bool{
    let nombreInstituto = buscar.split(separator: " ").last
    if (nombreInstituto == "UNI") {
        return true
    }
    return false
}

func functionUNALM(buscar: String) -> Bool{
    let nombreInstituto = buscar.split(separator: " ").last
    if (nombreInstituto == "UNALM") {
        return true
    }
    return false
}

func functionUPM(buscar: String) -> Bool{
    let nombreInstituto = buscar.split(separator: " ").last
    if (nombreInstituto == "UPM") {
        return true
    }
    return false
}

print("Tecsup:", functionTecsupMIT(buscar: "Buscar Tecsup", nroLlamadasMax: 0))
print("UPC:", functionTecsupMIT(buscar: "Buscar UPC", nroLlamadasMax: 3))
print("UNI:", functionTecsupMIT(buscar: "Buscar UNI", nroLlamadasMax: 1))
print("UNALM(No encontrado):", functionTecsupMIT(buscar: "Buscar UNALM", nroLlamadasMax: 1))
print("UNALM(Encontrado):", functionTecsupMIT(buscar: "Buscar UNALM", nroLlamadasMax: 2))
print("UPM(No encontrado):", functionTecsupMIT(buscar: "Buscar UPM", nroLlamadasMax: 2))
print("UPM(Encontrado):", functionTecsupMIT(buscar: "Buscar UPM", nroLlamadasMax: 3))
