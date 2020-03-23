package bookapi.controllers;

import bookapi.auth.model.VerificationToken;
import bookapi.auth.model.User;
import bookapi.auth.services.UserService;
import bookapi.controllers.resources.BookDTO;
import bookapi.controllers.resources.PasswordDTO;
import bookapi.controllers.resources.UserDTO;
import com.google.common.base.Preconditions;
import com.oracle.javafx.jmx.json.JSONReader;
import javassist.NotFoundException;
import jdk.nashorn.internal.parser.JSONParser;
import org.omg.CosNaming.NamingContextPackage.NotFound;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.data.repository.query.QueryMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import bookapi.services.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;

import java.util.Calendar;


@RestController
public class RequestController {

    private BookService bookService;
    private UserService userServices;
    private ApplicationEventPublisher eventPublisher;

/*
    @Autowired
    private IUserService service;

    @Autowired
    private MessageSource messages;
*/

    @Autowired //Le dice a Spring que llene esta variable con un bean que tenga almacenado
    public RequestController(BookService bookService, UserService userServices, ApplicationEventPublisher eventPublisher) {
        this.bookService = bookService;
        this.userServices = userServices;
        this.eventPublisher = eventPublisher;
    }


    //Book functions

    @RequestMapping(value = "/books", method = RequestMethod.GET)
    public ResponseEntity<?> getBooks() {
        return ResponseEntity.ok(bookService.findAllBooks());
    }

    @RequestMapping(value = "/books/{id}", method = RequestMethod.GET)
    public ResponseEntity<?> getBookById(@PathVariable("id") Long id) {
        Preconditions.checkArgument(id != null, "id is not valid.");
        return ResponseEntity.ok(bookService.findBookById(id));
    }

    @RequestMapping(value = "/books", method = RequestMethod.POST)
    public ResponseEntity<?> saveBook(@RequestBody BookDTO bookDTO) {
        Preconditions.checkArgument(bookDTO != null, "body is not valid.");
        return ResponseEntity.ok(bookService.saveBook(bookDTO));
    }

    @RequestMapping(value = "/books/{id}", method = RequestMethod.PUT)
    public ResponseEntity<?> updateBook(@PathVariable("id") Long id, @RequestBody BookDTO bookDTO) {
        Preconditions.checkArgument(id != null && bookDTO !=null, "id or body is not valid.");
        return ResponseEntity.ok(bookService.updateBook(bookDTO, id));
    }

    @RequestMapping(value = "/books/{id}", method = RequestMethod.DELETE)
    public ResponseEntity<?> deleteBook(@PathVariable("id") Long id) {
        Preconditions.checkArgument(id != null, "id is not valid.");
        return ResponseEntity.ok(bookService.deleteBook(id));
    }

    ///////User controller

    @RequestMapping(value = "/users", method = RequestMethod.GET)
    public ResponseEntity<?> getUsers() {
        return ResponseEntity.ok(userServices.getUsers());
    }

    @RequestMapping(value = "/users/{email}", method = RequestMethod.GET)
    public ResponseEntity<?> getUserById(@PathVariable("email") String email) {
        Preconditions.checkArgument(email != null, "email is not valid.");
        return ResponseEntity.ok(userServices.getUser(email));
    }

    @RequestMapping(value = "/users", method = RequestMethod.POST)
    public ResponseEntity<?> saveUser(@RequestBody UserDTO userDTO, WebRequest request) {
        Preconditions.checkArgument(userDTO != null, "body is not valid.");
        String appUrl = request.getContextPath();
        return ResponseEntity.ok(userServices.saveUser(userDTO, appUrl));
    }

    @RequestMapping(value = "/users/{email}", method = RequestMethod.DELETE)
    public ResponseEntity<?> deleteUser(@PathVariable("email") String email) {
        Preconditions.checkArgument(email != null, "email is not valid.");
        userServices.deleteUser(email);
        return ResponseEntity.ok().build();
    }

    @RequestMapping(value = "/user_confirm/{token}", method = RequestMethod.GET)
    public ResponseEntity<?> confirmUser(@PathVariable("token") String token){

        VerificationToken verificationToken = userServices.getVerificationToken(token);
        if (verificationToken == null) {
            return ResponseEntity.badRequest().build();
        }

        User user = verificationToken.getUser();
        Calendar cal = Calendar.getInstance();
        if ((verificationToken.getExpiryDate().getTime() - cal.getTime().getTime()) <= 0) {
            return ResponseEntity.badRequest().build();
        }

        user.setEnabled(true);
        userServices.confirmUser(user.getEmail());
        return ResponseEntity.ok().build();
    }

    @RequestMapping(value = "/request_password_token", method = RequestMethod.POST)
    public ResponseEntity<?> requestPassworToken(@RequestBody String email) {
        Preconditions.checkArgument(!StringUtils.isEmpty(email), "body is not valid.");
        return ResponseEntity.ok(userServices.requestPasswordToken(email));
    }

    @RequestMapping(value = "/change_password/{email}", method = RequestMethod.PUT)
    public ResponseEntity<?> changePassword(@RequestBody PasswordDTO passwordDTO, @PathVariable("email") String email) {
        Preconditions.checkArgument(passwordDTO != null, "body is not valid.");
        return ResponseEntity.ok(userServices.changePassword(email, passwordDTO));
    }
}
