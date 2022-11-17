package com.song.spotifyback.controller;

import com.song.spotifyback.service.impl.ArtistServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/artist")
public class ArtistController {
    @Autowired
    private final ArtistServiceImpl artistService;
//
//    @ResponseBody
//    @RequestMapping("/all")
//    public ResponseEntity<List<Artist>> getAllArtists(){
//        return ResponseEntity.ok(this.artistService.findAllArtists());
//    }

}
