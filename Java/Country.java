public enum Country {

    Austria("Austria", "AT", "AUT", 40, "+43"),
    Albania("Albania", "AL", "AUB", 8, "+355"),
    Belgium("Belgium", "BE", "BEL", 56, "+32"),
    BosniaAndHerzegovina("Bosnia and Herzegovina", "BA", "BIH", 70, "+387"),
    Bulgaria("Bulgaria", "BG", "BGR", 100, "+359"),
    Croatia("Croatia", "HR", "HRV", 191, "+385"),
    Cyprus("Cyprus", "CY", "CYP", 196, "+357"),
    Czechia("Czechia", "CZ", "CZE", 203, "+420"),
    Denmark("Denmark", "DK", "DNK", 208, "+45"),
    Estonia("Estonia", "EE", "EST", 233, "+372"),
    FaroeIslands("Faroe Islands", "FO", "FRO", 234, "+298"),
    Finland("Finland", "FI", "FIN", 246, "+358"),
    France("France", "FR", "FRA", 250, "+33"),
    Germany("Germany", "DE", "DEU", 276, "+49"),
    Greece("Greece", "GR", "GRC", 300, "+30"),
    Hungary("Hungary", "HU", "HUN", 384, "+36"),
    Iceland("Iceland", "IS", "ISL", 352, "+354"),
    Ireland("Ireland", "IE", "IRL", 372, "+353"),
    Italy("Italy", "IT", "ITA", 380, "+39"),
    Latvia("Latvia", "LV", "LVA", 428, "+371"),
    Lithuania("Lithuania", "LT", "LTU", 440, "+370"),
    Luxembourg("Luxembourg", "LU", "LUX", 442, "+352"),
    Macedonia("Macedonia", "MK", "MKD", 807, "+389"),
    Malta("Malta", "MT", "MLT", 470, "+356"),
    Moldova("Moldova", "MD", "LUX", 498, "+373"),
    Montenegro("Montenegro", "ME", "MNE", 499, "+382"),
    Netherlands("Netherlands", "NL", "NLD", 528, "+31"),
    Norway("Norway", "NO", "NOR", 578, "+47"),
    Poland("Poland", "PL", "POL", 616, "+48"),
    Portugal("Portugal", "PT", "PRT", 620, "+351"),
    Romania("Romania", "RO", "ROU", 642, "+40"),
    Serbia("Serbia", "RS", "SRB", 688, "+381"),
    Slovakia("Slovakia", "SK", "SVK", 703, "+421"),
    Slovenia("Slovenia", "SI", "SVN", 705, "+386"),
    Spain("Spain", "ES", "ESP", 724, "+34"),
    Sweden("Sweden", "SE", "SWE", 752, "+46"),
    Switzerland("Switzerland", "CH", "CHE", 756, "+41"),
    Ukraine("Ukraine", "UA", "UKR", 804, "+380"),
    UnitedKingdom("United Kingdom", "GB", "GBR", 826, "+44");

    // Short name in English
    public String name;

    // http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
    public String alpha2;

    // http://en.wikipedia.org/wiki/ISO_3166-1_alpha-3
    public String alpha3;

    // http://en.wikipedia.org/wiki/ISO_3166-1_numeric
    public int numeric;

    // https://en.wikipedia.org/wiki/List_of_country_calling_codes
    public String callingCode;

    Country(String name, String alpha2, String alpha3, int numeric, String callingCode) {
        this.name = name;
        this.alpha2 = alpha2;
        this.alpha3 = alpha3;
        this.numeric = numeric;
        this.callingCode = callingCode;
    }
}
