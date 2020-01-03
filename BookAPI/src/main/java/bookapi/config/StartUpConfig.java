package bookapi.config;

import bookapi.model.Book;
import bookapi.repositories.BookRepository;
import bookapi.services.GeneralServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.ArrayList;
import java.util.List;

@Configuration
public class StartUpConfig {
    @Autowired
    private GeneralServices generalServices;

    private List<String> authorList;
    private List<String> imageURLs;
    private List<String> genderList;

   /* @Bean
    public CommandLineRunner demo(BookRepository bookRepository) {
        return (args) -> {
            authorList = new ArrayList<String>();
            imageURLs = new ArrayList<String>();
            genderList = new ArrayList<String>();
            CreateAuthors();
            CreateURLs();
            CreateGenders();
            CreateBooks(bookRepository);
        };
    }*/

    private void CreateGenders() {
        genderList.add("Horror");
        genderList.add("Science fiction");
        genderList.add("Novel");
        genderList.add("Fairy tale");
        genderList.add("Romance");
    }

    private void CreateURLs() {
        imageURLs.add("https://st3.depositphotos.com/5792148/15239/v/1600/depositphotos_152397386-stock-illustration-cartoon-business-book-waving.jpg");
        imageURLs.add("https://image.freepik.com/vector-gratis/libro-gris-pie-vector-blanco_33869-96.jpg");
        imageURLs.add("https://image.shutterstock.com/image-photo/old-book-vintage-cover-260nw-573832429.jpg");
        imageURLs.add("https://img1.freepng.es/20180211/pze/kisspng-book-icon-black-gold-ancient-books-5a81061ef0ac93.1930204115184051509858.jpg");
        imageURLs.add("https://cloud10.todocoleccion.online/relojes-sobremesa-carga-manual/tc/2013/09/16/39037309.jpg");
        imageURLs.add("https://cdn.icon-icons.com/icons2/1632/PNG/512/62860greenbook_109281.png");
        imageURLs.add("https://www.stickpng.com/assets/images/580b585b2edbce24c47b276b.png");
        imageURLs.add("http://www3.gobiernodecanarias.org/medusa/mediateca/ecoescuela/wp-content/uploads/sites/2/2013/11/11-Libro.png");
        imageURLs.add("https://images.vexels.com/media/users/3/153719/isolated/preview/3a310ffc1a26ffccf33f9cc485984d97-icono-de-tapa-dura-libro-by-vexels.png");
        imageURLs.add("https://static8.depositphotos.com/1007989/954/i/450/depositphotos_9548893-stock-photo-book-mascot.jpg");
    }

    private void CreateAuthors() {
        authorList.add("pirso");
        authorList.add("kiru");
        authorList.add("junae");
        authorList.add("genara");
        authorList.add("kitakuru");
    }


    private void CreateBooks(BookRepository bookRepository) {
        for (int i = 0; i<10; i++) {
            bookRepository.save(new Book("the hystory of the number " + i,
                    authorList.get(generalServices.getRandomNumber(4)),
                    generalServices.getRandomNumber(99999F),
                    imageURLs.get(i) ,
                    genderList.get(generalServices.getRandomNumber(4))));
        }
        System.out.println("repositorio creado//////////////////////////////////////////////////");
    }
}
