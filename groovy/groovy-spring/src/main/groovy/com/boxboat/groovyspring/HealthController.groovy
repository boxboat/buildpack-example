package com.boxboat.groovyspring

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/groovy")
class HealthController {

    @GetMapping(["/", "/health"])
    def healthCheck() {
        return "Just Groovy"
    }
}

