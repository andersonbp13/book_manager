package bookapi.controllers.resources;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserDTO {
    private String name;
    private String password;
    private String email;

    @Override
    public String toString() {
        final StringBuilder builder = new StringBuilder();
        builder.append(", firstName=")
                .append(name)
                .append(", email=")
                .append(email)
                .append(", password=")
                .append(password)
                .append("]");
        return builder.toString();
    }

}

