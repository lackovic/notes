import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class FixturesBuilder {

    public static final String COUNTRY_CODE = "EE";
    public static final String EMAIL = "gabriel@reliikvia.ee";
    public static final String PHONE_NUMBER = "+37212341234";
    public static final String NAME = "Gabriel";

    // Assumes Person is annotated with Lombok @Builder
    public static Person.PersonBuilder aPerson() {
        return Person.builder()
                .name(NAME)
                .countryCode(COUNTRY_CODE)
                .email(EMAIL)
                .phoneNumber(PHONE_NUMBER);
    }

    public static Person.PersonBuilder aMan() {
        return aPerson().gender(1);
    }
}
