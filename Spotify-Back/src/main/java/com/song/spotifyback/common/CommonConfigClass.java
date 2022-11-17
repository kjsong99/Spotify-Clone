package com.song.spotifyback.common;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

public class CommonConfigClass {
    @RequestMapping(method = RequestMethod.OPTIONS)
    ResponseEntity<?> options() {
        // @formatter:off
        return ResponseEntity.ok().allow(
                        HttpMethod.GET,
                        HttpMethod.POST,
                        HttpMethod.HEAD,
                        HttpMethod.OPTIONS,
                        HttpMethod.PUT,
                        HttpMethod.DELETE).
                build();
        // @formatter:on
    }
}
