package bookapi.auth.model;

import lombok.Getter;
import lombok.Setter;
import javax.persistence.Entity;
import javax.persistence.Id;
import org.jboss.aerogear.security.otp.api.Base32;

@Entity
@Getter
@Setter
public class User {

    @Id
    private String email;
    private String name;
    private String password;
    private boolean enabled;
    private String secret;

    public User() {
        this.secret = Base32.random();
        this.enabled = false;
    }

    @Override
    public boolean equals(final Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final User user = (User) obj;
        if (!email.equals(user.email)) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        final StringBuilder builder = new StringBuilder();
        builder.append("[firstName=")
                .append(name)
                .append(", email=")
                .append(email)
                .append(", password=")
                .append(password)
                .append(", enabled=")
                .append(enabled)
                .append(", secret=")
                .append(secret)
                .append("]");
        return builder.toString();
    }

}
