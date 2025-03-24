#' Code Agreement Parties
#'
#' Identify the countries that are part of an agreement.
#' @param title A character vector of treaty titles
#' @param activity Do you want the activity of treaty to be coded?
#' By default, TRUE.
#' @param replace Do you want the state name or abbreviation to be returned?
#' By default, NULL.
#' Other options include, "names", for the state name,
#' or "ID", for the 3 letter state abbreviation.
#' @importFrom stringr str_replace_all str_detect
#' @importFrom knitr kable
#' @return A character vector of parties
#' that are mentioned in the treaty title
#' @details The function codes states in treaty titles.
#' The function also returns the "activity" for bilateral treaties coded,
#' if activity is TRUE.
#' Bilateral agreements usually detail their activity and specify area in the
#' last words of the titles.
#' These last words are abbreviated by the function to differentiate between
#' bilateral treaties and avoid false positives being generated since multiple,
#' different, bilateral treaties are often signed in the same day.
#' For the complete list of parties coded please run the function without
#' an argument (i.e. `code_states()`).
#' @examples
#' \dontrun{
#' IEADB <- dplyr::slice_sample(manyenviron::agreements$IEADB, n = 10)
#' code_states(IEADB$Title)
#' code_states(IEADB$Title, activity = FALSE)
#' code_states(IEADB$Title, activity = FALSE, replace = "names")
#' code_states(IEADB$Title, activity = FALSE, replace = "ID")
#' }
#' @export
code_states <- function(title, activity = TRUE, replace = NULL) {
  # If missing title argument, returns list of states and abbreviations
  if (missing(title)) {
    out <- as.data.frame(countryregex)
    out$Regex[56] <- paste(substr(out$Regex[56], 0, 100), "...")
    out <- knitr::kable(out, "simple")
    out
  } else {
    # Step 1: get ISO country codes from countryregex and match in title
    title <- as.character(title)
    title <- ifelse(grepl("\\s*\\([^\\)]+\\)", title),
                    gsub("\\s*\\([^\\)]+\\)", "", title), title)
    if (is.null(replace)) {
      coment <- sapply(countryregex[, 3], function(x) grepl(x, title,
                                                            ignore.case = T,
                                                            perl = T) * 1)
      colnames(coment) <- countryregex[, 1]
      rownames(coment) <- title
      out <- apply(coment, 1, function(x) paste(names(x[x == 1]),
                                                collapse = "_"))
      out[out == ""] <- NA
      parties <- unname(out)
      parties <- stringr::str_replace_all(parties, "_", "-")
      # Step 2: add NAs to observations not matched
      parties[!grepl("-", parties)] <- NA
      # Step 3:: get bilateral agreements where two parties have been identified
      parties <- ifelse(stringr::str_detect(parties,
                                            "^[:alpha:]{3}-[:alpha:]{3}$"),
                        parties,
                        ifelse(stringr::str_detect(parties,
                                                   "^[:alpha:]{2}-[:alpha:]{3}$"),
                               parties,
                               ifelse(stringr::str_detect(parties,
                                                          "^[:alpha:]{3}-[:alpha:]{2}$"),
                                      parties, NA)))
    } else if (replace == "names") {
      # Translates string to ASCII
      title <- stringi::stri_trans_general(title, "Latin-ASCII")
      coment <- vapply(countryregex[, 3], function(x) grepl(x, title,
                                                            ignore.case = T,
                                                            perl = T) * 1,
                       FUN.VALUE = numeric(length(title)))
      colnames(coment) <- countryregex[, 2]
      rownames(coment) <- title
      out <- apply(coment, 1, function(x) paste(names(x[x == 1]),
                                                collapse = " - "))
      out[out == ""] <- NA
      parties <- unname(out)
    } else if (replace == "ID") {
      title <- stringi::stri_trans_general(title, "Latin-ASCII")
      coment <- vapply(countryregex[, 3], function(x) grepl(x, title,
                                                            ignore.case = T,
                                                            perl = T) * 1,
                       FUN.VALUE = numeric(length(title)))
      colnames(coment) <- countryregex[, 1]
      rownames(coment) <- title
      out <- apply(coment, 1, function(x) paste(names(x[x == 1]),
                                                collapse = " - "))
      out[out == ""] <- NA
      parties <- unname(out)
    }
  }
  # Step 4: get activity
  if (isTRUE(activity)) {
    out <- code_activity(title)
    parties <- ifelse(is.na(parties), parties, paste0(parties, "[", out, "]"))
  }
  parties
}

# Regex ####
countryregex <- dplyr::tribble(
  ~stateID, ~Label, ~Regex,
  ## A ####
  "ABK","Abkhazia","abkhaz",
  "ACH","Aceh","aceh",
  "AFG","Afghanistan","afghan|afghanistan",
  "AGO","Angola","angola",
  "ALB","Albania","albania|albanie",
  "ALT","Los Altos","los altos",
  "AND","Andorra","andorra|andorre",
  "ARE","United Arab Emirates","emirates|u[[:punct:]]a[[:punct:]]e[[:punct:]]|uae|united.?arab.?em|emirats arabes unis",
  "ARG","Argentina","argentin|argentine",
  "ARM","Armenia","armenia|armenie",
  "ASA","Assam","assam",
  "ASI","Asir","asir",
  "AST","Ashanti","ashanti",
  "ATG","Antigua and Barbuda","antigua|barbuda|antigua-et-barbuda",
  "AUH","Austria-Hungary","austria-hungary",
  "AUS","Australia","australia|australie",
  "AUT","Austria","austria(?!-hungary| hungary)|austri.*emp|austrian|autriche",
  "AZA","Azande","azande",
  "AZE","Azerbaijan","azerbaijan|azerbaidjan",
  ## B ####
  "BAD","Baden","baden",
  "BAV","Bavaria","bavaria",
  "BDI","Burundi","burundi",
  "BEL","Belgium","(?!.*luxem).*belgium|belgian|flemish|belgique",
  "BEN","Benin","benin|dahome|dahomey",
  "BFA","Burkina Faso","burkina|\bfaso|upper.?volta|burkina faso",
  "BGD","Bangladesh","bangladesh|(?=.*east).*paki?stan|bangladesh",
  "BGR","Bulgaria","bulgaria|bulgarie",
  "BHP","Bhopal","bhopal",
  "BHR","Bahrain","bahr.?in|bahre.?n|bahrein",
  "BHS","Bahamas","bahamas",
  "BHT","Bharatpur","bharatpur",
  "BIH","Bosnia and Herzegovina","herzegovina|bosnia|bosnie-herzegovine",
  "BIK","Bikaner","bikaner",
  "BLR","Belarus","belarus|byelo|bielorussie",
  "BLZ","Belize","belize|(?=.*british).*honduras|belize",
  "BNJ","Benjermassin","benjermassin",
  "BOL","Plurinational State of Bolivia","bolivia|bolivie",
  "BPR","Bahawalpur","bahawalpur",
  "BRA","Brazil","brazil|brasil|bresil",
  "BRB","Barbados","barbados|barbade",
  "BRE","Bremen","bremen",
  "BRN","Brunei Darussalam","brun.?i|brunei darussalam",
  "BTN","Bhutan","bhutan|bhoutan",
  "BUK","Bukhara","bukhara",
  "BUR","Urundi","urundi",
  "BWA","Botswana","botswana|bechuana|botswana",
  ## C ####
  "CAF","Central African Republic","\bcentral.african.republic|central afr.* rep.*|republique centrafricaine",
  "CAN","Canada","canada|canadian|canada",
  "CAY","Cayor","cayor|Kajoor",
  "CHE","Switzerland","switz|swiss|suisse",
  "CHL","Chile","\bchile|chili",
  "CHM","Chamba","chamba",
  "CHN","China","(?!.*\bmac)(?!.*\bhong)(?!.*\btai)(?!.*\brep).*china|(?=.*peo)(?=.*rep).*china|chine",
  "CIV","Cote d'Ivoire","ivoire|ivory|cote d'ivoire",
  "CMR","Cameroon","cameroon|cameroun|cameroun",
  "COD","Democratic Republic of the Congo","dem.*congo|congo(.+)?dem|d[[:punct:]]r[[:punct:]]c[[:punct:]]|belgian.?congo|congo.?free.?state|kinshasa|zaire|l.opoldville|drc| droc |rdc|^droc | droc$|congo-kinshasa",
  "COG","Congo","(?=rep).*congo|(?<!democratic )republic of the congo|congo[[:punct:]]? (?!dem.*)rep|^congo$|congo-brazzaville",
  "COK","Cook Islands","\bcook|iles cook",
  "COL","Colombia","(?<!great |gran )colombia|colombie",
  "COM","Comoros","comoro|comores",
  "CPV","Cape Verde","verde|cap-vert",
  "CRI","Costa Rica","costa.?rica|costa rica",
  "CUB","Cuba","\bcuba|cuba",
  "CUT","Cutch","cutch|Kutch|Kachchh",
  "CYP","Cyprus","cyprus|chypre",
  "CZE","Czech Republic","(?=.*rep).*czech|czechia|bohemia|czechoslovakia|tchequie",
  ## D ####
  "DDR","German Democratic Republic","german democratic rep|democratic.?rep.*germany|east.germany",
  "DEU","Germany","(?<!east )germany|german(?!.*democratic) republic|prussia|allemagne",
  "DFR","Darfur","darfur",
  "DIR","Dir"," dir ",
  "DJA","Fouta Djallon","fouta djallon",
  "DJI","Djibouti","djibouti",
  "DMA","Dominica","dominica(?!n)|dominique",
  "DNK","Denmark","denmark|danish(?!.*waters)|danemark",
  "DOM","Dominican Republic","dominican.rep|republique dominicaine",
  "DRV","Annam","annam",
  "DZA","Algeria","ottoman.?algeria|algerie|(?<!ottoman )algeria",
  "DZG","Free City of Danzig","free city of danzig",
  ## E ####
  "EAZ","Zanzibar","zanzibar",
  "ECU","Ecuador","ecuador|equateur",
  "EGY","Egypt","egypt|egypte",
  "EHT","State of Haiti","state of haiti",
  "ERI","Eritrea","eritrea|erythree",
  "ESH","Western Sahara","western sahara|sahrawi|sahara occidental",
  "ESP","Spain","spain|castile|spanish(?! guinea)|espagne",
  "EST","Estonia","estonia|estonie",
  "ETH","Ethiopia","ethiopia|abyssinia|ethiopie",
  "ETS","Eastern Turkistan","eastern turkistan",
  "EUE","European Union","european union|\seu\s|\beu\b|^e[[:punct:]]u[[:punct:]]\s|\se[[:punct:]]u[[:punct:]]\s|\se[[:punct:]]u[[:punct:]]$|\be[[:punct:]]u[[:punct:]]\b",
  ## F ####
  "FIN","Finland","finland|finlande",
  "FJI","Fiji","fiji|fidji",
  "FNJ","Funj","funj",
  "FRA","France","(?!.*\bdep)(?!.*martinique).*france|french.?republic|\bgaul|france",
  "FRO","Faroe Islands","faroe|faeroe|iles feroe",
  "FSM","Federated States of Micronesia","micronesia|micronesie (etats federes de)",
  "FTO","Fouta Toro","fouta toro|futa",
  ## H ####
  "HAN","Hanover","hanover",
  "HAW","Hawaii","hawaii",
  "HBG","Hamburg","hamburg",
  "HEJ","Hejaz","hejaz",
  "HKG","Hong Kong","Hong Kong|r.a.s. chinoise de hong kong",
  "HND","Honduras","(?<!british )honduras|honduras",
  "HRV","Croatia","croatia|croatie",
  "HSE","Hesse Electoral","hesse.*lectoral|hesse.kassel",
  "HSG","Hesse Grand Ducal","hess.*gran.*ducal|hesse.darmstadt",
  "HTI","Haiti","haiti|hayti|haiti",
  "HUN","Hungary","(?<!austria-|austria )hungary|hungarian|hongrie",
  ## I ####
  "IDN","Indonesia","indonesia|indonesie",
  "IND","India","india(?!.*ocea)|inde",
  "INO","Indore","indore",
  "IPH","Perak","perak",
  "IRL","Ireland","(?=.*(?<!northern )ireland)(?=.*(?<!britain and )ireland)|irish|irlande",
  "IRN","Islamic Republic of Iran","\biran|persia|iran",
  "IRQ","Iraq","\biraq|mesopotamia|irak",
  "ISL","Iceland","iceland|islande",
  "ISR","Israel","israel",
  "ITA","Italy","italy|italian|italo|italie",
  ## J ####
  "JAM","Jamaica","jama.?ca|jamaique",
  "JMK","Jimma-Kakka","jimma-kakka",
  "JOD","Jodhpur","jodhpur",
  "JOH","Johore","johor",
  "JOR","Jordan","jordan|jordanie",
  "JPN","Japan","japan|nippon|japon",
  "JPR","Jaipur","jaipur",
  ## N ####
  "NAG","Nagpur","nagpur",
  "NAM","Namibia","namibia|namibie",
  "NAS","Nassau","nassau",
  "NER","Niger","\bniger(?!ia)",
  "NGA","Nigeria","nigeria",
  "NIC","Nicaragua","nicaragua",
  "NIU","Niue","niue",
  "NLD","Netherlands","(?!.*ant)(?!.*carib).*netherlands|netherlands.antil|dutch.antil|aruba|curacao|pays-bas",
  "NOR","Norway","norway|norweg|norvege",
  "NPL","Nepal","nepal",
  "NRU","Nauru","nauru",
  "NZL","New Zealand","new.?zealand|nouvelle-zelande",
  ## O ####
  "OFS","Orange Free State","orange free state|\sovs\s",
  "OLD","Oldenburg","oldenburg",
  "OMN","Oman","\boman|trucial",
  "OVB","Ovimbundu","ovimbundu",
  "OYO","Oyo","oyo",
  ## P ####
  "PAH","Pahang","pahang",
  "PAK","Pakistan","(?<!east |eastern )paki?stan|pakistan",
  "PAL","Palembang","palembang",
  "PAN","Panama","panama",
  "PER","Peru","peru|perou",
  "PES","Peshwa","peshwa",
  "PHL","Philippines","philippines",
  "PLW","Palau","palau|palaos",
  "PMA","Parma","parma",
  "PNG","Papua New Guinea","papua|new.?guinea|papouasie-nouvelle-guinee",
  "POL","Poland","poland|polish|pologne",
  "PPR","Polish Peoples Republic","polish peoples republic",
  "PRK","Democratic People's Republic of Korea","dprk|d.p.r.k|korea.+(d.p.r|dpr|north|dem.*peo.*rep.*)|(d.p.r|dpr|dem.*peo.*rep.*).+korea|north korea|coree du nord",
  "PRT","Portugal","portugal|portuguese|portugal",
  "PRY","Paraguay","paraguay(?! river)|paraguay",
  "PSE","Gaza Empire","palestin|\bgaza|west.?bank|territoires palestiniens",
  "PUN","Punjab","punjab|panj.?b|panj-.?b",
  ## Q ####
  "QAT","Qatar","qatar",
  "QUA","Qu'aiti Sultanate","qu'aiti sultanate",
  ## T ####
  "TBT","Tibet","tibet",
  "TCD","Chad","\bchad|tchad",
  "TER","Terengganu","terengganu|trengganu|tringganu",
  "TEX","Texas","texas",
  "TGO","Togo","togo",
  "THA","Thailand","thailand|\bsiam|thailande",
  "TJK","Tajikistan","tajik|tadjikistan",
  "TKL","Tokelau","tokelau",
  "TKM","Turkmenistan","turkmen|turkmenistan",
  "TLS","Timor-Leste","(?=.*leste).*timor|(?=.*east).*timor|timor oriental",
  "TOK","Tokolor","tokolor",
  "TON","Tonga","tonga",
  "TRA","Transvaal","transvaal",
  "TTO","Trinidad and Tobago","trinidad|tobago|trinite-et-tobago",
  "TUN","Tunisia","tunisia|tunisie",
  "TUR","Turkiye","turkey|turkiye|turquie",
  "TUS","Tuscany","tuscany",
  "TUV","Tuvalu","tuvalu",
  "TWN","Chinese Taipei","taiwan|taipei|formosa|taiwan",
  "TZA","United Republic of Tanzania","tanzania|tanzanie",
  ## W ####
  "WAD","Wadai","wadai",
  "WRT","Wuerttemburg","w(ue|ü)rttemburg|w.rtemberg",
  "WSM","Samoa","(?!.*amer).*samoa|samoa",
  ## Z ####
  "ZAF","South Africa","south.africa|s\. africa|afrique du sud",
  "ZIN","Zinder (Damagaram)","zinder (damagaram)",
  "ZMB","Zambia","zambia|northern.?rhodesia|zambie",
  "ZUL","Zululand","zululand",
  "ZWE","Zimbabwe","zimbabwe|(?<!northern )rhodesia|zimbabwe",
  ## Other ####
  "EC","European Community","european economic community|european community|e[[:punct:]]c[[:punct:]]|^eec$|^ec$",
  "AU","African Union","african union",
  "EFTA","European Free Trade Association","^efta$|european free trade association"
)
