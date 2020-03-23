package bookapi.auth.repositories;

import bookapi.auth.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepositiry extends JpaRepository<User, String> {

}
