package com.kosa.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j2;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
public class DataSourceTests {
   
    @Autowired
    private DataSource dataSource;
   
    @Test
    public void testConnection() {          
        try {
            Connection con = dataSource.getConnection();
            log.info("connnnnnn 연결 : " + con);
        } catch (SQLException e) {
            fail(e.getMessage());
        }          
    }
}