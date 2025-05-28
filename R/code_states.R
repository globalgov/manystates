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

#' @export
code_states2 <- function(charvec, code = TRUE){
  
  purrr::map_chr(charvec, function(x) {
    out <- as.data.frame(countryRegex)[
                      which(stringi::stri_detect_regex(stringi::stri_enc_toutf8(x), 
                                                       unlist(countryRegex[, 3]),
                                                 max_count = 1,
                                                 opts_regex = list(case_insensitive = TRUE))),
                      ifelse(code, 1, 2)]
    if(length(out)==0) NA_character_ else out
  })
}

# Regex ####
countryRegex <- dplyr::tribble(
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
  "AUH","Austria-Hungary","austria-hungary|austro-hungaria|aust-hung|aust empire|autria empire|austrian empire",
  "AUS","Australia","australia|australie|christmas is|cocos.*is|heard.is|mcdonald.is",
  "AUT","Austria","austria(?!-hungary| hungary)|austri.*emp|austrian|autriche",
  "AZA","Azande","azande",
  "AZE","Azerbaijan","azerbaijan|azerbaidjan|azerbeijan",
  ## B ####
  "BAD","Baden","baden",
  "BAV","Bavaria","bavaria",
  "BDI","Burundi","burundi",
  "BEL","Belgium","(?!.*luxem).*belgium|belgian|flemish|belgique|walloon|brussels|bruxelles",
  "BEN","Benin","benin|dahome|dahomey|benin",
  "BFA","Burkina Faso","burkina|faso|upper.?volta|burkina ?faso|burkna faso",
  "BGD","Bangladesh","bangladesh|(?=.*east).*paki?stan|bangladesh",
  "BGR","Bulgaria","bulgaria|bulgarie",
  "BHP","Bhopal","bhopal",
  "BHR","Bahrain","bahr.?in|bahre.?n|bahrein",
  "BHS","Bahamas","bahamas",
  "BHT","Bharatpur","bharatpur",
  "BIH","Bosnia and Herzegovina","herzegovina|bosnia|bosnie-herzegovine|herzego|bosnie",
  "BIK","Bikaner","bikaner",
  "BLR","Belarus","belarus|byelo|bielorussie|belarus",
  "BLZ","Belize","belize|(?=.*british).*honduras|belize",
  "BNJ","Benjermassin","benjermassin",
  "BOL","Plurinational State of Bolivia","bolivia|bolivie",
  "BPR","Bahawalpur","bahawalpur",
  "BRA","Brazil","brazil|brasil|bresil|bresil",
  "BRB","Barbados","barbados|barbade",
  "BRE","Bremen","bremen",
  "BRN","Brunei Darussalam","brun.?i|brunei darussalam",
  "BTN","Bhutan","bhutan|bhoutan",
  "BUK","Bukhara","bukhara",
  "BUR","Urundi","urundi|burundi",
  "BWA","Botswana","botswana|bechuana|botswana",
  ## C ####
  "CAF","Central African Republic","central.african.republic|cen.* afr.* re.*|republique centrafricaine|centrafrique|centrafricaine|cen afr emp",
  "CAN","Canada","canada|canadian|canada|newfoundland",
  "CAY","Cayor","cayor|Kajoor",
  "CHE","Switzerland","switz|swiss|suisse",
  "CHL","Chile","chile|chili",
  "CHM","Chamba","chamba",
  "CHN","China","(?!.*\bmac)(?!.*\bhong)(?!.*\btai)(?!.*\brep).*china|(?=.*peo)(?=.*rep).*china|chine|macao",
  "CIV","Cote d'Ivoire","ivoire|ivory|cote d'ivo.+",
  "CMR","Cameroon","cameroon|cameroun|cameroun",
  "COD","Democratic Republic of the Congo","dem.*congo|congo(.+)?dem|d[[:punct:]]r[[:punct:]]c[[:punct:]]|belgian.?congo|congo.?free.?state|kinshasa|zaire|l.opoldville|drc| droc |rdc|droc|congo-kinshasa|congo dr|d.r. of the congo|congo.+kin",
  "COG","Congo","(?=rep).*congo|(?<!democratic )republic of the congo|congo[[:punct:]]? (?!dem.*)rep|^congo$|congo-brazzaville|brazzaville|congobrazz|congo.+bra|congo.+rep",
  "COK","Cook Islands","cook.is|iles.cook",
  "COL","Colombia","(?<!great |gran )colombia|colombie",
  "COM","Comoros","comoro|comores",
  "CPV","Cape Verde","verde|cap-vert|cabo verde|cap vert",
  "CRI","Costa Rica","costa.?rica|costa rica",
  "CUB","Cuba","\bcuba|cuba",
  "CUT","Cutch","cutch|Kutch|Kachchh",
  "CYP","Cyprus","cyprus|chypre",
  "CZE","Czech Republic","(?=.*rep).*czech|czechia|bohemia|czechoslovakia|tchequie|czech|tchequ.+",
  ## D ####
  "DDR","German Democratic Republic","german.dem.*rep|democratic.?rep.*germany|east.germany|ddr|german.dr",
  "DEU","Germany","(?<!east )germany|german(?!.*democratic) republic|prussia|allemagne|german.fr|german.fed|alsace-lorraine|brunswick|berlin",
  "DFR","Darfur","darfur",
  "DIR","Dir"," dir ",
  "DJA","Fouta Djallon","fouta djallon",
  "DJI","Djibouti","djibouti",
  "DMA","Dominica","dominica(?!n)|dominique",
  "DNK","Denmark","denmar|danish(?!.*waters)|danemark|faroe|greenland",
  "DOM","Dominican Republic","domin.*rep|republique dominicaine|santo domin",
  "DRV","Annam","annam",
  "DZA","Algeria","ottoman.?algeria|algerie|(?<!ottoman )algeria",
  "DZG","Free City of Danzig","free city of danzig",
  ## E ####
  "EAZ","Zanzibar","zanzibar",
  "ECU","Ecuador","ecuador|equateur",
  "EGY","Egypt","egypt|egypte|united arab republic|(?<![:alpha:])uar(?![:alpha:])",
  "EHT","State of Haiti","state of haiti",
  "ERI","Eritrea","eritrea|erythr[ee]e",
  "ESH","Western Sahara","western.sahara|sahrawi|sahara occidental",
  "ESP","Spain","spain|castile|spanish(?! guinea)|espagne|canary|granada",
  "EST","Estonia","estonia|estonie",
  "ETH","Ethiopia","ethiopia|abyssinia|ethiopie|eth.pia",
  "ETS","Eastern Turkistan","eastern turkistan",
  "EUE","European Union","european union|\beu\b|\be[[:punct:]]u[[:punct:]]\b",
  ## F ####
  "FIN","Finland","finland|finlande|aland",
  "FJI","Fiji","fiji|fidji",
  "FNJ","Funj","funj",
  "FRA","France","(?!.*\bdep)(?!.*martinique).*france|french.?republic|gaul|france|french|guadeloupe|burgundy|mayotte|new.caledonia|martinique|r[ee]union|barthelemy|t.martin|st\\..martin|miquelon|futuna",
  "FRO","Faroe Islands","faroe|faeroe|iles feroe",
  "FSM","Federated States of Micronesia","micronesia|micron[ee]sie",
  "FTO","Fouta Toro","fouta toro|futa",
  ## G ####
  "GAB","Gabon","gabon",
  "GBR","United Kingdom",",
england|united.?kingdom|britain|british(?!.*hondur| east africa)|\buk\b|\bu[[:punct:]]k[[:punct:]]\b|royaume-uni|bermuda|anguilla|cayman|channel.is|akrotiri|dhekelia|falkland.is|virgin.is|gibraltar|guernsey|guernesey|jersey|isle of man|northern.ireland|pitcairn|helena|norfolk|montserrat|south.sandwich.is|caicos|grande.bretagne|england",
  "GCL","Gran Colombia","gran colombia|great colombia",
  "GEO","Georgia","(?<!south )georgia|georgie|georgie",
  "GHA","Ghana","ghana|gold.?coast|ghana",
  "GIN","Guinea","(?<!new |spanish |portuguese |equatorial )guinea(?!.*equ|-bissau| bissau)|\bguinee\b",
  "GMB","Gambia","gambia|gambie",
  "GNB","Guinea-Bissau","bissau|(?=.*portu).*guinea|guin[ee]e.bissa[uo]",
  "GNQ","Equatorial Guinea","guine.*eq|eq.*guine|(?=.*span).*guinea|guin[ee]e [ee]quatoriale",
  "GRC","Greece","greece|hellenic|hellas|greek|gr[e]ce",
  "GRD","Grenada","grenada|grenade",
  "GTM","Guatemala","guatemala",
  "GUY","Guyana","guyana|british.?guiana|guyana",
  "GWA","Gwalior","gwalior",
  ## H ####
  "HAN","Hanover","hanover",
  "HAW","Hawaii","hawaii",
  "HBG","Hamburg","hamburg",
  "HEJ","Hejaz","hejaz",
  "HKG","Hong Kong","hong.kong|r.a.s. chinoise de hong kong",
  "HND","Honduras","(?<!british )honduras|honduras",
  "HRV","Croatia","croatia|croatie",
  "HSE","Hesse Electoral","hesse.*lectoral|hesse.kassel|hesseelect",
  "HSG","Hesse Grand Ducal","hess.*gran.*ducal|hesse.darmstadt|hessegrand",
  "HTI","Haiti","haiti|hayti",
  "HUN","Hungary","(?<!austria-|austria )hungary|hungarian|hongrie",
  ## I ####
  "IDN","Indonesia","indonesia|indonesie",
  "IND","India","india(?!.*ocea)|inde",
  "INO","Indore","indore",
  "IPH","Perak","perak",
  "IRL","Ireland","(?=.*(?<!northern )ireland)(?=.*(?<!britain and )ireland)|irish|irlande",
  "IRN","Islamic Republic of Iran","\biran|persia|iran",
  "IRQ","Iraq","iraq|mesopotamia|irak",
  "ISL","Iceland","iceland|islande",
  "ISR","Israel","israel",
  "ITA","Italy","italy|italian|italo|italie",
  ## J ####
  "JAM","Jamaica","jama.?ca|jama[i]que",
  "JMK","Jimma-Kakka","jimma-kakka",
  "JOD","Jodhpur","jodhpur",
  "JOH","Johore","johor",
  "JOR","Jordan","jordan|jordanie",
  "JPN","Japan","japan|nippon|japon",
  "JPR","Jaipur","jaipur",
  ## K ####
  "KAF","Kaffa","kaffa",
  "KAS","Kasanje","kasanje",
  "KAT","Kathiri Sultanate","kathiri sultanate",
  "KAZ","Kazakhstan","kazak|kazakhstan",
  "KED","Kedah","kedah",
  "KEL","Kelantan","kelantan",
  "KEN","Kenya","kenya|british.?east.?africa|east.?africa.?prot|kenya",
  "KGZ","Kyrgyzstan","kyrgyz|kirghiz|kirghizistan",
  "KHI","Khairpur","khairpur|khayrpur",
  "KHM","Cambodia","cambodia|kampuchea|khmer|cambodge",
  "KHV","Khiva","khiva",
  "KIR","Kiribati","kiribati",
  "KLT","Kalat","kalat",
  "KNA","St. Kitts and Nevis","kitts|nevis|saint-christophe.et.nieves|st.kitt",
  "KNB","Kanem-Bornu","kanem-bornu",
  "KOK","Kokand","kokand",
  "KON","Kongo Kingdom","kongo kingdom",
  "KOR","Republic of Korea","(?<!d.p.r. |dpr |democrat |Democratic People's Republic of |north )korea(?!.*d.p.r)|cor[ee]e.*sud|r[ee]publique.de.cor[ee]e",
  "KOS","Kosovo","kosovo",
  "KOT","Kotah","kotah",
  "KPT","Kapurthala","kapurthala",
  "KRG","Karangasem (Bali and Lombok)","karangasem (bali and lombok)",
  "KTA","Kaarta","kaarta",
  "KUB","Kuba","kuba",
  "KWT","Kuwait","kuwait|koweit",
  "KZB","Kazembe","kazembe",
  ## L ####
  "LAO","Lao People's Democratic Republic","laos|lao.pdr|lao.people|lao, p.*d.*r|lao.*p\\.d\\.r",
  "LBN","Lebanon","lebanon|liban",
  "LBR","Liberia","liberia|liberia",
  "LBY","Libya","libya|tripolitania|libye",
  "LCA","St. Lucia","lucia|sainte-lucie",
  "LIE","Liechtenstein","liechtenstein|liechtstein",
  "LIM","Enarya (Limmu)","enarya (limmu)",
  "LIP","Lippe","lippe",
  "LKA","Sri Lanka","sri.?lanka|ceylon|sri lanka",
  "LSO","Lesotho","lesotho|basuto.*",
  "LTU","Lithuania","lithuania|lituanie|lithuanie",
  "LUB","Luba","luba",
  "LUN","Lunda Empire","lunda empire|kingdom of lunda",
  "LUX","Luxembourg","(?<!belgian )luxem|luxembourg",
  "LVA","Latvia","latvia|lettonie",
  ## M ####
  "MAR","Morocco","morocco|\bmaroc|maroc",
  "MAS","Massina","massina|maasina|macina",
  "MCO","Monaco","monaco",
  "MDA","Republic of Moldova","moldov|moldavia|b(a|e)ssarabia|moldavie",
  "MDG","Madagascar","madagascar|malagasy|madagasacar",
  "MDK","Mandinka Empire (Wassulu)","mandinka empire (wassulu)",
  "MDV","Maldives","maldive|maldives",
  "MEC","Mecklenburg Schwerin","mecklenbur.*schwerin|mecklenbur",
  "MEX","Mexico","mexic|mexique",
  "MHL","Marshall Islands","marshall|iles marshall",
  "MIN","Minangkabau","minangkabau",
  "MKD","North Macedonia","macedonia|fyrom|former yugoslav republic of mac.*|mac[ee]doine",
  "MLI","Mali","mali",
  "MLT","Malta","malta|malte",
  "MMR","Myanmar","myanmar|burma|myanmar (birmanie)",
  "MNE","Montenegro","(?!.*serbia).*montenegro|mont[ee]n[ee]gro",
  "MNG","Mongolia","mongol|mongolie",
  "MOD","Modena","modena",
  "MOS","Yatenga (Mossi)","yatenga (mossi)",
  "MOZ","Mozambique","mozambique",
  "MPR","Manipur","manipur",
  "MRT","Mauritania","mauritania|mauritanie",
  "MUS","Mauritius","mauritius|maurice",
  "MWI","Malawi","malawi|nyasa|malawi",
  "MYS","Malaysia","malaysia|malaisie|malay",
  ## N ####
  "NAG","Nagpur","nagpur",
  "NAM","Namibia","namibia|namibie",
  "NAS","Nassau","nassau",
  "NER","Niger","niger(?!ia)",
  "NGA","Nigeria","nig[ee]ria",
  "NIC","Nicaragua","nicaragua",
  "NIU","Niue","niue|niou[ee]",
  "NLD","Netherlands","(?!.*ant)(?!.*carib).*netherlands|netherlands.antil|dutch.antil|aruba|curacao|pays-bas|bonaire|holland",
  "NOR","Norway","norway|norweg|norv[e]ge|bouvet|svalbard",
  "NPL","Nepal","n[ee]pal",
  "NRU","Nauru","nauru",
  "NZL","New Zealand","new.?zealand|nouvelle.z[ee]lande",
  ## O ####
  "OFS","Orange Free State","orange free state|ovs",
  "OLD","Oldenburg","oldenburg",
  "OMN","Oman","oman|trucial|omaan",
  "OVB","Ovimbundu","ovimbundu",
  "OYO","Oyo","oyo",
  ## P ####
  "PAH","Pahang","pahang",
  "PAK","Pakistan","(?<!east |eastern )paki?stan|pakistan",
  "PAL","Palembang","palembang",
  "PAN","Panama","panama",
  "PER","Peru","peru|p[ee]rou",
  "PES","Peshwa","peshwa",
  "PHL","Philippines","philippines",
  "PLW","Palau","palau|palaos",
  "PMA","Parma","parma",
  "PNG","Papua New Guinea","papua|new.?guinea|papouasie",
  "POL","Poland","poland|polish|pologne|danzig",
  "PPR","Polish Peoples Republic","polish peoples republic",
  "PRK","Democratic People's Republic of Korea","dprk|d.p.r.k|korea.+(d.p.r|dpr|north|dem.*peo.*rep.*)|(d.p.r|dpr|dem.*peo.*rep.*).+korea|north korea|cor[ee]e.*nord",
  "PRT","Portugal","portugal|portuguese|portugal|azores|acores",
  "PRY","Paraguay","paraguay(?! river)|paraguay",
  "PSE","Gaza Empire","palestin|\bgaza|west.?bank|territoires palestiniens",
  "PUN","Punjab","punjab|panj.?b|panj-.?b",
  ## Q ####
  "QAT","Qatar","qatar",
  "QUA","Qu'aiti Sultanate","qu'aiti sultanate",
  ## R ####
  "ROU","Romania","r(o|u|ou)mania|roumanie",
  "RUS","Russian Federation","russia|russian fed.*|soviet.?union|union of soviet|u[[:punct:]]s[[:punct:]]s[[:punct:]]r[[:punct:]]|socialist.?republics|USSR|RSFSR|russie|un.*sov.*soc.*rep",
  "RVN","Republic of Vietnam","(?<!socialist|democratic) republic.of.viet.?nam|republic.of.viet.?nam|viet.?nam rep|south.viet.?nam|viet.?nam.south|svietnam|vietnam, s|vietnam, r",
  "RWA","Rwanda","rwanda|rwandese|ruanda",
  ## S ####
  "SAL","Saloum","saloum",
  "SAR","Sardinia","sardinia|Sardinia",
  "SAU","Emirate of Diriyah","sa.*arabia|first saudi state|emirate of dir.?iyah|arabie saoudite",
  "SAW","Sawantvadi","sawantvadi|sawantwadi",
  "SAX","Saxony","saxony",
  "SDN","Sudan","(?<!south )sudan|soudan|funj sultanate of sennar",
  "SEG","Segou","segou|s.?gou",
  "SEL","Selangor","selangor",
  "SEN","Senegal","s[ee]n[ee]gal",
  "SGP","Singapore","singapore|singapour",
  "SHO","Shoa","shoa|shewa|shua|showa|shuwa",
  "SIA","Siak","siak|siunia|syunik",
  "SIC","Two Sicilies","two.?sicilies|2.?sicilies",
  "SID","Sind","sind|sindh",
  "SIK","Sikkim","sikkim",
  "SIR","Sirohi","sirohi",
  "SLB","Solomon Islands","solomon|salomon",
  "SLE","Sierra Leone","sierra.leo",
  "SLV","El Salvador","el.?salvador|salvador",
  "SMR","San Marino","san.?marino|saint-marin",
  "SOK","Sokoto","sokoto",
  "SOM","Somalia","somali|somalie",
  "SOT","South Ossetia","south ossetia",
  "SRB","Serbia","(?!.*monte).*serbia|serbie|yugoslav",
  "SSD","South Sudan","south.sudan|soudan du sud",
  "STP","Sao Tome and Principe","s[a]o.tom[ee]|sao tome-et-principe|saotome",
  "SUL","Sulu","sulu",
  "SUR","Suriname","surinam|dutch.?guiana|suriname",
  "SVK","Slovakia","(?<!czecho)slovak|slovaquie|slovaque",
  "SVN","Slovenia","sloven|slov[ee]nie",
  "SWA","Swat","^swat$|dera yusufzai",
  "SWE","Sweden","swed|su[e]de",
  "SWZ","Eswatini","swaziland|eswatini",
  "SXA","Saxe-Atenburg","saxe-atenburg",
  "SXG","Saxe-Coburg-Gotha","saxe-coburg-gotha",
  "SXM","Saxe-Meiningen-Hidburghausen","(?!.*martin)(?!.*saba).*maarten|saint-martin (partie neerlandaise)",
  "SXW","Saxe-Wiemar-Eisenach","saxe.weimar.eisenach",
  "SYC","Seychelles","seychell|seychelles",
  "SYR","Syrian Arab Republic","syria|syrie",
  ## T ####
  "TBT","Tibet","tibet",
  "TCD","Chad","chad|tchad",
  "TER","Terengganu","terengganu|trengganu|tringganu",
  "TEX","Texas","texas",
  "TGO","Togo","togo",
  "THA","Thailand","thailand|siam|tha[i]lande",
  "TJK","Tajikistan","tajik|tadjikistan",
  "TKL","Tokelau","tokelau",
  "TKM","Turkmenistan","turkmen|turkmenistan|turkmenistan",
  "TLS","Timor-Leste","(?=.*leste).*timor|(?=.*east).*timor|timor oriental|timor.?leste",
  "TOK","Tokolor","tokolor",
  "TON","Tonga","tonga",
  "TRA","Transvaal","transvaal",
  "TTO","Trinidad and Tobago","trinidad|tobag|trinite",
  "TUN","Tunisia","tunisia|tunisie",
  "TUR","Turkiye","turkey|t[u]rkiye|turquie|ottoman emp",
  "TUS","Tuscany","tuscany",
  "TUV","Tuvalu","tu[vl]a[lv]u",
  "TWN","Chinese Taipei","ta[i]wan|taipei|formosa",
  "TZA","United Republic of Tanzania","tanzania|tanzanie|tanganyika",
  ## U ####
  "UGA","Uganda","uganda|buganda|ouganda",
  "UKR","Ukraine","ukrain|ukraine|ukrainian ssr|ukrainian soviet",
  "UPC","United Provinces of Central America","united provinces of central america|United Provinces of CA|United Province of CA|United Province CA",
  "UPR","Udaipur","udaipur",
  "URY","Uruguay","uruguay",
  "USA","United States of America","united states of america|united.states(?!.*of brazil)|u[[:punct:]]s[[:punct:]]a[[:punct:]]|u[[:punct:]]s[[:punct:]](?!.*s[[:punct:]]r[[:punct:]])|\busa\b|\bus\b|etats-unis|northern.mariana|puerto.rico|guam|(?<![:alpha:])usa(?![:alpha:])",
  "UZB","Uzbekistan","uzbek|ouzb[ee]kistan",
  ## V ####
  "VAT","Holy See","holy.?see|vatican|papal.?st|etat de la cite du vatican|saint.siege",
  "VCT","St. Vincent and the Grenadines","vincent|saint-vincent-et-les-grenadines|st.vin",
  "VEN","Bolivarian Republic of Venezuela","v[ee]n[ee]zu[ee]la",
  "VNM","Viet Nam","(?<=socialist|democratic|north).*viet.?nam|viet.?nam socialist|viet.?nam democratic|\bviet.?nam$|viet.?nam.?dem|dem.?rep.?viet.?nam|viet.?nam n|viet.?nam, n|viet.?nam, d|viet.?nam d|viet.?nam",
  "VUT","Vanuatu","vanuatu|new.?hebrides|vanuatu",
  ## W ####
  "WAD","Wadai","wadai",
  "WRT","Wuerttemburg","w(ue)rttemburg|w.rtemberg",
  "WSM","Samoa","(?!.*amer).*samoa|samoa",
  ## Y ####
  "YEK","Yeke Kingdom","yeke kingdom",
  "YEM","Yemen","(?<= arab|north|sana).*yemen|yemen(?= arab)|y[ee]men",
  "YPR","Yemen Peoples Republic","(?=.*peo).*yemen|(?!.*rep)(?=.*dem).*yemen|(?=.*south).*yemen|(?=.*aden).*yemen|(?=.*\bp\\.?d\\.?r).*yemen|aden",
  "YUG","Yugoslavia","yugoslavia",
  ## Z ####
  "ZAF","South Africa","south.africa|s\\. africa|afrique du sud|so.africa|venda|bophutatswana|transkei|ciskei",
  "ZIN","Zinder (Damagaram)","zinder (damagaram)",
  "ZMB","Zambia","zambia|northern.?rhodesia|zambie",
  "ZUL","Zululand","zululand",
  "ZWE","Zimbabwe","zimbabwe|(?<!northern )rhodesia|zimbabwe",
  ## Other ####
  "EC","European Community","european economic community|european community|e[[:punct:]]c[[:punct:]]|(?<![:alpha:])eec(?![:alpha:])|european.comm|european.union|euratom|union.euro|eu-15",
  "AU","African Union","african.union",
  "EFTA","European Free Trade Association","(?<![:alpha:])efta(?![:alpha:])|european free trade association"
)
