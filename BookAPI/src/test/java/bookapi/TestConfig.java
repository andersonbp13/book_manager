package bookapi;

import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.datasource.embedded.EmbeddedDatabaseBuilder;
import org.springframework.jdbc.datasource.embedded.EmbeddedDatabaseType;

import javax.sql.DataSource;

@EnableAutoConfiguration
@ComponentScan(basePackages = "Hello")
public class TestConfig {

    @Bean
    @Primary
    public DataSource dataSource() {

        return new EmbeddedDatabaseBuilder()
                .setType(EmbeddedDatabaseType.HSQL)
                .addScript("classpath:database/maria-db-dialect.sql")
                .addScript("classpath:database/tables-db.sql")
                .generateUniqueName(true)
                .build();
    }
}