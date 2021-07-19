package com.boxboat.groovyspring

import org.junit.jupiter.api.Test

class HealthControllerTest {

    @Test
    void testHealthCheck() {
        def groovy = "Groovy Healthy"
        def resp = new HealthController().healthCheck()
        assert resp == groovy
    }
}

