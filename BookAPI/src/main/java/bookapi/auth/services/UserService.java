package bookapi.auth.services;

import bookapi.auth.adapters.UserAdapter;
import bookapi.auth.model.VerificationToken;
import bookapi.auth.repositories.VerificationTokenRepository;
import bookapi.auth.model.User;
import bookapi.auth.repositories.UserRepositiry;
import bookapi.controllers.resources.PasswordDTO;
import bookapi.controllers.resources.UserDTO;
import com.google.common.base.Preconditions;
import jdk.nashorn.internal.parser.JSONParser;
import org.jboss.aerogear.security.otp.api.Base32;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class UserService {
    public UserRepositiry userRepository;
    public VerificationTokenRepository verificationTokenRepository;
    public JavaMailSender mailSender;

    @Autowired
    public UserService(UserRepositiry userRepository, VerificationTokenRepository verificationTokenRepository, JavaMailSender mailSender) {
        this.userRepository = userRepository;
        this.verificationTokenRepository = verificationTokenRepository;
        this.mailSender = mailSender;
    }

    //registrar usuario √
    //confirmar usuario √

    public User saveUser(UserDTO userDTO, String appUrl) {
        Preconditions.checkArgument(!StringUtils.isEmpty(userDTO.getName()), "User name can not be empty.");
        Preconditions.checkArgument(!StringUtils.isEmpty(userDTO.getEmail()), "User e-mail can not be empty.");
        Preconditions.checkArgument(!StringUtils.isEmpty(userDTO.getPassword()), "User password can not be empty.");

        Preconditions.checkArgument(!userRepository.existsById(userDTO.getEmail()),"The user already exists.");

        User user = UserAdapter.convertToDAO(userDTO);
        userRepository.save(user);

        String token = UUID.randomUUID().toString();
        VerificationToken verificationToken = createVerificationToken(user, token);

        String recipientAddress = user.getEmail();
        String subject = "Registration Confirmation";
        String confirmationUrl = appUrl + "/user_confirm/" + token;
        String message = "Por favor confirmar oprimiendo en el siguiente enlace: ";

        SimpleMailMessage email = new SimpleMailMessage();
        email.setTo(recipientAddress);
        email.setSubject(subject);
        email.setText(message + "http://192.168.1.64:8080" + confirmationUrl);
        mailSender.send(email);

        return user;
    }

    public void confirmUser(String email) {
        Optional<User> optionalUser = userRepository.findById(email);
        User user = optionalUser.get();
        user.setEnabled(true);

        userRepository.save(user);
    }

    //CRUD functions

    public List<User> getUsers() {
        return userRepository.findAll();
    }

    public User getUser(String email) {
        Optional<User> user = userRepository.findById(email);
        Preconditions.checkArgument(user.isPresent(), "The user does not exists at data base");

        return user.get();
    }

    public void deleteUser(String email) {
        userRepository.deleteById(email);
        return;
    }

    public VerificationToken getVerificationToken(String VerificationToken) {
        return verificationTokenRepository.findByToken(VerificationToken);
    }

    public VerificationToken createVerificationToken(User user, String token) {
        VerificationToken myToken = new VerificationToken(token, user);
        verificationTokenRepository.save(myToken);
        return myToken;
    }

    public VerificationToken requestPasswordToken(String email) {
        Preconditions.checkArgument(!StringUtils.isEmpty(email), "User e-mail can not be empty.");
        System.out.println(email);
        Optional<User> userOptional = userRepository.findById(email);
        Preconditions.checkArgument(userOptional.isPresent(), "The user does not exists at data base");

        User user = userOptional.get();

        Preconditions.checkArgument(user.isEnabled()==true, "the user is not active.");

        String token = Base32.random();
        VerificationToken verificationToken = createVerificationToken(user, token);

        String recipientAddress = user.getEmail();
        String subject = "Change password";
        String message = "Por favor ingrese el siguiente código para cambiar su contraseña: " + token;

        SimpleMailMessage mail = new SimpleMailMessage();
        mail.setTo(recipientAddress);
        mail.setSubject(subject);
        mail.setText(message);
        mailSender.send(mail);

        return verificationToken;
    }

    public User changePassword(String email, PasswordDTO passwordDTO) {
        Preconditions.checkArgument(!StringUtils.isEmpty(passwordDTO.getPassword()), "new password can not be empty.");
        Preconditions.checkArgument(!StringUtils.isEmpty(passwordDTO.getToken()), "token can not be empty.");

        VerificationToken verificationToken = getVerificationToken(passwordDTO.getToken());
        User user = verificationToken.getUser();

        user.setPassword(passwordDTO.getPassword());

        userRepository.save(user);

        return user;
    }



}
