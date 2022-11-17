package com.song.spotifyback.controller;

import com.song.spotifyback.service.impl.MusicServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/music")
public class MusicController {
    @Autowired
    private final MusicServiceImpl musicService;

//    @ResponseBody
//    @RequestMapping("/all")
//    public ResponseEntity<List<Music>> getAllMusics(){
//       return ResponseEntity.ok(this.musicService.getMusics());
//    }
}
