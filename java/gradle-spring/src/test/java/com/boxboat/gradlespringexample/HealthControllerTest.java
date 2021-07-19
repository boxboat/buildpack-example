package com.boxboat.gradlespringexample;

import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class HealthControllerTest {

    @Test
    public void testHealthCheck() {
        ResponseEntity<String> resp = new HealthController().healthCheck();
        assertEquals("Gradle Healthy", resp.getBody());
        assertEquals(HttpStatus.OK, resp.getStatusCode());
    }

}
