package bookapi.auth.adapters;

import bookapi.auth.model.User;
import bookapi.controllers.resources.UserDTO;

public class UserAdapter {
    public static User convertToDAO(UserDTO userDTO) {
        User user = new User();
        
        user.setName(userDTO.getName());
        user.setEmail(userDTO.getEmail());
        user.setPassword(userDTO.getPassword());

        return user;
    }
}
